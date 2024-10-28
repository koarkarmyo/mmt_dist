import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../api/api_repo/login_api_repo.dart';
import '../../../database/database_helper.dart';
import '../../../database/db_constant.dart';
import '../../../model/employee.dart';
import '../../../model/odoo_session.dart';
import '../../../sync/models/sync_action.dart';
import '../../../share_preference/sh_keys.dart';
import '../../../share_preference/sh_utils.dart';
import '../../../src/mmt_application.dart';
import '../../../sync/models/sync_group.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(status: LoginStatus.initial)) {
    on<UserLoginEvent>(_loginUser);
    on<LoginSessionCheckEvent>(_sessionCheck);
    on<EmployeeLoginEvent>(_loginEmployee);
  }

  FutureOr<void> _loginUser(
      UserLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await LoginApiRepo().loginProcess(
          name: event.username, password: event.password, db: event.database);
      emit(state.copyWith(status: LoginStatus.success));
    } on DioException catch (e) {
      emit(state.copyWith(status: LoginStatus.fail));
    } on OdooException catch (e) {
      emit(state.copyWith(status: LoginStatus.fail));
    } on Exception catch (e) {
      emit(state.copyWith(status: LoginStatus.fail));
    }
    await Future.delayed(1.second);
    emit(state.copyWith(status: LoginStatus.initial));
  }

  FutureOr<void> _loginEmployee(
      EmployeeLoginEvent event, Emitter<LoginState> emit) async {
    print('SESSION::::${MMTApplication.session?.toJson()}');

    emit(state.copyWith(status: LoginStatus.loading));
    try {
      Employee? employee = await LoginApiRepo()
          .employeeLogin(username: event.username, password: event.password);

      print("Login User : ${employee?.toJson()}");

      if (employee == null) {
        emit(state.copyWith(status: LoginStatus.fail));
        await Future.delayed(1.second);
        emit(state.copyWith(status: LoginStatus.initial));
      } else {
        MMTApplication.currentUser = employee;
        SharePrefUtils()
            .saveString(ShKeys.currentUser, jsonEncode(employee.toJson()));
        bool _saveSyncActionSuccess = await _saveSyncAction(
            syncActionList: employee.syncActionList ?? []);
        if (!_saveSyncActionSuccess) {
          emit(state.copyWith(
              status: LoginStatus.fail, error: "Sync Action Save Fail"));
        } else {
          emit(state.copyWith(status: LoginStatus.success));
        }
      }
    } on DioException {
      _emitFail();
    } on OdooException {
      _emitFail();
    } on Error {
      _emitFail();
    }
  }

  Future<bool> _saveSyncAction(
      {required List<SyncAction> syncActionList}) async {
    try {
      List<Map<String, dynamic>> syncActionMapList = [];
      List<Map<String, dynamic>> syncGroupMapList = [];
      syncActionList.forEach(
        (element) {
          syncActionMapList.add(element.toJson());
          for (SyncActionGroup syncGroup in element.actionGroup ?? []) {
            syncGroupMapList.add(syncGroup.toJson());
          }
        },
      );
      bool syncActionSuccess = await DatabaseHelper.instance
          .insertDataListBath(DBConstant.syncActionTable, syncActionMapList);
      bool syncGroupSuccess = await DatabaseHelper.instance.insertDataListBath(
          DBConstant.syncActionGroupTable, syncGroupMapList);
      return syncActionSuccess && syncGroupSuccess;
    } on Exception {
      return false;
    }
  }

  FutureOr<void> _sessionCheck(
      LoginSessionCheckEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      String? url = await SharePrefUtils().getString(ShKeys.serverUrlKey);
      if (url == null) {
        Future.delayed(2.second).then((value) => _emitFail());
        return;
      }
      MMTApplication.serverUrl = url;
      String? sessionKey = await SharePrefUtils().getString(ShKeys.sessionKey);
      // print("Session : $sessionKey");
      bool getSuccess = await _getFromSharedPreference();
      if (sessionKey != null) {
        Map<String, dynamic> data = await json.decode(sessionKey);
        MMTApplication.session = Session.fromJson(data);
        // add the session id to the request
        (getSuccess)
            ? emit(state.copyWith(status: LoginStatus.success))
            : _emitFail();
      } else {
        Future.delayed(2.second).then((value) => _emitFail());
        // _emitFail();
      }
    } on Exception {
      Future.delayed(2.second).then((value) => _emitFail());
    }
    // on Error {
    //   _emitFail();
    // }
  }

  Future<bool> _getFromSharedPreference() async {
    MMTApplication.loginDatabase =
        await SharePrefUtils().getString(ShKeys.loginDatabase) ?? 'hmo_db';
    String? userString = await SharePrefUtils().getString(ShKeys.currentUser);
    print(
        "Login DB : ${MMTApplication.loginDatabase} : Login User : $userString");
    if (userString != null) {
      MMTApplication.currentUser = Employee.fromJson(jsonDecode(userString));
      return true;
    }
    return false;
  }

  void _emitFail({String? error}) async {
    emit(state.copyWith(status: LoginStatus.fail, error: error));
    Future.delayed(1.second).then((value) {
      emit(state.copyWith(status: LoginStatus.initial));
    });
  }
}
