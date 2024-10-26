import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'db_constant.dart';

class DatabaseHelper {
  static final String _databaseName = DBConstant.dbName;
  static const _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: _onCreateDatabase);
  }

  Future<bool> insertData({required String table, required Map<String,dynamic> values}) async{
    int? id =  await  _database?.insert(table, values);
    return id != null;
  }

  Future<bool> insertDataListBath(
      String tableName, List<Map<String, dynamic>> list) async {
    Database db = await database;
    Batch batch = db.batch();
    for (Map<String, dynamic> row in list) {
      batch.insert(tableName, row);
    }
    final affectedRows = await batch.commit();
    return affectedRows.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> readAllData(
      {required String tableName, String? orderBy}) async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
    await db.query(tableName, orderBy: orderBy);
    return maps;
  }
  Future<List<Map<String, dynamic>>> readDataRaw(String query) async {
    Database db = await database;
    List<Map<String, dynamic>> list = await db.rawQuery(query);
    return list;
  }

  Future<List<Map<String, dynamic>>> readDataByWhereArgs(
      {required String tableName,
        List<String>? columns,
        required String where,
        int? limit,
        String? orderBy,
        required List<dynamic> whereArgs}) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: columns,
        where: '$where',
        whereArgs: whereArgs,
        limit: limit,
        orderBy: orderBy);
    return maps;
  }

  Future<bool> updateData(
      {required String table,
        required String where,
        required List<dynamic> whereArgs,
        required Map<String, dynamic> data}) async {
    Database db = await database;
    final re = await db.update(table, data, where: where, whereArgs: whereArgs);
    return re > 0 ? true : false;
  }

  Future<String> getLastWriteDate({required String actionName}) async {
    Database db = await database;
    List<Map<String, dynamic>> list = await db.query(
        DBConstant.syncHistoryTable,
        where: '${DBConstant.actionName} = ?',
        whereArgs: [actionName],
        limit: 1);
    return list.isEmpty
        ? '2021-03-23 13:34:12'
        : list.first[DBConstant.writeDate];
  }

  _onCreateDatabase(Database db, int version) async {
    await _createProductTable(db);
  }

  _createProductTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.productTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.productId} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.categId} INTEGER,'
        '${DBConstant.categName} TEXT,'
        '${DBConstant.looseUomId} INTEGER,'
        '${DBConstant.looseUomName} TEXT,'
        '${DBConstant.uomCategoryId} INTEGER,'
        '${DBConstant.boxUomId} INTEGER,'
        '${DBConstant.boxUomName} TEXT,'
        '${DBConstant.listPrice} DOUBLE,'
        '${DBConstant.defaultCode} TEXT,'
        '${DBConstant.detialType} TEXT,'
        '${DBConstant.barcode} TEXT,'
        '${DBConstant.image128} TEXT,'
        '${DBConstant.image512} TEXT,'
        '${DBConstant.serviceProductType} TEXT,'
        '${DBConstant.active} INTEGER,'
        '${DBConstant.productGroupId} INTEGER,'
        '${DBConstant.saleUomId} INTEGER,'
        '${DBConstant.saleUomName} TEXT,'
        '${DBConstant.saleOK} TEXT,'
        '${DBConstant.purchaseOK} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }
}