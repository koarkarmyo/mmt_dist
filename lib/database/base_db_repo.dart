import 'package:mmt_mobile/database/database_helper.dart';

import 'data_object.dart';
import 'db_constant.dart';

abstract class BaseDBRepo {
  final DataObject dataObject;
  final DatabaseHelper helper;

  BaseDBRepo()
      : dataObject = DataObject.instance,
        helper = DatabaseHelper.instance;

  String addAnd(String query) {
    return query.isEmpty ? query : ' AND ';
  }

  Future<bool> setUpload(String table, dynamic where, List arg) {
    return helper.updateData(table: table, where: where, whereArgs: arg, data: {
      DBConstant.isUpload: 1,
    });
  }
}
