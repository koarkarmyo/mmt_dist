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
        MMTApplication.currentUser?.useLooseBox =
            employee.companyList?.firstOrNull?.useLooseUom == true;
        SharePrefUtils()
            .saveString(ShKeys.currentUser, jsonEncode(employee.toJson()));
        bool _saveSyncActionSuccess = await _saveSyncAction(
            syncActionList: employee.syncActionList ?? []);
        print("Save Sync Action : $_saveSyncActionSuccess");
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
    if (syncActionList.isEmpty) {
      return true;
    }
    try {
      List<Map<String, dynamic>> actionJson = [];
      List<Map<String, dynamic>> groupList = [];
      List<Map<String, dynamic>> actionWithGroupJsonList = [];
      syncActionList.forEach((element) {
        actionJson.add(element.toJson());

        for (SyncActionGroup actionGroup in element.actionGroup ?? []) {
          Map<String, dynamic> actionJson = {};
          int index = groupList
              .indexWhere((element) => element['id'] == actionGroup.id);
          if (index <= -1) {
            groupList.add(actionGroup.toJson());
          }
          actionJson['action_id'] = element.id;
          actionJson['action_name'] = element.name;
          actionJson['action_group_id'] = actionGroup.id;
          actionJson['action_group_name'] = actionGroup.name;
          actionWithGroupJsonList.add(actionJson);
        }
      });

      await DatabaseHelper.instance.deleteRows(
          tableName: DBConstant.syncActionTable,
          where: DBConstant.id,
          wantDeleteRow: syncActionList
              .map(
                (e) => e.id,
              )
              .toList());
      await DatabaseHelper.instance.deleteRows(
          tableName: DBConstant.syncActionWithGroupTable,
          where: DBConstant.actionId,
          wantDeleteRow: actionWithGroupJsonList
              .map(
                (e) => e['action_id'],
              )
              .toList());
      await DatabaseHelper.instance.deleteRows(
          tableName: DBConstant.syncActionGroupTable,
          where: DBConstant.id,
          wantDeleteRow: groupList
              .map(
                (e) => e[DBConstant.id],
              )
              .toList());

      bool syncActionSuccess = await DatabaseHelper.instance
          .insertDataListBath(DBConstant.syncActionTable, actionJson);
      bool syncGroupSuccess = await DatabaseHelper.instance
          .insertDataListBath(DBConstant.syncActionGroupTable, groupList);
      bool syncGroupActionSuccess = await DatabaseHelper.instance
          .insertDataListBath(
              DBConstant.syncActionWithGroupTable, actionWithGroupJsonList);

      return syncActionSuccess && syncGroupSuccess && syncGroupActionSuccess;
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
      String? currentUser =
          await SharePrefUtils().getString(ShKeys.currentUser);
      // print("Session : $sessionKey");
      bool getSuccess = await _getFromSharedPreference();
      if (sessionKey != null) {
        Map<String, dynamic> data = await json.decode(sessionKey);
        MMTApplication.session = Session.fromJson(data);
      }
      if (currentUser != null) {
        Map<String, dynamic> data = await json.decode(currentUser);
        MMTApplication.currentUser = Employee.fromJson(data);
        MMTApplication.currentUser?.useLooseBox =
            MMTApplication.currentUser?.companyList?.firstOrNull?.useLooseUom ==
                true;
      }
      if (currentUser != null && sessionKey != null) {
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
