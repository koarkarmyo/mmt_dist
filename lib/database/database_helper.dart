import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    Sqflite.devSetDebugModeOn(true);
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreateDatabase);
  }

  Future<int?> insertData(
      {required String table, required Map<String, dynamic> values}) async {
    int? id = await _database?.insert(table, values);
    return id;
  }

  Future deleteAllRow({required String tableName}) async {
    Database db = await database;
    if (db.isOpen) {
      int affectedRow = await db.delete(tableName);
      return affectedRow;
    } else {
      return 0;
    }
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
    //
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

  Future<List<Map<String, dynamic>>> readRowsWhereIn(
      {required String tableName,
      required String where,
      required List queryValues}) async {
    Database db = await database;
    return db.query(tableName,
        where: '$where IN (${List.filled(queryValues.length, '?').join(',')})',
        whereArgs: queryValues);
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
        where: where,
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
    await _createNumberSeriesTable(db);
    await _createProductTemplateTable(db);
    await _createSyncActionTable(db);
    await _createSyncGroupTable(db);
    await _createSyncActionLinkWithGroupTable(db);
    await _createSyncHistoryTable(db);
    await _createChildCategoryTable(db);
    await _createCategoryTable(db);
    await _createJournalListTable(db);
    await _createSaleOrderHeaderTable(db);
    await _createSaleOrderLineTable(db);
    await _createProductUomTable(db);
    await _createUomTable(db);
    await _createStockLocationTable(db);
    await _createResPartnerTable(db);
    await _createCurrencyTable(db);
    await _createRouteTable(db);
    await _createRouteLineTable(db);
    await _createDashboardTable(db);
    await _createCompanyTable(db);
    await _createCustomerDashboardTable(db);
    await _createPriceListItemTable(db);
    await _createUomCategoryTable(db);
    await _createCustVisitTable(db);
    await _createPromotion(db);
    // secondary sale
    await _createSecondarySaleOrderHeaderTable(db);
  }

  _createCustVisitTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.custVisitTable} '
        '(${DBConstant.docDate} TEXT,'
        '${DBConstant.docType} TEXT,'
        '${DBConstant.docNo} TEXT,'
        '${DBConstant.customerId} INTEGER,'
        '${DBConstant.employeeId} INTEGER,'
        '${DBConstant.vehicleId} INTEGER,'
        '${DBConstant.deviceId} INTEGER,'
        '${DBConstant.photo} TEXT,'
        '${DBConstant.customerName} TEXT,'
        '${DBConstant.latitude} DOUBLE,'
        '${DBConstant.longitude} DOUBLE,'
        '${DBConstant.isUpload} TINYINT,'
        '${DBConstant.fromDelivery} TINYINT,'
        '${DBConstant.whSale} TINYINT,'
        '${DBConstant.saleOrderTypeId} TINYINT,'
        '${DBConstant.remarks} TEXT'
        ')');
  }

  _createUomTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.uomUomTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.displayName} TEXT,'
        '${DBConstant.uomCategoryId} INTEGER,'
        '${DBConstant.uomCategoryName} TEXT,'
        '${DBConstant.ratio} DOUBLE,'
        '${DBConstant.rounding} DOUBLE,'
        '${DBConstant.uomType} TEXT,'
        '${DBConstant.uomFactor} DOUBLE,'
        '${DBConstant.active} INTEGER,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createSaleOrderHeaderTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.saleOrderTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.partnerId} INTEGER,'
        '${DBConstant.partnerName} TEXT,'
        '${DBConstant.employeeId} INTEGER,'
        '${DBConstant.vehicleId} INTEGER,'
        '${DBConstant.warehouseId} INTEGER,'
        '${DBConstant.warehouseName} TEXT,'
        '${DBConstant.isUpload} INTEGER,'
        '${DBConstant.amountTotal} DOUBLE,'
        '${DBConstant.origin} TEXT,'
        '${DBConstant.clientOrderRef} TEXT,'
        '${DBConstant.reference} TEXT,'
        '${DBConstant.isQuotation} TINYINT,'
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
        '${DBConstant.dateOrder} TEXT,'
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

  _createSecondarySaleOrderHeaderTable(Database db) async {
    await db.execute('CREATE TABLE ${DBConstant.secondarySaleOrderTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.partnerId} INTEGER,'
        '${DBConstant.partnerName} TEXT,'
        '${DBConstant.employeeId} INTEGER,'
        '${DBConstant.vehicleId} INTEGER,'
        '${DBConstant.warehouseId} INTEGER,'
        '${DBConstant.warehouseName} TEXT,'
        '${DBConstant.isUpload} INTEGER,'
        '${DBConstant.amountTotal} DOUBLE,'
        '${DBConstant.origin} TEXT,'
        '${DBConstant.clientOrderRef} TEXT,'
        '${DBConstant.reference} TEXT,'
        '${DBConstant.isQuotation} TINYINT,'
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
        '${DBConstant.dateOrder} TEXT,'
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

    await db.execute('CREATE TABLE ${DBConstant.secondarySaleOrderLineTable} '
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

  _createPriceListItemTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.priceListItemTable} ('
        '${DBConstant.id} INTEGER PRIMARY KEY,' // Assuming id is the primary key
        '${DBConstant.productTmplId} INTEGER,'
        '${DBConstant.productTmplName} TEXT,'
        '${DBConstant.productId} INTEGER,'
        '${DBConstant.productName} TEXT,'
        '${DBConstant.minQuantity} DOUBLE,'
        '${DBConstant.fixedPrice} DOUBLE,'
        '${DBConstant.dateStart} TEXT,'
        '${DBConstant.dateEnd} TEXT,'
        '${DBConstant.companyId} INTEGER,'
        '${DBConstant.companyName} TEXT,'
        '${DBConstant.priceListId} INTEGER,'
        '${DBConstant.priceListName} TEXT,'
        '${DBConstant.currencyId} INTEGER,'
        '${DBConstant.currencyName} TEXT,'
        '${DBConstant.productUomMinQty} DOUBLE,'
        '${DBConstant.productUom} INTEGER,'
        '${DBConstant.productUomName} TEXT,'
        '${DBConstant.discountPercent} DOUBLE,'
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
    // ${DBConstant.cityId} INTEGER,

    return await db.execute('''CREATE TABLE ${DBConstant.resPartnerTable} (
        ${DBConstant.id} INTEGER PRIMARY KEY,
        ${DBConstant.name} TEXT,
        ${DBConstant.street2} TEXT,
        ${DBConstant.street} TEXT,
        ${DBConstant.zoneId} INTEGER,
        ${DBConstant.zoneName} TEXT,
        ${DBConstant.townshipId} INTEGER,
        ${DBConstant.townshipName} TEXT,
        ${DBConstant.wardId} INTEGER,
        ${DBConstant.wardName} TEXT,
        ${DBConstant.city} TEXT,
        ${DBConstant.cityId} INTEGER,
        ${DBConstant.cityName} TEXT,
        ${DBConstant.territoryId} INTEGER,
        ${DBConstant.territoryName} TEXT,
        ${DBConstant.stateId} INTEGER,
        ${DBConstant.stateName} TEXT,
        ${DBConstant.countryId} INTEGER,
        ${DBConstant.countryName} TEXT,
        ${DBConstant.companyId} INTEGER,
        ${DBConstant.companyName} TEXT,
        ${DBConstant.zip} TEXT,
        ${DBConstant.phone} TEXT,
        ${DBConstant.mobile} TEXT,
        ${DBConstant.productPricelistId} INTEGER,
        ${DBConstant.productPricelistName} TEXT,
        ${DBConstant.writeDate} TEXT
  )''');
  }

  Future<void> _createSyncHistoryTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.syncHistoryTable} '
        '(${DBConstant.actionName} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createDashboardTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.dashboardTable} ('
        '${DBConstant.id} INTEGER PRIMARY KEY,'
        '${DBConstant.dashboardGroupId} INTEGER,'
        '${DBConstant.dashboardGroupName} TEXT,'
        '${DBConstant.dashboardId} INTEGER,'
        '${DBConstant.dashboardName} TEXT,'
        '${DBConstant.isFolder} INTEGER,'
        '${DBConstant.companyId} INTEGER,'
        '${DBConstant.companyName} TEXT,'
        '${DBConstant.solutionId} TEXT,'
        '${DBConstant.actionUrl} TEXT,'
        '${DBConstant.parentId} INTEGER,'
        '${DBConstant.parentDescription} TEXT,'
        '${DBConstant.priority} INTEGER,'
        '${DBConstant.description} TEXT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createCompanyTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.companyTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.logo} TEXT,'
        '${DBConstant.street} TEXT,'
        '${DBConstant.street2} TEXT,'
        '${DBConstant.phone} TEXT,'
        '${DBConstant.mobile} TEXT,'
        '${DBConstant.website} TEXT,'
        '${DBConstant.useLooseUom} INTEGER,'
        '${DBConstant.qtyDigit} INTEGER,'
        '${DBConstant.priceDigit} INTEGER,'
        '${DBConstant.email} TEXT'
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
        '${DBConstant.dashboardGroupId} INTEGER,'
        '${DBConstant.dashboardGroupName} TEXT'
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
    return await db.execute('CREATE TABLE ${DBConstant.productProductTable} ('
        '${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.categId} INTEGER,'
        '${DBConstant.categName} TEXT,'
        '${DBConstant.companyId} INTEGER,' // Added company_id
        '${DBConstant.companyName} TEXT,' // Added company_name
        '${DBConstant.listPrice} DOUBLE,'
        '${DBConstant.standardPrice} DOUBLE,'
        '${DBConstant.defaultCode} TEXT,'
        '${DBConstant.type} TEXT,' // Fixed typo 'detialType' to 'detailedType'
        '${DBConstant.saleOK} INTEGER,' // Added sale_ok
        '${DBConstant.purchaseOK} INTEGER,' // Added purchase_ok
        '${DBConstant.canBeExpensed} INTEGER,' // Added can_be_expensed
        '${DBConstant.barcode} TEXT,'
        '${DBConstant.productTmplId} INTEGER,' // Added product_tmpl_id
        '${DBConstant.productTmplName} TEXT,' // Added product_tmpl_name
        '${DBConstant.active} INTEGER,'
        '${DBConstant.uomCategoryId} INTEGER,' // Added uom_category_id
        '${DBConstant.uomCategoryName} TEXT,' // Added uom_category_name
        '${DBConstant.uomId} INTEGER,' // Added uom_id
        '${DBConstant.uomName} TEXT,' // Added uom_name
        '${DBConstant.uomPoId} INTEGER,' // Added uom_po_id
        '${DBConstant.uomPoName} TEXT,' // Added uom_po_name
        '${DBConstant.looseUomId} INTEGER,'
        '${DBConstant.looseUomName} TEXT,'
        '${DBConstant.boxUomId} INTEGER,'
        '${DBConstant.boxUomName} TEXT,'
        '${DBConstant.trackingType} TEXT,'
        '${DBConstant.isStorable} TINYINT,'
        '${DBConstant.writeDate} TEXT'
        ')');
  }

  _createProductTemplateTable(Database db) async {
    return await db.execute('''CREATE TABLE ${DBConstant.productTemplateTable} (
        ${DBConstant.id} INTEGER PRIMARY KEY,
        ${DBConstant.name} TEXT,
        ${DBConstant.categId} INTEGER,
        ${DBConstant.categName} TEXT,
        ${DBConstant.companyId} INTEGER,
        ${DBConstant.companyName} TEXT,
        ${DBConstant.listPrice} DOUBLE,
        ${DBConstant.defaultCode} TEXT,
        ${DBConstant.type} TEXT,
        ${DBConstant.isStorable} INTEGER,
        ${DBConstant.saleOk} INTEGER,
        ${DBConstant.purchaseOk} INTEGER,
        ${DBConstant.canBeExpensed} INTEGER,
        ${DBConstant.barcode} TEXT,
        ${DBConstant.productTmplId} INTEGER,
        ${DBConstant.productTmplName} TEXT,
        ${DBConstant.active} INTEGER,
        ${DBConstant.uomCategoryId} INTEGER,
        ${DBConstant.uomCategoryName} TEXT,
        ${DBConstant.uomId} INTEGER,
        ${DBConstant.uomName} TEXT,
        ${DBConstant.uomPoId} INTEGER,
        ${DBConstant.uomPoName} TEXT,
        ${DBConstant.tracking} TEXT,
        ${DBConstant.looseUomId} INTEGER,
        ${DBConstant.looseUomName} TEXT,
        ${DBConstant.boxUomId} INTEGER,
        ${DBConstant.boxUomName} TEXT,
        ${DBConstant.writeDate} TEXT
  )
''');
    //   ${DBConstant.availableInMobile} INTEGER,
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

  _createUomCategoryTable(Database db) async {
    return await db.execute('''
    CREATE TABLE IF NOT EXISTS ${DBConstant.uomCategoryTable} (
      ${DBConstant.id} INTEGER PRIMARY KEY,
      ${DBConstant.name} TEXT,
      ${DBConstant.writeDate} TEXT
    )
  ''');
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

  _createJournalListTable(Database db) async {
    return await db.execute(
      'CREATE TABLE ${DBConstant.accountJournalTable} '
      '('
      '${DBConstant.id} INTEGER,'
      '${DBConstant.name} TEXT,'
      '${DBConstant.writeDate} TEXT,'
      '${DBConstant.type} TEXT,'
      '${DBConstant.defaultAccountCurrentBalance} DOUBLE,'
      '${DBConstant.companyId} INTEGER,'
      '${DBConstant.companyName} TEXT'
      ')',
    );
  }

  _createNumberSeriesTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.numberSeriesTable} '
        '(${DBConstant.id} INTEGER,'
        '${DBConstant.name} TEXT,'
        '${DBConstant.prefix} TEXT,'
        '${DBConstant.useYear} INTEGER,'
        '${DBConstant.useMonth} INTEGER,'
        '${DBConstant.useDay} INTEGER,'
        '${DBConstant.resetIn} TEXT,'
        '${DBConstant.numberLength} INTEGER,'
        '${DBConstant.numberLast} INTEGER,'
        '${DBConstant.yearLast} INTEGER,'
        '${DBConstant.monthLast} INTEGER,'
        '${DBConstant.dayLast} INTEGER'
        ')');
  }

  _createChildCategoryTable(Database db) async {
    return await db.execute('CREATE TABLE ${DBConstant.childCategoryTable} '
        '(${DBConstant.parentId} INTEGER,'
        '${DBConstant.childId} INTEGER'
        ')');
  }

  Future<List<Map<String, Object?>>> rawQueryC(String query) async {
    Database db = await database;
    List<Map<String, Object?>> affectedRow = await db.rawQuery(query);
    return affectedRow;
  }

  _createPromotion(Database db) async {
    //     minAmount = json['min_amount'];
    //     disType = json['dis_type'];
    //     amount = json['amount'];
    //     disPer = json['dis_per'];
    //     expenseProductId = json['expense_product_id'];
    //     expenseProductName = json['expense_product_name'];
    await db.execute('''CREATE TABLE ${DBConstant.promotionTable} (
            ${DBConstant.id} INTEGER, 
            ${DBConstant.name} TEXT, 
            ${DBConstant.description} TEXT, 
            ${DBConstant.startDate} TEXT, 
            ${DBConstant.endDate} TEXT, 
            ${DBConstant.minAmount} DOUBLE, 
            ${DBConstant.discType} TEXT, 
            ${DBConstant.amount} DOUBLE, 
            ${DBConstant.disPer} DOUBLE, 
            ${DBConstant.expenseProductId} INTEGER, 
            ${DBConstant.expenseProductName} TEXT, 
            ${DBConstant.writeDate} TEXT
          );
      ''');
    await db.execute('''CREATE TABLE ${DBConstant.rewardLineTable} (
         ${DBConstant.promotionId} INTEGER, 
         ${DBConstant.productId} INTEGER, 
         ${DBConstant.productName} TEXT, 
         ${DBConstant.description} TEXT, 
         ${DBConstant.qty} DOUBLE, 
         ${DBConstant.refQty} DOUBLE, 
         ${DBConstant.multiply} INTEGER, 
         ${DBConstant.uomCategoryId} INTEGER, 
         ${DBConstant.uomCategoryName} TEXT, 
         ${DBConstant.uomId} INTEGER, 
         ${DBConstant.uomName} TEXT, 
         ${DBConstant.rewardProductId} INTEGER, 
         ${DBConstant.rewardProductName} TEXT, 
         ${DBConstant.rewardQty} DOUBLE, 
         ${DBConstant.rewardUomId} INTEGER, 
         ${DBConstant.rewardUomName} TEXT, 
         ${DBConstant.rewardUomCategoryId} INTEGER, 
         ${DBConstant.rewardUomCategoryName} TEXT, 
         ${DBConstant.expenseProductId} INTEGER, 
         ${DBConstant.expenseProductName} TEXT, 
         ${DBConstant.buyXGetYId} INTEGER
        );
      ''');
  }
}
