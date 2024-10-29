import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/model/language_model.dart';
import 'package:mmt_mobile/model/login_response.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../model/employee.dart';
import '../../route/route_list.dart';
import '../model/odoo_session.dart';
import 'enum.dart';

class MMTApplication {
  // Server
  // static const String serverUrl = 'http://217.15.166.234:8069';

  static String serverUrl = 'http://192.168.1.24:8016';
  static Employee? currentUser;
  static Company? selectedCompany;

  static List<String> databaseList = [];
  static String loginDatabase = 'htz_db';
  static Session? session;
  static List<LanguageModel?> languageList = [];
  static LoginResponse? loginResponse;

  static ValueNotifier<LanguageCode> languageNotifier =
      ValueNotifier(LanguageCode.eng);
}
