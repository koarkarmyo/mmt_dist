import 'package:mmt_mobile/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'data_object.dart';

abstract class BaseDBRepo {
  final DataObject dataObject;
  final DatabaseHelper helper;

  BaseDBRepo()
      : dataObject = DataObject.instance,
        helper = DatabaseHelper.instance;
}
