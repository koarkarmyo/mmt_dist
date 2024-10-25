import 'package:dio/dio.dart';


enum SyncProcess {
  Finished,
  NextAction,
  Paginated,
  Fail,
}

class SyncUtils {
  // static final SqlFLiteHelper _helper = SqlFLiteHelper();
  // static SaleOrderDBRepo _saleOrderDBRepo = SaleOrderDBRepo.instance;
  // static SqlFLiteHelper _sqlFLiteHelper = SqlFLiteHelper();
  // static SaleOrderApiRepo _saleOrderApiRepo = SaleOrderApiRepo.instance;
  // static CashCollectDBRepo _cashCollectDBRepo = CashCollectDBRepo();
  // static DeliveryDBRepo _deliveryDBRepo = DeliveryDBRepo();
  // static DeliveryApiRepo _deliveryApiRepo = DeliveryApiRepo();
  // static CustVisitDBRepo _custVisitDBRepo = CustVisitDBRepo.instance;
  // static CustVisitApiRepo _custVisitApiRepo = CustVisitApiRepo();

  static Future<SyncProcess> insertToDatabase(
      {required String actionName, required Response response}) async {
    switch (actionName) {
      // case 'get_route':
      //   return await _getRouteProcess(actionName, response);
      // case 'get_customer':
      //   return await _getCustomerProcess(actionName, response);
      // case 'get_dashboard':
      //   return await _getDashboardProcess(actionName, response);
      // case 'get_cust_dashboard':
      //   return _getCustDashboardProcess(actionName, response);
      // case 'get_category':
      //   return await _getCategoryProcess(actionName, response);
      // case 'get_product':
      //   return await _getProductProcess(actionName, response);
      // case 'get_product_pricelist':
      //   return await _getPriceListProcess(actionName, response);
      // case 'get_customer_product':
      //   return await _getCustomerRegularSaleProductProcess(
      //       actionName, response);
      // case 'get_sale_order':
      //   return await _getSaleOrderProcess(actionName, response);
      // case 'get_inventory_stock':
      //   return await _getInventoryStock(actionName, response);
      // case 'get_wh_stock':
      //   return await _getInventoryStock(actionName, response);
      // case 'get_mscm_township':
      //   return await _getMscmTownship(actionName, response);
      // case 'get_mscm_outlettype':
      //   return await _getMscmOutletType(actionName, response);
      // case 'get_tags':
      //   return await _getTags(actionName, response);
      // case 'get_mscm_grade':
      //   return await _getMscmGrade(actionName, response);
      // case 'get_delivery_order':
      //   return await _getDeliveryOrders(actionName, response);
      // case 'get_sale_order_type':
      //   return await _getSaleOrderTypeProcess(actionName, response);
      // case 'get_batch_list_by_location':
      //   return await _getBatchList(actionName, response);
      // case 'get_stock_order':
      //   return await _getStockOrder(actionName, response);
      // case 'get_cash_collection':
      //   return await _getCashCollection(actionName, response);
      // case 'get_uom':
      //   return await _getUomProcess(actionName, response);
      // case 'get_stock_picking_type':
      //   return _getStockPickingType(actionName, response);
      // case 'get_payment_terms':
      //   return await _getPaymentTerms(actionName, response);
      // case 'get_warehouses':
      //   return await _getWareHouse(actionName, response);
      // case 'get_currencies':
      //   return await _getCurrencyProcess(actionName, response);
      // case 'get_coin_bill_list':
      //   return await _getCoinBillProcess(actionName, response);
      // case 'get_payment_transfer':
      //   return await _getPaymentTransferProcess(actionName, response);
      // case 'get_cash_collect_list_by_employee':
      //   return await _getCashCollectionProcess(actionName, response);
      // case 'get_account_payment_list':
      //   return await _get_account_payment_list(actionName, response);
      // case 'get_journal_list':
      //   return await _get_journal_list(actionName, response);
      default:
        // MMTApplication.printJob('Save process not found!');
        return SyncProcess.Fail;
    }
  }

  // static Future<bool> _insertOrUpdateLastWriteDate(
  //     {required String actionName, required String lastWriteDate}) async {
  //   final data = {
  //     DBConstant.actionName: actionName,
  //     DBConstant.writeDate: lastWriteDate
  //   };
  //   final success = await _helper.updateData(
  //       table: DBConstant.syncHistoryTable,
  //       where: '${DBConstant.actionName} =?',
  //       whereArgs: [actionName],
  //       data: data);
  //   if (!success) {
  //     final success =
  //         await _helper.insertData(DBConstant.syncHistoryTable, data);
  //     return success;
  //   }
  //   return success;
  // }
  //
  // static Future<SyncProcess> _getCustomerProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Partner> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   // filter active = true
  //   // List<Partner> partner =
  //   // baseResponse.data!.where((element) => element.active == true).toList();
  //
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.resPartnerTable,
  //   //     where: DBConstant.id,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   await Future.forEach<Partner>(baseResponse.data!, (element) async {
  //     await _helper.deleteData(
  //         DBConstant.resPartnerTable, '${DBConstant.id}=?', [element.id]);
  //   });
  //
  //   await Future.forEach<Partner>(baseResponse.data!, (element) async {
  //     await _helper.deleteData(
  //         DBConstant.resPartnerTable,
  //         '${DBConstant.name}=? AND ${DBConstant.partnerState}=?',
  //         [element.name, PartnerState.New.name]);
  //   });
  //
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.tagAndPartnerTable,
  //   //     where: DBConstant.partnerId,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   await Future.forEach<Partner>(baseResponse.data!, (element) async {
  //     await _helper.deleteData(DBConstant.tagAndPartnerTable,
  //         '${DBConstant.partnerId}=?', [element.id]);
  //   });
  //
  //   // change to json to insert database
  //   List<Map<String, dynamic>> tagJson = [];
  //   List<Map<String, dynamic>>? dataList = baseResponse.data!.map((e) {
  //     e.categoryIds?.forEach((element) {
  //       tagJson.add({
  //         '${DBConstant.partnerId}': e.id,
  //         '${DBConstant.tagId}': element.id,
  //         '${DBConstant.name}': element.name,
  //       });
  //     });
  //     return e.toJson();
  //   }).toList();
  //   // insert partner list to database
  //   final success =
  //       await _helper.insertDataListBath(DBConstant.resPartnerTable, dataList);
  //   final tagInsertSuccess = await _helper.insertDataListBath(
  //       DBConstant.tagAndPartnerTable, tagJson);
  //   if (success) {
  //     print(
  //         'ls write date get customer :: ${baseResponse.data!.last.writeDate!}');
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getCurrencyProcess(
  //     String actionName, Response response) async {
  //   // delete currency from database
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Currency> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   // delete process
  //   await _helper.deleteAllRow(tableName: DBConstant.currencyTable);
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.currencyTable,
  //   //     where: DBConstant.id,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data?.map((e) => e.toJson()).toList();
  //   // insert currency list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.currencyTable, dataList ?? []);
  //   // if (success) {
  //   //   return await _insertOrUpdateLastWriteDate(
  //   //           actionName: actionName,
  //   //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //   //       ? SyncProcess.Paginated
  //   //       : SyncProcess.Fail;
  //   // }
  //   return SyncProcess.Finished;
  // }
  //
  // static Future<bool> _insertCustRouteList(
  //     BaseApiResponse<RoutePlan> detailList) async {
  //   List<Map<String, dynamic>> routeWithCust = [];
  //   detailList.data!.forEach((detail) {
  //     detail.lineIds!.forEach((element) {
  //       routeWithCust.add({
  //         'partner_id': element.partnerId!,
  //         'route_id': detail.id!,
  //         'is_visited': 0
  //       });
  //     });
  //   });
  //   // delete response row from database
  //   await _helper.deleteRows(
  //       tableName: DBConstant.partnerRouteTable,
  //       where: 'route_id',
  //       wantDeleteRow: detailList.data!.map((e) => e.id!).toList());
  //   return await _helper.insertDataListBath(
  //       DBConstant.partnerRouteTable, routeWithCust);
  // }
  //
  // static Future<SyncProcess> _getPaymentTerms(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<PaymentTerm> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   List<Map<String, dynamic>>? dataList = baseResponse.data!
  //       .map((e) => e.toJson())
  //       .cast<Map<String, dynamic>>()
  //       .toList();
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.paymentTermTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   final success =
  //       await _helper.insertDataListBath(DBConstant.paymentTermTable, dataList);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getRouteProcessOdy(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<RoutePlan> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteAllRow(tableName: DBConstant.mscmRouteTable);
  //
  //   print(res.entries.length);
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJsonDB()).toList();
  //   print(dataList.length);
  //   // insert route list to database
  //   final routeInsertSuccess =
  //       await _helper.insertDataListBath(DBConstant.mscmRouteTable, dataList);
  //   print(routeInsertSuccess);
  //   // final insert route with partner
  //   final routeWithPartnerInsertSuccess =
  //       await _insertCustRouteList(baseResponse);
  //   print(routeWithPartnerInsertSuccess);
  //   // if (routeWithPartnerInsertSuccess && routeInsertSuccess) {
  //   //   bool isSuccess = await _insertOrUpdateLastWriteDate(
  //   //       actionName: actionName,
  //   //       lastWriteDate: baseResponse.data!.last.writeDate!);
  //   //   return isSuccess ? SyncProcess.Paginated : SyncProcess.Fail;
  //   // }
  //
  //   return SyncProcess.Finished;
  // }
  //
  // static Future<SyncProcess> _getRouteProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<RoutePlan> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.mscmRouteTable,
  //       where: '${DBConstant.id}',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   await _helper.deleteRows(
  //       tableName: DBConstant.mscmRouteLineTable,
  //       where: '${DBConstant.routePlanId}',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJsonDB()).toList();
  //
  //   // await _helper.deleteAllRow(tableName: DBConstant.mscmRouteTable);
  //   // insert route list to database
  //   final routeInsertSuccess =
  //       await _helper.insertDataListBath(DBConstant.mscmRouteTable, dataList);
  //   // final insert route with partner
  //
  //   List<Map<String, dynamic>>? lineList = [];
  //   for (RoutePlan plan in baseResponse.data!) {
  //     plan.lineIds?.forEach((element) {
  //       lineList.add(element.toJson());
  //     });
  //   }
  //
  //   final routeWithPartnerInsertSuccess = await _helper.insertDataListBath(
  //       DBConstant.mscmRouteLineTable, lineList);
  //   if (routeWithPartnerInsertSuccess && routeInsertSuccess) {
  //     bool isSuccess = await _insertOrUpdateLastWriteDate(
  //         actionName: actionName,
  //         lastWriteDate: baseResponse.data!.last.writeDate!);
  //     return isSuccess ? SyncProcess.Paginated : SyncProcess.Fail;
  //   }
  //
  //   return SyncProcess.Finished;
  // }
  //
  // static Future<SyncProcess> _getProductProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //
  //   BaseApiResponse<Product> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   List<Map<String, dynamic>> uomListMap = [];
  //   // delete can duplicate row
  //   await _helper.deleteRows(
  //       tableName: DBConstant.productUomTable,
  //       where: 'product_id',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.productId).toList());
  //   await _helper.deleteRows(
  //     tableName: DBConstant.productTable,
  //     where: 'id',
  //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList(),
  //   );
  //   // filter active = true
  //   List<Product> productsActive =
  //       baseResponse.data!.where((element) => element.active ?? false).toList();
  //   List<Product> products = productsActive
  //       .where((element) => element.productId != null && element.id != null)
  //       .toList();
  //   if (products.isEmpty) return SyncProcess.Finished;
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList = products.map((e) {
  //     // e.uomLines is list
  //     // so loop
  //     e.uomLines?.forEach((uom) {
  //       Map<String, dynamic> json = uom.toJsonDB();
  //       json['product_id'] = e.productId;
  //       uomListMap.add(json);
  //     });
  //     return e.toJsonDB();
  //   }).toList();
  //   // final insert uom list to database
  //   bool uomInsertSuccess = await _helper.insertDataListBath(
  //       DBConstant.productUomTable, uomListMap);
  //   if (uomListMap.isEmpty) uomInsertSuccess = true;
  //
  //   // insert product list to database
  //   final bool productInsertSuccess =
  //       await _helper.insertDataListBath(DBConstant.productTable, dataList);
  //
  //   if (uomInsertSuccess && productInsertSuccess) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getDashboardProcess(
  //     String actionName, Response response) async {
  //   // delete dashboards from database
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Dashboard> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   // delete process
  //   await _helper.deleteAllRow(tableName: DBConstant.dashboardTable);
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.dashboardTable,
  //   //     where: DBConstant.id,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJsonDB()).toList();
  //   // insert dashboard list to database
  //   final success =
  //       await _helper.insertDataListBath(DBConstant.dashboardTable, dataList);
  //   // if (success) {
  //   //   return await _insertOrUpdateLastWriteDate(
  //   //           actionName: actionName,
  //   //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //   //       ? SyncProcess.Paginated
  //   //       : SyncProcess.Fail;
  //   // }
  //   return SyncProcess.Finished;
  // }
  //
  // static Future<SyncProcess> _getCategoryProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Category> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteAllRow(tableName: DBConstant.childCategoryTable);
  //   await _helper.deleteAllRow(tableName: DBConstant.categoryTable);
  //
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.childCategoryTable,
  //   //     where: DBConstant.parentId,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.categoryTable,
  //   //     where: DBConstant.id,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   List<Map<String, dynamic>> uomListMap = [];
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList = baseResponse.data!.map((e) {
  //     // e.uomLines is list
  //     // so loop
  //     e.childId?.forEach((childId) {
  //       Map<String, dynamic> json = {'child_id': childId, 'parent_id': e.id!};
  //       uomListMap.add(json);
  //     });
  //     return e.toJsonDB();
  //   }).toList();
  //   // final insert uom list to database
  //   final bool childCategoryInsert = await _helper.insertDataListBath(
  //       DBConstant.childCategoryTable, uomListMap);
  //
  //   // insert category list to database
  //   final bool categoryInsertSuccess =
  //       await _helper.insertDataListBath(DBConstant.categoryTable, dataList);
  //
  //   // if (childCategoryInsert && categoryInsertSuccess) {
  //   //   return await _insertOrUpdateLastWriteDate(
  //   //           actionName: actionName,
  //   //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //   //       ? SyncProcess.Paginated
  //   //       : SyncProcess.Fail;
  //   // }
  //
  //   return SyncProcess.Finished;
  // }
  //
  // static Future<SyncProcess> _getCustDashboardProcess(
  //     String actionName, Response response) async {
  //   // delete dashboards from database
  //   await _helper.deleteAllRow(tableName: DBConstant.customerDashboardTable);
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Dashboard> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJsonDB()).toList();
  //   // insert dashboard list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.customerDashboardTable, dataList);
  //   // if (success) {
  //   //   return await _insertOrUpdateLastWriteDate(
  //   //           actionName: actionName,
  //   //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //   //       ? SyncProcess.Paginated
  //   //       : SyncProcess.Fail;
  //   // }
  //   return success ? SyncProcess.Finished : SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getPriceListProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   // BaseApiResponse<PriceList> baseResponse = BaseApiResponse.fromJson(res);
  //   // if (baseResponse.data!.isEmpty) {
  //   //   return SyncProcess.Finished;
  //   // }
  //
  //   BaseApiResponse<ProductPriceListItem> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   List<ProductPriceListItem> priceListItemList = baseResponse.data ?? [];
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.priceListItemTable,
  //       where: '${DBConstant.id}',
  //       wantDeleteRow: priceListItemList.map((e) => e.id).toList());
  //
  //   List<Map<String, dynamic>> jsonList =
  //       priceListItemList.map((e) => e.toJson()).toList();
  //
  //   bool priceListItemInsertSuccess = await _helper.insertDataListBath(
  //       DBConstant.priceListItemTable, jsonList);
  //
  //   if (priceListItemInsertSuccess) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: priceListItemList.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //
  //   return priceListItemInsertSuccess
  //       ? SyncProcess.Paginated
  //       : SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getCustomerRegularSaleProductProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<CustomerRegularSaleProduct> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   // await _helper.deleteAllRow(tableName: DBConstant.customerProductTable);
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //   // delete response row from database
  //   await _helper.deleteRows(
  //       tableName: DBConstant.customerProductTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // insert dashboard list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.customerProductTable, dataList);
  //
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return success ? SyncProcess.Finished : SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getSaleOrderProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<SaleOrderHeader> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   List<SaleOrderLine> orderLines = [];
  //   baseResponse.data?.forEach((e) {
  //     e.orderLine?.forEach(
  //         (element) => orderLines.add(element.copyWith(orderNo: e.name)));
  //   });
  //   // await _helper.deleteAllRow(tableName: DBConstant.customerProductTable);
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? saleOrderJsonList = baseResponse.data!
  //       .map((e) => e.copyWith(isUpload: 1).toJsonDB())
  //       .toList();
  //
  //   List<Map<String, dynamic>>? saleOrderLineJsonList =
  //       orderLines.map((e) => e.toJson()).toList();
  //
  //   // delete response row from database
  //   await _helper.deleteRows(
  //       tableName: DBConstant.saleOrderLineTable,
  //       where: DBConstant.orderNo,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.name).toList());
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.saleOrderTable,
  //       where: DBConstant.name,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.name).toList());
  //
  //   bool detailInsertSuccess = await _helper.insertDataListBath(
  //       DBConstant.saleOrderLineTable, saleOrderLineJsonList);
  //
  //   bool hdrInsertSuccess = await _helper.insertDataListBath(
  //       DBConstant.saleOrderTable, saleOrderJsonList);
  //
  //   if (detailInsertSuccess && hdrInsertSuccess) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //
  //   return detailInsertSuccess && hdrInsertSuccess
  //       ? SyncProcess.Paginated
  //       : SyncProcess.Fail;
  // }
  //
  // static _getInventoryStock(String actionName, Response response) async {
  //   int? locationId = MMTApplication.loginResponse?.currentLocationId;
  //   if (actionName == 'get_wh_stock') {
  //     locationId = MMTApplication.loginResponse?.warehouseStockLocationId;
  //   }
  //   Map<String, dynamic> jsonList = response.data;
  //   BaseApiResponse<StockQuant> baseResponse =
  //       BaseApiResponse.fromJson(jsonList);
  //   await _helper.deleteData(DBConstant.stockQuantTable,
  //       '${DBConstant.locationId} = ?', [locationId]);
  //   // await _helper.deleteAllRow(tableName: DBConstant.stockQuantTable);
  //   await _helper.deleteInsertData(
  //       tableName: DBConstant.stockQuantTable,
  //       jsonList: (baseResponse.data ?? []).map((e) => e.toJson()).toList());
  //
  //   return SyncProcess.Finished;
  // }
  //
  // static _getMscmTownship(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Township> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.wardTable,
  //       where: '${DBConstant.townshipId}',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   await _helper.deleteRows(
  //       tableName: DBConstant.townshipTable,
  //       where: '${DBConstant.id}',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   // change to json to insert database
  //   List<Map<String, dynamic>> wardJsonList = [];
  //   List<Map<String, dynamic>> townshipJsonList = [];
  //   baseResponse.data?.forEach((township) {
  //     townshipJsonList.add(township.toJsonDB());
  //     township.wardIds?.forEach((ward) {
  //       Map<String, dynamic> wardJson = ward.toJson();
  //       wardJson.putIfAbsent(DBConstant.townshipId, () => township.id);
  //       wardJsonList.add(wardJson);
  //     });
  //   });
  //   // insert ward list to database
  //   bool insertWard =
  //       await _helper.insertDataListBath(DBConstant.wardTable, wardJsonList);
  //   if (wardJsonList.isEmpty) insertWard = true;
  //   bool insertTownship = await _helper.insertDataListBath(
  //       DBConstant.townshipTable, townshipJsonList);
  //
  //   if (insertWard && insertTownship) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Finished
  //         : SyncProcess.Fail;
  //   }
  // }
  //
  // static _getMscmOutletType(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<OutletType> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.partnerOutletTypeTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //   // insert partner list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.partnerOutletTypeTable, dataList);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _getTags(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Tag> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.tagTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //   // insert tag list to database
  //   final success =
  //       await _helper.insertDataListBath(DBConstant.tagTable, dataList);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _getMscmGrade(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<PartnerGrade> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.partnerGradeTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //   // insert partner list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.partnerGradeTable, dataList);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _getDeliveryOrders(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data;
  //
  //   BaseApiResponse<StockPickingModel> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   List<StockMoveNewModel> stockMoveLines = [];
  //
  //   for (final stockPicking in baseResponse.data ?? <StockPickingModel>[]) {
  //     stockMoveLines.addAll(stockPicking.moveIdsWithoutPackage ?? []);
  //   }
  //
  //   List<Map<String, dynamic>> stockMoveJsonList = [];
  //
  //   for (final stockMove in stockMoveLines)
  //     stockMoveJsonList.add(stockMove.toJson());
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.stockPickingModelTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.stockMoveModelTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: stockMoveLines.map((e) => e.id).toList());
  //
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJsonDB()).toList();
  //
  //   final pickingInserted = await _helper.insertDataListBath(
  //       DBConstant.stockPickingModelTable, dataList);
  //
  //   final moveInserted = await _helper.insertDataListBath(
  //       DBConstant.stockMoveModelTable, stockMoveJsonList);
  //
  //   if (pickingInserted && moveInserted) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> saveCustVisit() async {
  //   bool saved = true;
  //   List<CustVisit> list = await _custVisitDBRepo.getDraftCustVisitList();
  //   for (CustVisit custVisit in list) {
  //     saved = await _custVisitApiRepo.saveCustVisit(custVisit);
  //
  //     if (saved) {
  //       final cust = custVisit.copyWith(isUpload: 1);
  //       await _helper.updateData(
  //           table: DBConstant.custVisitTable,
  //           where: '${DBConstant.customerId} = ? AND ${DBConstant.docDate} = ?',
  //           whereArgs: [custVisit.customerId, custVisit.docDate],
  //           data: cust.toJson());
  //     } else {
  //       return SyncProcess.Fail;
  //     }
  //   }
  //   return SyncProcess.Finished;
  // }
  //
  // static Future<bool> sendDraftSaleOrder() async {
  //   List<SaleOrderHeader> saleOrderHdrList =
  //       await _saleOrderDBRepo.getDraftSaleOrderHdrs();
  //
  //   bool isSuccess = true;
  //
  //   int index = 0;
  //   await Future.doWhile(() async {
  //     // break = false
  //     if (index == saleOrderHdrList.length) {
  //       return false;
  //     }
  //     //
  //     SaleOrderHeader saleOrderHdr = saleOrderHdrList[index];
  //     try {
  //       // qty available check from server
  //
  //       // List<SaleOrderLine> saleOrderLines = await DataObject.instance.getSaleOrderLines(saleOrderHdr.id);
  //       List<Map<String, dynamic>> saleOrderLineJson = await _sqlFLiteHelper
  //           .readDataByWhereArgs(
  //               tableName: DBConstant.saleOrderLineTable,
  //               where: '${DBConstant.orderNo} =? ',
  //               whereArgs: [saleOrderHdr.name]);
  //       List<SaleOrderLine> saleOrderLine = [];
  //
  //       saleOrderLineJson.forEach((element) {
  //         saleOrderLine.add(SaleOrderLine.fromJson(element));
  //       });
  //
  //       final List<Map<String, dynamic>> saleOrderLineJsonApi =
  //           saleOrderLine.map((e) => e.toJsonForSaleOrderApi()).toList();
  //
  //       BaseSingleApiResponse response;
  //       Map<String, dynamic> headerJson = {};
  //       Map<String, dynamic> cashCollectJson = {};
  //
  //       if (saleOrderHdr.fromDirectSale == true) {
  //         CashCollect? cashCollect =
  //             await _cashCollectDBRepo.getCashCollect(saleOrderHdr);
  //         response = await _saleOrderApiRepo.directSaleApiCall(
  //             saleOrderHeader: saleOrderHdr,
  //             cashCollect: cashCollect,
  //             saleOrderLineJson: saleOrderLineJsonApi);
  //
  //         headerJson = response.data!['sale_order'];
  //         cashCollectJson = response.data!['cash_collect'];
  //       } else {
  //         //send to server
  //         response = await _saleOrderApiRepo.sendApiCall(
  //             saleOrderHdr, null, saleOrderLineJsonApi);
  //         headerJson = response.data!;
  //       }
  //
  //       SaleOrderHeader responseHeader = SaleOrderHeader.fromJson(headerJson);
  //
  //       responseHeader.isUpload = 1;
  //
  //       if (saleOrderHdr.fromDirectSale == true) {
  //         CashCollect cashCollect = CashCollect.fromJson(cashCollectJson);
  //         cashCollect.orderNo = responseHeader.name;
  //         cashCollect.orderId = responseHeader.id;
  //
  //         responseHeader.fromDirectSale = true;
  //
  //         bool isUpdated = await _cashCollectDBRepo.updateCashCollect(
  //             saleOrderHdr.name, cashCollect);
  //       }
  //
  //       await _checkDuplicateAndDelete(responseHeader);
  //       await _saleOrderDBRepo.updateResponseOrder(
  //           preOrder: saleOrderHdr, curOrder: responseHeader);
  //
  //       index++;
  //       if (index == saleOrderHdrList.length) {
  //         return false;
  //       }
  //
  //       return true;
  //     } on DioError {
  //       isSuccess = false;
  //       return false;
  //     } catch (e) {
  //       isSuccess = false;
  //       return false;
  //     }
  //   });
  //   return isSuccess;
  // }
  //
  // static Future<SyncProcess> _getWareHouse(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<Warehouse> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   List<Map<String, dynamic>>? dataList = baseResponse.data!
  //       .map((e) => e.toJson())
  //       .cast<Map<String, dynamic>>()
  //       .toList();
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.warehouseTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   final success =
  //       await _helper.insertDataListBath(DBConstant.warehouseTable, dataList);
  //   if (success) {
  //     return SyncProcess.Finished;
  //     // return await _insertOrUpdateLastWriteDate(
  //     //     actionName: actionName,
  //     //     lastWriteDate: baseResponse.data!.last.writeDate!)
  //     //     ? SyncProcess.Paginated
  //     //     : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _checkDuplicateAndDelete(SaleOrderHeader responseHeader) async {}
  //
  // static _getCashCollectionProcess(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<CashCollect> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.cashCollectionTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //
  //   // insert partner list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.cashCollectionTable, dataList);
  //   if (success) {
  //     MMTApplication.totalCashCollectAmount = 0;
  //     List<Map<String, dynamic>> cashCollectList =
  //         await _helper.readAllData(tableName: DBConstant.cashCollectionTable);
  //     cashCollectList.forEach((element) {
  //       MMTApplication.totalCashCollectAmount +=
  //           element[DBConstant.collectAmount];
  //       print('xx : total : ${MMTApplication.totalCashCollectAmount}');
  //     });
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<bool> sendDeliveryOrder() async {
  //   List<StockPickingModel> stockPickingList =
  //       await _deliveryDBRepo.getStockPickingList();
  //
  //   bool isSuccess = true;
  //   int index = 0;
  //
  //   await Future.doWhile(() async {
  //     if (index == stockPickingList.length) {
  //       return false;
  //     }
  //
  //     StockPickingModel stockPickingModel = stockPickingList[index];
  //     try {
  //       List<StockMoveNewModel> stockMoves =
  //           stockPickingModel.moveIdsWithoutPackage ?? [];
  //
  //       List<Map<String, dynamic>> jsonList =
  //           stockMoves.map((e) => e.toJson()).toList();
  //
  //       BaseSingleApiResponse response;
  //       Map<String, dynamic> headerJson = {};
  //       Map<String, dynamic> cashCollectJson = {};
  //
  //       CashCollect? cashCollect;
  //
  //       if (stockPickingModel.state != DeliveryStatus.cancel) {
  //         cashCollect = await _cashCollectDBRepo
  //             .getCashCollectByOrderId(stockPickingModel.saleId ?? 0);
  //       }
  //
  //       response = await _deliveryApiRepo.deliverySendApiCall(
  //           stockPicking: stockPickingModel,
  //           cashCollect: cashCollect,
  //           stockMoveJsonList: jsonList);
  //
  //       headerJson = response.data!['delivery_order'];
  //       cashCollectJson = response.data!['cash_collect'];
  //       // }
  //       // else {
  //       //   //send to server
  //       //   response = await _saleOrderApiRepo.sendApiCall(
  //       //       saleOrderHdr, null, saleOrderLineJsonApi);
  //       //   headerJson = response.data!;
  //       // }
  //
  //       StockPickingModel responsePickingModel =
  //           StockPickingModel.fromJson(headerJson);
  //
  //       if (stockPickingModel.state != DeliveryStatus.cancel) {
  //         CashCollect responseCashCollect =
  //             CashCollect.fromJson(cashCollectJson);
  //
  //         bool isUpdated = await _cashCollectDBRepo.updateCashCollect(
  //             responsePickingModel.origin, responseCashCollect);
  //       }
  //
  //       await _deliveryDBRepo.updateResponsePicking(responsePickingModel);
  //
  //       index++;
  //       if (index == stockPickingList.length) {
  //         isSuccess = true;
  //         return false;
  //       }
  //
  //       return true;
  //     } on DioError catch (e) {
  //       isSuccess = false;
  //       return false;
  //     } catch (e) {
  //       isSuccess = false;
  //       return false;
  //     }
  //   });
  //   return isSuccess;
  // }
  //
  // static _getSaleOrderTypeProcess(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<SaleOrderType> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.saleOrderTypeTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //   // insert partner list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.saleOrderTypeTable, dataList);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _getStockOrder(String actionName, Response response) async {
  //   BaseApiResponse<StockOrder> baseResponse =
  //       BaseApiResponse.fromJson(response.data);
  //
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.stockOrderTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   List<StockOrderLine> stockOrderLines = [];
  //   baseResponse.data?.forEach((element) {
  //     stockOrderLines.addAll(element.stockOrderLine ?? []);
  //   });
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.stockOrderLineTable,
  //       where: DBConstant.orderId,
  //       wantDeleteRow: stockOrderLines.map((e) => e.orderId).toList());
  //
  //   // change to json to insert database
  //   // List<Map<String, dynamic>>? dataList =
  //   //     baseResponse.data!.map((e) => e.toJson()).toList();
  //
  //   // final success = await _helper.insertDataListBath(
  //   //     DBConstant.stockPickingBatchTable, dataList);
  //
  //   List<Map<String, dynamic>> stockOrderJson = [];
  //   List<Map<String, dynamic>> stockOrderLineJson = [];
  //
  //   List<StockOrder> stockOrderList = baseResponse.data ?? [];
  //
  //   stockOrderList.forEach((stockOrder) {
  //     stockOrderJson.add(stockOrder.toJsonDB());
  //     stockOrder.stockOrderLine
  //         ?.forEach((picking) => stockOrderLineJson.add((picking.toJsonDB())));
  //   });
  //
  //   bool success = await _helper.insertDataListBath(
  //       DBConstant.stockOrderTable, stockOrderJson);
  //
  //   await _helper.insertDataListBath(
  //       DBConstant.stockOrderLineTable, stockOrderLineJson);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _getBatchList(String actionName, Response response) async {
  //   BaseApiResponse<StockPickingBatch> baseResponse =
  //       BaseApiResponse.fromJson(response.data);
  //
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.stockPickingBatchTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   List<StockPickingModel> stockPickingList = [];
  //   baseResponse.data?.forEach((element) {
  //     stockPickingList.addAll(element.pickingIds ?? []);
  //   });
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.stockPickingModelTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: stockPickingList.map((e) => e.id).toList());
  //
  //   // change to json to insert database
  //   // List<Map<String, dynamic>>? dataList =
  //   //     baseResponse.data!.map((e) => e.toJson()).toList();
  //
  //   // final success = await _helper.insertDataListBath(
  //   //     DBConstant.stockPickingBatchTable, dataList);
  //
  //   List<Map<String, dynamic>> stockPickingBatch = [];
  //   List<Map<String, dynamic>> pickingIds = [];
  //
  //   List<StockPickingBatch> batchList = baseResponse.data ?? [];
  //
  //   batchList.forEach((batch) {
  //     stockPickingBatch.add(batch.toJsonDB());
  //     batch.pickingIds
  //         ?.forEach((picking) => pickingIds.add((picking.toJsonDB())));
  //   });
  //
  //   bool success = await _helper.insertDataListBath(
  //       DBConstant.stockPickingBatchTable, stockPickingBatch);
  //
  //   await _helper.insertDataListBath(
  //       DBConstant.stockPickingModelTable, pickingIds);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static _getCashCollection(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<CashCollect> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   await _helper.deleteRows(
  //       tableName: DBConstant.cashCollectionTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data!.map((e) => e.toJson()).toList();
  //   // insert partner list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.cashCollectionTable, dataList);
  //   if (success) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getStockPickingType(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //
  //   BaseApiResponse<StockPickingType> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.pickingTypeTable,
  //       where: 'id',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // filter active = true
  //   List<StockPickingType> pickingTypes = baseResponse.data ?? [];
  //   if (pickingTypes.isEmpty) return SyncProcess.Finished;
  //   // change to json to insert database
  //
  //   List<Map<String, dynamic>>? dataList =
  //       pickingTypes.map((e) => e.toJson()).toList();
  //
  //   // insert product list to database
  //   final bool pickingTypeInserted =
  //       await _helper.insertDataListBath(DBConstant.pickingTypeTable, dataList);
  //
  //   if (pickingTypeInserted) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //
  //   return SyncProcess.Fail;
  // }
  //
  // static Future<SyncProcess> _getUomProcess(
  //     String actionName, Response response) async {
  //   // delete dashboards from database
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<MSCMUomLine> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   // delete process
  //   await _helper.deleteAllRow(tableName: DBConstant.mscmUomTable);
  //   // await _helper.deleteRows(
  //   //     tableName: DBConstant.dashboardTable,
  //   //     where: DBConstant.id,
  //   //     wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   // change to json to insert database
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data?.map((e) => e.toJson()).toList();
  //   // insert dashboard list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.mscmUomTable, dataList ?? []);
  //   // if (success) {
  //   //   return await _insertOrUpdateLastWriteDate(
  //   //           actionName: actionName,
  //   //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //   //       ? SyncProcess.Paginated
  //   //       : SyncProcess.Fail;
  //   // }
  //   return SyncProcess.Finished;
  // }
  //
  // static _getCoinBillProcess(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<CoinBill> baseResponse = BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.coinBillTable,
  //       where: DBConstant.id,
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //
  //   List<Map<String, dynamic>>? dataList =
  //       baseResponse.data?.map((e) => e.toJson()).toList();
  //   // insert coin list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.coinBillTable, dataList ?? []);
  //   if (!success) return SyncProcess.Fail;
  //
  //   return await _insertOrUpdateLastWriteDate(
  //           actionName: actionName,
  //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //       ? SyncProcess.Paginated
  //       : SyncProcess.Fail;
  // }
  //
  // static _getPaymentTransferProcess(
  //     String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //   BaseApiResponse<MscmPaymentTransfer> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //   List<Map<String, dynamic>> paymentTransferLine = [];
  //   List<Map<String, dynamic>>? dataList = baseResponse.data?.map((e) {
  //     e.paymentCoinLine?.forEach((element) {
  //       Map<String, dynamic> json = element.toJson();
  //       json.putIfAbsent(DBConstant.transferId, () => e.id);
  //       paymentTransferLine.add(json);
  //     });
  //     return e.toJsonDB();
  //   }).toList();
  //
  //   MMTApplication.printJob(paymentTransferLine.toString());
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.paymentCoinLineTable,
  //       where: '${DBConstant.transferId}',
  //       wantDeleteRow: baseResponse.data?.map((e) => e.id).toList() ?? []);
  //   //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.paymentTransferTable,
  //       where: '${DBConstant.id}',
  //       wantDeleteRow: baseResponse.data?.map((e) => e.id).toList() ?? []);
  //
  //   final lineInsert = await _helper.insertDataListBath(
  //       DBConstant.paymentCoinLineTable, paymentTransferLine);
  //   // insert coin list to database
  //   final success = await _helper.insertDataListBath(
  //       DBConstant.paymentTransferTable, dataList ?? []);
  //   if (!success) return SyncProcess.Fail;
  //
  //   MMTApplication.totalTransferAmount = 0;
  //   List<Map<String, dynamic>> cashCollectList =
  //       await _helper.readAllData(tableName: DBConstant.paymentTransferTable);
  //   cashCollectList.forEach((element) {
  //     MMTApplication.totalTransferAmount += element[DBConstant.amount];
  //   });
  //
  //   return await _insertOrUpdateLastWriteDate(
  //           actionName: actionName,
  //           lastWriteDate: baseResponse.data!.last.writeDate!)
  //       ? SyncProcess.Paginated
  //       : SyncProcess.Fail;
  // }
  //
  // static _get_account_payment_list(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //
  //   BaseApiResponse<AccountPayment> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.accountPaymentTable,
  //       where: 'id',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // filter active = true
  //   List<AccountPayment> pickingTypes = baseResponse.data ?? [];
  //   if (pickingTypes.isEmpty) return SyncProcess.Finished;
  //   // change to json to insert database
  //
  //   List<Map<String, dynamic>>? dataList =
  //       pickingTypes.map((e) => e.toJson()).toList();
  //
  //   // insert product list to database
  //   final bool pickingTypeInserted = await _helper.insertDataListBath(
  //       DBConstant.accountPaymentTable, dataList);
  //
  //   if (pickingTypeInserted) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Paginated
  //         : SyncProcess.Fail;
  //   }
  //
  //   return SyncProcess.Fail;
  // }
  //
  // static _get_journal_list(String actionName, Response response) async {
  //   Map<String, dynamic> res = response.data!;
  //
  //   BaseApiResponse<AccountJournal> baseResponse =
  //       BaseApiResponse.fromJson(res);
  //   if (baseResponse.data!.isEmpty) {
  //     return SyncProcess.Finished;
  //   }
  //
  //   await _helper.deleteRows(
  //       tableName: DBConstant.accountJournalTable,
  //       where: 'id',
  //       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
  //   // filter active = true
  //   List<AccountJournal> journalList = baseResponse.data ?? [];
  //   if (journalList.isEmpty) return SyncProcess.Finished;
  //   // change to json to insert database
  //
  //   List<Map<String, dynamic>>? dataList =
  //       journalList.map((e) => e.toJson()).toList();
  //
  //   // insert product list to database
  //   final bool pickingTypeInserted = await _helper.insertDataListBath(
  //       DBConstant.accountJournalTable, dataList);
  //
  //   if (pickingTypeInserted) {
  //     return await _insertOrUpdateLastWriteDate(
  //             actionName: actionName,
  //             lastWriteDate: baseResponse.data!.last.writeDate!)
  //         ? SyncProcess.Finished
  //         : SyncProcess.Fail;
  //   }
  //
  //   return SyncProcess.Finished;
  // }
}

// static _getDeliveryOrders(String actionName, Response response) async {
//   Map<String, dynamic> res = response.data;
//
//   BaseApiResponse<StockPickingModel> baseResponse =
//       BaseApiResponse.fromJson(res);
//   if (baseResponse.data!.isEmpty) {
//     return SyncProcess.Finished;
//   }
//
//   List<StockMoveNewModel> stockMoveLines = [];
//
//   for (final stockPicking in baseResponse.data ?? <StockPickingModel>[]) {
//     stockMoveLines.addAll(stockPicking.moveIdsWithoutPackage ?? []);
//   }
//
//   List<Map<String, dynamic>> stockMoveJsonList = [];
//
//   for (final stockMove in stockMoveLines)
//     stockMoveJsonList.add(stockMove.toJson());
//
//   _helper.deleteRows(
//       tableName: DBConstant.stockPickingModelTable,
//       where: DBConstant.id,
//       wantDeleteRow: baseResponse.data!.map((e) => e.id).toList());
//
//   _helper.deleteRows(
//       tableName: DBConstant.stockMoveModelTable,
//       where: DBConstant.id,
//       wantDeleteRow: stockMoveLines.map((e) => e.id).toList());
//
//   List<Map<String, dynamic>>? dataList =
//       baseResponse.data!.map((e) => e.toJsonDB()).toList();
//
//   final pickingInserted = await _helper.insertDataListBath(
//       DBConstant.stockPickingModelTable, dataList);
//
//   final moveInserted = await _helper.insertDataListBath(
//       DBConstant.stockMoveModelTable, stockMoveJsonList);
//
//   if (pickingInserted && moveInserted) {
//     return await _insertOrUpdateLastWriteDate(
//             actionName: actionName,
//             lastWriteDate: baseResponse.data!.last.writeDate!)
//         ? SyncProcess.Paginated
//         : SyncProcess.Fail;
//   }
//   return SyncProcess.Fail;
// }
