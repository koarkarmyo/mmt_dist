import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/model/language_model.dart';
import 'package:mmt_mobile/model/login_response.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../model/employee.dart';
import '../model/odoo_session.dart';
import 'enum.dart';

class MMTApplication {
  // Server
  // static const String serverUrl = 'http://217.15.166.234:8069';

  static String serverUrl = '';
  static Employee? currentUser;
  static Company? selectedCompany;

  static List<String> databaseList = [];
  static String loginDatabase = 'htz_db';
  static Session? session;
  static List<LanguageModel?> languageList = [];
  static LoginResponse? loginResponse;

  static ValueNotifier<LanguageCode> languageNotifier =
      ValueNotifier(LanguageCode.eng);

  static int qtyDigit = loginResponse?.deviceId?.qtyDigit ?? 0;
  static int priceDigit = loginResponse?.deviceId?.priceDigit ?? 0;
}
