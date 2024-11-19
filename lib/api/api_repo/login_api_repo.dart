import 'dart:convert';

import 'package:dio/dio.dart';

import '../../model/employee.dart';
import '../../model/odoo_session.dart';
import '../../share_preference/sh_keys.dart';
import '../../share_preference/sh_utils.dart';
import '../../src/mmt_application.dart';
import '../base_api_repo.dart';

class LoginApiRepo extends BaseApiRepo {
  static final LoginApiRepo _loginApiRepo = LoginApiRepo._();
  final SharePrefUtils sharePrefUtils = SharePrefUtils();

  LoginApiRepo._();

  factory LoginApiRepo() {
    return _loginApiRepo;
  }

  Future<void> loginProcess(
      {required String name,
      required String password,
      required String db}) async {
    Response response = await postMethodCall(
        additionalPath: '/web/session/authenticate',
        params: {'db': db, 'login': name, 'password': password});

    // MMTApplication.odooSession = CustomOdooSession.fromJson(response.data);
    // MMTApplication.odooSession?.session =
    MMTApplication.session =
        Session.fromCookieString(response.headers['set-cookie']?.first ?? '');

    // DioProvider().dio.options.headers['Cookie'] =
    //     'session_id=${MMTApplication.session?.sessionId}';
    Map<String, dynamic>? data = MMTApplication.session?.toJson();

    await sharePrefUtils.saveString(ShKeys.sessionKey, json.encode(data));
  }

  Future<Employee?> employeeLogin(
      {required String username, required String password}) async {
    Response response = await postApiMethodCall(
        additionalPath: '/employee/login',
        params: {'username': username, 'password': password});

    Employee? loginEmployee =
        Employee.fromJson(response.data['data'] as Map<String, dynamic>);

    print("Login Employee : ${loginEmployee.toJson()}");

    return loginEmployee;
  }

  Future<List<String>> fetchDatabases() async {
    List<String> databaseList = [];

    Response response = await postMethodCall(
        additionalPath: '/jsonrpc/',
        params: {"method": "list", "service": "db", "args": {}});

    for (var element in (response.data['result'] as List<dynamic>)) {
      databaseList.add(element as String);
    }
    return databaseList;
  }
}
