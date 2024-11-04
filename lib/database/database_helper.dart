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
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateDatabase);
  }

  Future<bool> insertData(
      {required String table, required Map<String, dynamic> values}) async {
    int? id = await _database?.insert(table, values);
    return id != null;
  }

  Future deleteAllRow({required String tableName}) async {
    Database db = await database;
    if (db.isOpen) {
      int affectedRow = await db.delete(tableName);
      return affectedRow;
    } else
      return 0;
  }

  Future<bool> deleteRows(
      {required String tableName,
      required String where,
      required List wantDeleteRow}) async {
    Database db = await database;
    // db.rawQuery('DELETE FROM $tableName WHERE $where IN ($wantDeleteRow)');
    int affectedRow = await db.delete(tableName,
        where:
            '$where IN (${List.filled(wantDeleteRow.length, '?').join(',')})',
        whereArgs: wantDeleteRow);

    print("Deleted rows : $affectedRow : $tableName");

    return affectedRow == wantDeleteRow.length;
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

  Future<String?> getLastWriteDate({required String actionName}) async {
    Database db = await database;
    List<Map<String, dynamic>> list = await db.query(
        DBConstant.syncHistoryTable,
        where: '${DBConstant.actionName} = ?',
        whereArgs: [actionName],
        limit: 1);
    return list.isEmpty ? null : list.first[DBConstant.writeDate];
  }

  _onCreateDatabase(Database db, int version) async {
    await _createProductTable(db);
    await _createSyncActionTable(db);
    await _createSyncGroupTable(db);
    await _createSyncActionLinkWithGroupTable(db);
    await _createSyncHistoryTable(db);
    await _createChildCategoryTable(db);
    await _createCategoryTable(db);
    await _createSaleOrderHeaderTable(db);
    await _createSaleOrderLineTable(db);
    await _createProductUomTable(db);
    await _createStockLocationTable(db);
    await _createResPartnerTable(db);
    await _createCurrencyTable(db);
    await _createRouteTable(db);
    await _createRouteLineTable(db);
    await _createDashboardTable(db);
    await _createCustomerDashboardTable(db);
    await _createPriceListItemTable(db);
  }

  _createPriceListItemTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.priceListItemTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.priceListId} INTEGER,'
        '${DBConstant.priceListName} TEXT,'
        '${DBConstant.productTemplId} INTEGER,'
        '${DBConstant.productTmplName} TEXT,'
        '${DBConstant.productUom} INTEGER,'
        '${DBConstant.productUomName} TEXT,'
        '${DBConstant.categId} INTEGER,'
        '${DBConstant.minQuantity} DOUBLE,'
        '${DBConstant.priceDiscount} DOUBLE,'
        '${DBConstant.fixedPrice} DOUBLE,'
        '${DBConstant.dateStart} TEXT,'
        '${DBConstant.dateEnd} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createProductUomTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.productUomTable} '
        '(${DBConstant.uomId} INTEGER,'
        '${DBConstant.productId} INTEGER,'
        '${DBConstant.uomName} TEXT,'
        '${DBConstant.uomType} TEXT,'
        '${DBConstant.ratio} DOUBLE,'
        '${DBConstant.uomCategoryId} INTEGER,'
        '${DBConstant.uomCategoryName} TEXT'
        ')');
  }

  _createRouteTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.routeTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.dateStart} TEXT,'
        '${DBConstant.routeName} TEXT,'
        '${DBConstant.routeId} INTEGER,'
        '${DBConstant.saleManId} INTEGER,'
        '${DBConstant.saleManName} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createResPartnerTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.resPartnerTable} '
        '(${DBConstant.id} INTEGER PRIMARY KEY,' // Assuming id is the primary key
        '${DBConstant.name} TEXT,'
        '${DBConstant.street} TEXT,' // Changed to TEXT to fit the model
        '${DBConstant.stateId} INTEGER,'
        '${DBConstant.stateName} TEXT,'
        '${DBConstant.city} TEXT,' // Changed to TEXT to fit the model
        '${DBConstant.countryId} INTEGER,'
        '${DBConstant.countryName} TEXT,'
        '${DBConstant.companyId} INTEGER,'
        '${DBConstant.companyName} TEXT,'
        '${DBConstant.zip} TEXT,'
        '${DBConstant.phone} TEXT,'
        '${DBConstant.mobile} TEXT,'
        '${DBConstant.writeDate} TEXT,'
        '${DBConstant.partnerSaleType} TEXT'
        // Store writeDate as TEXT for easy date formatting
        ')');
  }

  Future<void> _createSyncHistoryTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.syncHistoryTable} '
        '(${DBConstant.actionName} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createDashboardTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.dashboardTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.dashboardId} INTEGER,'
        '${DBConstant.icon} TEXT,'
        '${DBConstant.isFolder} INTEGER,'
        '${DBConstant.actionUrl} TEXT,'
        '${DBConstant.parentId} INTEGER,'
        '${DBConstant.priority} INTEGER,'
        '${DBConstant.solutionId} TEXT,'
        '${DBConstant.parentUrl} TEXT,'
        '${DBConstant.dashboardName} TEXT,'
        '${DBConstant.writeDate} TEXT,'
        '${DBConstant.staffRoleId} INTEGER,'
        '${DBConstant.description} TEXT,'
        '${DBConstant.staffRoleName} TEXT,'
        '${DBConstant.dashboardTableGroupId} INTEGER,'
        '${DBConstant.dashboardTableGroupName} TEXT'
        ')');
  }

  _createCustomerDashboardTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.customerDashboardTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.dashboardId} INTEGER,'
        '${DBConstant.icon} TEXT,'
        '${DBConstant.isFolder} INTEGER,'
        '${DBConstant.actionUrl} TEXT,'
        '${DBConstant.parentId} INTEGER,'
        '${DBConstant.priority} INTEGER,'
        '${DBConstant.solutionId} TEXT,'
        '${DBConstant.parentUrl} TEXT,'
        '${DBConstant.dashboardName} TEXT,'
        '${DBConstant.writeDate} TEXT,'
        '${DBConstant.staffRoleId} INTEGER,'
        '${DBConstant.description} TEXT,'
        '${DBConstant.staffRoleName} TEXT,'
        '${DBConstant.dashboardTableGroupId} INTEGER,'
        '${DBConstant.dashboardTableGroupName} TEXT'
        ')');
  }

  _createStockLocationTable(Database db) async {
    return await db.execute('''
      CREATE TABLE ${DBConstant.stockLocationTable} (
        ${DBConstant.id} INTEGER PRIMARY KEY,
        ${DBConstant.name} TEXT,
        ${DBConstant.locationId} INTEGER,
        ${DBConstant.locationName} TEXT,
        ${DBConstant.companyId} INTEGER,
        ${DBConstant.companyName} TEXT,
        ${DBConstant.removalStrategyId} INTEGER,
        ${DBConstant.removalStrategyName} TEXT,
        ${DBConstant.usage} TEXT,
        ${DBConstant.scrapLocation} INTEGER,
        ${DBConstant.returnLocation} INTEGER,
        ${DBConstant.replenishLocation} INTEGER,
        ${DBConstant.writeDate} TEXT
      )
    ''');
  }

  _createProductTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.productTable} '
        '(${DBConstant.id} INTEGER,'
        // '${DBConstant.productId} INTEGER,'
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

  _createRouteLineTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.routeLineTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.routePlanId} INTEGER,'
        '${DBConstant.number} INTEGER,'
        '${DBConstant.sequence} INTEGER,'
        '${DBConstant.partnerId} INTEGER,'
        '${DBConstant.routePlanName} TEXT,'
        '${DBConstant.partnerName} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createSyncActionTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.syncActionTable}'
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.isAutoSync} INTEGER,'
        '${DBConstant.priority} INTEGER,'
        '${DBConstant.iSManualSync} INTEGER,'
        '${DBConstant.isUpload} INTEGER,'
        '${DBConstant.description} TEXT,'
        '${DBConstant.syncLimit} INTEGER, '
        '${DBConstant.solutionId} TEXT'
        ')');
  }

  _createSyncActionLinkWithGroupTable(Database db) async {
    return await db
        .execute('CREATE TABLE ${DBConstant.syncActionWithGroupTable}'
            '(${DBConstant.actionId} INTEGER,'
            '${DBConstant.actionName} TEXT,'
            '${DBConstant.actionGroupID} INTEGER,'
            '${DBConstant.actionGroupName} TEXT'
            ')');
  }

  _createCurrencyTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.currencyTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.fullName} TEXT,'
        '${DBConstant.rate} DOUBLE,'
        '${DBConstant.symbol} TEXT,'
        '${DBConstant.decimalPlaces} INTEGER,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createSyncGroupTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.syncActionGroupTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT'
        ')');
  }

  _createCategoryTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.categoryTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.completeName} TEXT,'
        '${DBConstant.parentId} INTEGER,'
        '${DBConstant.parentName} TEXT,'
        '${DBConstant.parentPath} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createChildCategoryTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.childCategoryTable} '
        '(${DBConstant.parentId} INTEGER,'
        '${DBConstant.childId} INTEGER'
        ')');
  }

  _createSaleOrderHeaderTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.saleOrderTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.partnerId} INTEGER,'
        '${DBConstant.partnerName} TEXT,'
        '${DBConstant.salePerson} INTEGER,'
        '${DBConstant.vehicleId} INTEGER,'
        '${DBConstant.isUpload} INTEGER,'
        '${DBConstant.amountTotal} DOUBLE,'
        '${DBConstant.dateOrder} TEXT,'
        '${DBConstant.origin} TEXT,'
        '${DBConstant.clientOrderRef} TEXT,'
        '${DBConstant.reference} TEXT,'
        '${DBConstant.state} TEXT,'
        '${DBConstant.validityDate} TEXT,'
        '${DBConstant.isExpired} INTEGER,'
        '${DBConstant.requireSignature} INTEGER,'
        '${DBConstant.requirePayment} TEXT,'
        '${DBConstant.invoiceStatus} TEXT,'
        '${DBConstant.note} TEXT,'
        '${DBConstant.remark} TEXT,'
        '${DBConstant.amountTax} TEXT,'
        '${DBConstant.batchNo} INTEGER,'
        '${DBConstant.batchName} TEXT,'
        '${DBConstant.signature} TEXT,'
        '${DBConstant.signedBy} TEXT,'
        '${DBConstant.signedOn} TEXT,'
        '${DBConstant.writeDate} TEXT,'
        '${DBConstant.pickingNo} TEXT,'
        '${DBConstant.commitmentDate} TEXT,'
        '${DBConstant.deliveryStatus} TEXT,'
        '${DBConstant.fromDirectSale} INTEGER,'
        '${DBConstant.saleOrderTypeId} INTEGER,'
        '${DBConstant.saleOrderTypeName} TEXT,'
        '${DBConstant.latitude} DOUBLE,'
        '${DBConstant.longitude} DOUBLE,'
        '${DBConstant.pickingState} TEXT'
        ')');
  }

  _createSaleOrderLineTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.saleOrderLineTable} '
        '(${DBConstant.productId} INTEGER,'
        '${DBConstant.id} INTEGER,'
        '${DBConstant.productName} TEXT,'
        '${DBConstant.orderNo} TEXT,'
        '${DBConstant.orderId} INTEGER,'
        '${DBConstant.saleType} TEXT,'
        '${DBConstant.productUomQty} DOUBLE,'
        '${DBConstant.productTemplateId} INTEGER,'
        '${DBConstant.qtyDelivered} DOUBLE,'
        '${DBConstant.qtyInvoiced} DOUBLE,'
        '${DBConstant.productUom} INTEGER,'
        '${DBConstant.productUomName} TEXT,'
        '${DBConstant.priceUnit} DOUBLE,'
        '${DBConstant.discount} DOUBLE,'
        '${DBConstant.priceSubtotal} DOUBLE'
        ')');
  }
}
