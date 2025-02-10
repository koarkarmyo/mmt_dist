import 'package:mmt_mobile/model/stock_location.dart';

import '../model/cust_visit.dart';
import '../model/number_series.dart';
import '../model/price_list/product_price_list_item.dart';
import '../model/product/uom_lines.dart';
import 'database_helper.dart';
import 'db_constant.dart';

class DataObject {
  static final DataObject instance = DataObject._();

  DataObject._();

  // Future<ProductPriceListItem?> getProductPrice(
  //     {required int priceGroupId,
  //     required int productId,
  //     required int uomId,
  //     required double minQty}) async {
  //   List<ProductPriceListItem> prices = await getPriceList(
  //       where: '${DBConstant.priceListId} = ? AND '
  //           '${DBConstant.productTemplId} = ? AND '
  //           '${DBConstant.minQuantity} <= ? AND '
  //           '${DBConstant.productUom} = ?',
  //       arg: [
  //         priceGroupId.toString(),
  //         productId.toString(),
  //         minQty.toString(),
  //         uomId.toString()
  //       ]);
  //   if (prices.isNotEmpty)
  //     return prices.first;
  //   else
  //     return null;
  // }
  //
  Future<List<ProductPriceListItem>> getPriceList(
      {String? where, List<String>? arg}) async {
    List<Map<String, dynamic>> priceJson;
    if (where != null && arg != null) {
      priceJson = await DatabaseHelper.instance.readDataByWhereArgs(
          tableName: DBConstant.priceListItemTable,
          where: where,
          whereArgs: arg);
    } else {
      priceJson = await DatabaseHelper.instance
          .readAllData(tableName: DBConstant.priceListItemTable);
    }
    print('xxxxxxxx::::');
    return priceJson.map((e) => ProductPriceListItem.fromJson(e)).toList();
  }

  Future<List<StockLocation>> getStockLocationList() async {
    List<StockLocation> stockLocationList = [];

    try {
      List<Map<String, dynamic>> stockLocationJsonList = await DatabaseHelper
          .instance
          .readAllData(tableName: DBConstant.stockLocationTable);

      stockLocationJsonList.forEach(
        (element) {
          stockLocationList.add(StockLocation.fromJsonDB(element));
        },
      );
    } on Exception {
      return [];
    }

    stockLocationList.forEach(
      (element) => print(element.toJson()),
    );

    return stockLocationList;
  }

  //
  // Future<List<PriceListItem>> getPriceListItems() async {
  //   List<Map<String, dynamic>> priceJson;
  //
  //   priceJson = await _sqlFLiteHelper.readDataByWhereArgs(
  //       tableName: DBConstant.priceListItemTable,
  //       where: '${DBConstant.priceGroupId} =? ',
  //       whereArgs: [MMTApplication.currentSelectedCustomer!.pricelistId!]);
  //   return priceJson.map((e) => PriceListItem.fromJson(e)).toList();
  // }
  //
  // Future<List<CustomerRegularSaleProduct>> getCustomerProducts(
  //     {required int customerId}) async {
  //   List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper
  //       .readDataByWhereArgs(
  //           tableName: DBConstant.customerProductTable,
  //           where: '${DBConstant.customerId} = ?',
  //           whereArgs: [customerId.toString()]);
  //   List<CustomerRegularSaleProduct> customerRegularSaleProducts = [];
  //   jsonList.forEach((json) {
  //     customerRegularSaleProducts
  //         .add(CustomerRegularSaleProduct.fromJson(json));
  //   });
  //   return customerRegularSaleProducts;
  // }
  //
  // Future<List<ProductGroup>> getProductGroups() async {
  //   List<Map<String, dynamic>> _jsonList = [];
  //   List<ProductGroup> _productGroups = [];
  //   _jsonList = await _sqlFLiteHelper.readAllData(
  //       tableName: DBConstant.productGroupTable);
  //   _jsonList.forEach((element) {
  //     _productGroups.add(ProductGroup.fromJson(element));
  //   });
  //   return _productGroups;
  // }
  //
  // Future<List<Product>> getProducts(
  //     {int? id,
  //     ProductDetailTypes? productDetailTypes,
  //     List<int?>? ids,
  //     bool saleOk = true}) async {
  //   List<Map<String, dynamic>> jsonList;
  //   if (productDetailTypes != null && id != null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.productTable,
  //         where:
  //             '${DBConstant.detialType} =? AND ${DBConstant.id} =? AND ${DBConstant.saleOK} =? ',
  //         whereArgs: [productDetailTypes.name.toString(), id, saleOk ? 1 : 0]);
  //   } else if (id != null && productDetailTypes == null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.productTable,
  //         where: '${DBConstant.productId} =? AND ${DBConstant.saleOK} =? ',
  //         whereArgs: [id.toString(), saleOk ? 1 : 0]);
  //   } else if (id == null && productDetailTypes != null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.productTable,
  //         where: '${DBConstant.detialType} =? AND ${DBConstant.saleOK} =? ',
  //         whereArgs: [productDetailTypes.name, saleOk ? 1 : 0]);
  //   } else if (ids != null) {
  //     jsonList = await _sqlFLiteHelper.readRowsWhereIn(
  //       tableName: DBConstant.productTable,
  //       where: DBConstant.id,
  //       queryValues: ids,
  //     );
  //   } else {
  //     // jsonList =
  //     // await _sqlFLiteHelper.readAllData(tableName: DBConstant.productTable);
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.productTable,
  //         where: '${DBConstant.saleOK} =? ',
  //         whereArgs: [saleOk ? 1 : 0]);
  //   }
  //
  //   List<Map<String, dynamic>> uomLinesJson = await _sqlFLiteHelper.readAllData(
  //       tableName: DBConstant.productUomTable);
  //
  //   List<ProductGroup> _productGroupList = await getProductGroups();
  //
  //   List<UomLine> uomLines =
  //       uomLinesJson.map((e) => UomLine.fromJsonDB(e)).toList();
  //   // sorting biggest uom to smallest
  //   uomLines.sort((a, b) => a.ratio!.compareTo(b.ratio!));
  //   uomLines = uomLines.reversed.toList();
  //
  //   List<Product> products =
  //       jsonList.map((e) => Product.fromJsonDB(e)).toList();
  //
  //   List<PriceListItem> _priceListItems = await getPriceListItem();
  //
  //   for (Product product in products) {
  //     final pUomList = uomLines
  //         .where((uom) => uom.productId! == product.productId!)
  //         .toList();
  //     product.uomLines = pUomList;
  //
  //     final pPriceItemList = _priceListItems
  //         .where((priceListItem) => priceListItem.productTmplId == product.id)
  //         .toList();
  //     product.priceListItems = pPriceItemList;
  //   }
  //
  //   if (_productGroupList.isNotEmpty) {
  //     List<Product> tempProductList = [];
  //     tempProductList =
  //         products.where((element) => element.productGroupId == null).toList();
  //     for (ProductGroup group in _productGroupList) {
  //       final result = products
  //           .where((element) => element.productGroupId == group.id)
  //           .toList();
  //       tempProductList.addAll(result);
  //     }
  //     print(tempProductList.length);
  //     return tempProductList;
  //   }
  //   print(products.length);
  //
  //   return products;
  //   // return products;
  // }
  //
  // Future<Partner?> getCustomer(int id) async {
  //   SqlFLiteHelper helper = SqlFLiteHelper();
  //   List<Map<String, dynamic>> json = await helper.readDataByWhereArgs(
  //       tableName: DBConstant.resPartnerTable,
  //       where: '${DBConstant.id} =? ',
  //       whereArgs: [id.toString()]);
  //   if (json.isNotEmpty) return Partner.fromJson(json.first);
  //   return null;
  // }
  //
  // Future<List<SaleOrderLine>> getSaleOrderLines(String orderNo) async {
  //   List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper
  //       .readDataByWhereArgs(
  //           tableName: DBConstant.saleOrderLineTable,
  //           where: '${DBConstant.orderNo} =? ',
  //           whereArgs: [orderNo]);
  //   List<SaleOrderLine> saleOrderLineList = [];
  //   jsonList.forEach((element) {
  //     final orderLine = SaleOrderLine.fromJson(element);
  //     saleOrderLineList.add(orderLine);
  //   });
  //   return saleOrderLineList;
  // }
  //
  Future<List<UomLine>> getUomLines(int? productId, {List<int>? ids}) async {
    List<Map<String, dynamic>> jsonList = [];
    if (ids != null) {
      jsonList = await DatabaseHelper.instance.readDataByWhereArgs(
        tableName: DBConstant.productUomTable,
        where: "${DBConstant.productId} = ?",
        whereArgs: ids,
      );
    } else {
      jsonList = await DatabaseHelper.instance.readDataByWhereArgs(
          tableName: DBConstant.productUomTable,
          where: '${DBConstant.productId} =? ',
          whereArgs: [productId.toString()]);
    }
    List<UomLine> uomLines = [];
    jsonList.forEach((element) {
      final uomLine = UomLine.fromJsonDB(element);
      uomLines.add(uomLine);
    });
    return uomLines;
  }

  // Future<List<StockMoveModel>> getStockMoveModelList() async {
  //   List<StockMoveModel> stockMoveModels = [];
  //   List<Map<String, dynamic>> jsonList = await SqlFLiteHelper()
  //       .readAllData(tableName: DBConstant.stockMoveTable);
  //
  //   jsonList.forEach((element) {
  //     stockMoveModels.add(StockMoveModel.fromJson(element));
  //   });
  //
  //   List<StockMoveModel> temp = [];
  //   await Future.forEach<StockMoveModel>(stockMoveModels, (element) async {
  //     final stockMoveMdl =
  //         element.copyWith(moveLineIds: await getStockMoveLineList(element));
  //     temp.add(stockMoveMdl);
  //   });
  //
  //   return temp;
  // }
  //
  // Future<List<VehicleInventoryModel>> getVehicleInventory() async {
  //   List<VehicleInventoryModel> vehicleInventoryList = [];
  //   List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper.readAllData(
  //       tableName: DBConstant.vehicleInventoryTable);
  //
  //   jsonList.forEach((element) =>
  //       vehicleInventoryList.add(VehicleInventoryModel.fromJson(element)));
  //
  //   return vehicleInventoryList;
  // }
  //
  // Future<List<StockMoveLineModel>> getStockMoveLineList(
  //     StockMoveModel stockMoveModel) async {
  //   List<StockMoveLineModel> stockMoveLineModels = [];
  //   List<Map<String, dynamic>> jsonList = await SqlFLiteHelper()
  //       .readDataByWhereArgs(
  //           tableName: DBConstant.stockMoveLineTable,
  //           where: '${DBConstant.moveNo} =? ',
  //           whereArgs: [stockMoveModel.moveNo]);
  //   jsonList.forEach((element) {
  //     stockMoveLineModels.add(StockMoveLineModel.fromJsonDB(element));
  //   });
  //   return stockMoveLineModels;
  // }
  //
  // Future<List<SaleOrderHeader>> getSaleOrderHdr(
  //     {required String orderNo}) async {
  //   List<SaleOrderHeader> saleOrderHeaders = [];
  //
  //   List<Map<String, dynamic>> jsonList = await SqlFLiteHelper()
  //       .readDataByWhereArgs(
  //           tableName: DBConstant.saleOrderTable,
  //           where: '${DBConstant.name} =? ',
  //           whereArgs: [orderNo]);
  //
  //   jsonList.forEach((element) {
  //     saleOrderHeaders.add(SaleOrderHeader.fromJson(element));
  //   });
  //   return saleOrderHeaders;
  // }
  //
  Future<NumberSeries?> getNumberSeries({required String moduleName}) async {
    List<Map<String, dynamic>> json = await DatabaseHelper.instance
        .readDataByWhereArgs(
            tableName: DBConstant.numberSeriesTable,
            where: '${DBConstant.name} =? ',
            whereArgs: [moduleName]);
    if (json.isNotEmpty) {
      return NumberSeries.fromJsonDB(json.first);
    }
    return null;
  }

  //
  // Future<List<VehicleInventoryModel>> getVehicleInventoryByProduct(
  //     int productId) async {
  //   List<Map<String, dynamic>> jsonList = await SqlFLiteHelper()
  //       .readDataByWhereArgs(
  //           tableName: DBConstant.vehicleInventoryTable,
  //           where: '${DBConstant.productId} =? ',
  //           whereArgs: [productId]);
  //   List<VehicleInventoryModel> objs = [];
  //   jsonList.forEach((element) {
  //     final obj = VehicleInventoryModel.fromJson(element);
  //     objs.add(obj);
  //   });
  //   return objs;
  // }
  //
  // Future<DailyRoute> getTodayRoute() async {
  //   List<DailyRoute> totalRouteList = [];
  //   DateTime today = DateTime.now();
  //   // int currentDay = currentDate.weekday - 1;
  //   // double currentWeek = currentDay / 7;
  //   int currentWeek = today.weekOfMonth;
  //   print(currentWeek);
  //   print(currentWeek);
  //   int currentDay = today.weekday - 1;
  //   String currentWeekName = "";
  //
  //   if (currentWeek <= 1) {
  //     currentWeekName = DBConstant.routeWeek1;
  //   } else if (currentWeek > 1 && currentWeek <= 2) {
  //     currentWeekName = DBConstant.routeWeek2;
  //   } else if (currentWeek > 2 && currentWeek <= 3) {
  //     currentWeekName = DBConstant.routeWeek3;
  //   } else if (currentWeek > 3) {
  //     currentWeekName = DBConstant.routeWeek4;
  //   }
  //   List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper
  //       .readDataByWhereArgs(
  //           tableName: DBConstant.mscmRouteTable,
  //           where: "route_day=? AND $currentWeekName=?",
  //           whereArgs: [currentDay, 1]);
  //   jsonList.forEach((e) => totalRouteList.add(DailyRoute.fromJson(e)));
  //   if (totalRouteList.length > 0) {
  //     return totalRouteList.first;
  //   } else
  //     return DailyRoute(id: 0, name: 'Today route');
  // }
  //
  // Future<LoginResponse> getLoginResponse() async {
  //   List<ProductGroup> _prodList = [];
  //   List<EmployeeLocation> _locationList = [];
  //
  //   List<Map<String, dynamic>> mapList =
  //       await _sqlFLiteHelper.readAllData(tableName: DBConstant.mscmUserTable);
  //   List<Map<String, dynamic>> deviceIDList = await _sqlFLiteHelper.readAllData(
  //       tableName: DBConstant.mscmDeviceTable);
  //   List<Map<String, dynamic>> productGroupJsonList = await _sqlFLiteHelper
  //       .readAllData(tableName: DBConstant.productGroupTable);
  //   List<Map<String, dynamic>> employeeLocationJsonList = await _sqlFLiteHelper
  //       .readAllData(tableName: DBConstant.employeeLocationTable);
  //   List<Map<String, dynamic>> companyJsonList =
  //       await _sqlFLiteHelper.readAllData(tableName: DBConstant.companyTable);
  //
  //   productGroupJsonList.forEach((element) {
  //     _prodList.add(ProductGroup.fromJson(element));
  //   });
  //
  //   employeeLocationJsonList.forEach((element) {
  //     _locationList.add(EmployeeLocation.fromJsonDB(element));
  //   });
  //
  //   CompanyId? companyId = companyJsonList.isNotEmpty
  //       ? CompanyId.fromJsonDB(companyJsonList.first)
  //       : null;
  //
  //   LoginResponse response = LoginResponse.fromJsonDB(mapList.first);
  //   response.deviceId = Device.fromJsonDB(deviceIDList.first);
  //   response.employee_prod_groups = _prodList;
  //   response.companyId = companyId;
  //   response.employee_locations = _locationList;
  //   return response;
  // }
  //
  // Future<List<Partner>> getCustomerListWithFilter(
  //     {String name = '%', String route_id = '%'}) async {
  //   List<Partner> customerList = [];
  //   List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper
  //       .filterCustomerByTypeAndRoute(customerName: name, routeId: route_id);
  //   // jsonList.forEach((e) => customerList.add(Partner.fromJson(e)));
  //   customerList = await compute(JsonToObject.changeJsonToObject, jsonList);
  //
  //   await Future.forEach<Partner>(customerList, (cust) async {
  //     List<Tag> tagList = [];
  //
  //     List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper
  //         .readDataByWhereArgs(
  //             tableName: DBConstant.tagAndPartnerTable,
  //             where: '${DBConstant.partnerId} =?',
  //             whereArgs: [cust.id]);
  //
  //     for (Map<String, dynamic> json in jsonList) {
  //       tagList.add(Tag(id: json['tag_id'], name: json['name']));
  //     }
  //
  //     cust.categoryIds = tagList;
  //   });
  //
  //   return customerList;
  // }
  //
  // Future<List<Map<String, dynamic>>> filterCustomerByTypeAndNoRoute(
  //     {required String customerName, required String routeId}) async {
  //   String _sql = """SELECT cust.*
  //   FROM ${DBConstant.resPartnerTable} cust
  //   WHERE ${DBConstant.id} not in (
  //   SELECT DISTINCT ${DBConstant.partnerId} FROM ${DBConstant.partnerRouteTable}
  //   );""";
  //   List<Map<String, dynamic>> maps = await _sqlFLiteHelper.rawQueryC(_sql);
  //   return maps;
  // }
  //
  Future<bool> insertCustVisit(CustVisit custVisit) async {
    int? id = await DatabaseHelper.instance.insertData(
        table: DBConstant.custVisitTable, values: custVisit.toJson());
    return id != null;
  }

  //
  // Future<List<CustVisit>> getCustVisitedList(
  //     {int? custId, CustVisitTypes? custVisitType}) async {
  //   List<Map<String, dynamic>> jsonList = [];
  //   if (custId != null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.custVisitTable,
  //         where: '${DBConstant.customerId} =? AND ${DBConstant.isUpload} =?',
  //         whereArgs: [custId, 0]);
  //   } else if (custVisitType != null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.custVisitTable,
  //         where: '${DBConstant.docType} =? AND ${DBConstant.isUpload} =?',
  //         whereArgs: [custVisitType.name, 0],
  //         orderBy: '${DBConstant.docDate} DESC',
  //         limit: 10);
  //   } else {
  //     jsonList = await _sqlFLiteHelper.readAllData(
  //         tableName: DBConstant.custVisitTable);
  //   }
  //   List<CustVisit> list = [];
  //   jsonList.forEach((json) {
  //     list.add(CustVisit.fromJson(json));
  //   });
  //   return list;
  // }
  //
  // Future<List<CustVisit>> getCustVisitedListJson(
  //     {int? custId, CustVisitTypes? custVisitType}) async {
  //   List<Map<String, dynamic>> jsonList = [];
  //   if (custId != null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.custVisitTable,
  //         where: '${DBConstant.customerId} =? AND ${DBConstant.isUpload} =?',
  //         whereArgs: [custId, 0]);
  //   } else if (custVisitType != null) {
  //     jsonList = await _sqlFLiteHelper.readDataByWhereArgs(
  //         tableName: DBConstant.custVisitTable,
  //         where: '${DBConstant.docType} =? AND ${DBConstant.isUpload} =?',
  //         whereArgs: [custVisitType.name, 0],
  //         orderBy: '${DBConstant.docDate} DESC',
  //         limit: 10);
  //   } else {
  //     jsonList = await _sqlFLiteHelper.readAllData(
  //         tableName: DBConstant.custVisitTable);
  //   }
  //   List<CustVisit> list = [];
  //   jsonList.forEach((json) {
  //     list.add(CustVisit.fromJson(json));
  //   });
  //   return list;
  // }

  Future<CustVisit?> getLastClockInOutProcess() async {
    // List<Map<String, dynamic>> json = await _sqlFLiteHelper.readDataByWhereArgs(
    //     tableName: DBConstant.custVisitTable,
    //     orderBy: 'doc_date DESC',
    //     whereArgs: [CustVisitTypes.gps.name],
    //     where: '${DBConstant.docType}');
    // List<SaleOrderType> saleOrderTypes =
    //     await SaleOrderTypeDBRepo().getSaleOrderTypes();
    // SaleOrderType type = saleOrderTypes.firstWhere((element) => element.conditionType == SaleOrderReqTypes.wh_sale.name);
    List<Map<String, dynamic>> json = await DatabaseHelper.instance.readDataRaw(
        'SELECT * FROM ${DBConstant.custVisitTable} WHERE ${DBConstant.docType} <> \'${CustVisitTypes.gps.name}\' AND (${DBConstant.whSale} IS Null OR ${DBConstant.whSale} <> 1) ORDER BY ${DBConstant.docDate} DESC');
    if (json.isEmpty) {
      return null;
    } else {
      CustVisit custVisit = CustVisit.fromJson(json.first);
      return custVisit;
    }
  }

  Future<List<CustVisit>> getCustVisit(
      {required String date, int? saleOrderTypeId}) async {
    List<CustVisit> custVisits = [];
    List args = ['$date%'];
    String saleOrderTypeQuery = '';
    if (saleOrderTypeId != null) {
      saleOrderTypeQuery = 'AND ${DBConstant.saleOrderTypeId} =?';
      args.add(1);
    }
    List<Map<String, dynamic>> jsonList =
    await DatabaseHelper.instance.readDataByWhereArgs(
      tableName: DBConstant.custVisitTable,
      where: '${DBConstant.docDate} LIKE ? $saleOrderTypeQuery',
      whereArgs: args,
    );

    for (Map<String, dynamic> jsonV in jsonList) {
      CustVisit custVisit = CustVisit.fromJson(jsonV);
      custVisits.add(custVisit);
    }

    return custVisits;
  }

// Future<void> updateVehicleInventory(
//     List<VehicleInventoryModel> vehicleInventoryList) async {
//   await Future.forEach<VehicleInventoryModel>(vehicleInventoryList,
//       (vehicleInventoryModel) async {
//     await _sqlFLiteHelper.updateData(
//         table: DBConstant.vehicleInventoryTable,
//         where: '${DBConstant.productId} =? ',
//         whereArgs: [
//           vehicleInventoryModel.productId
//         ],
//         data: {
//           DBConstant.productUomQty: vehicleInventoryModel.productUomQty
//         });
//   });
// }
//
// Future<List<CustVisit>> getCustVisit(
//     {required String date, int? saleOrderTypeId}) async {
//   List<CustVisit> custVisits = [];
//   List args = ['$date%'];
//   String saleOrderTypeQuery = '';
//   if (saleOrderTypeId != null) {
//     saleOrderTypeQuery = 'AND ${DBConstant.saleOrderTypeId} =?';
//     args.add(1);
//   }
//   List<Map<String, dynamic>> jsonList =
//       await _sqlFLiteHelper.readDataByWhereArgs(
//     tableName: DBConstant.custVisitTable,
//     where: '${DBConstant.docDate} LIKE ? $saleOrderTypeQuery',
//     whereArgs: args,
//   );
//
//   for (Map<String, dynamic> jsonV in jsonList) {
//     CustVisit custVisit = CustVisit.fromJson(jsonV);
//     custVisits.add(custVisit);
//   }
//
//   return custVisits;
// }
//
// Future<List<SyncResponse>> getAutoSyncActionListByGroup(
//     String groupName) async {
//   List<SyncResponse> syncActionList = [];
//   List<Map<String, dynamic>> list = await _sqlFLiteHelper.readDataByWhereArgs(
//       tableName: DBConstant.mscmSyncActionTable,
//       // where:
//       //     '${DBConstant.isAutoSync} = ? AND ${DBConstant.actionGroupName} = ?',
//       where: '${DBConstant.isAutoSync} = ?',
//       whereArgs: [1]);
//   list.forEach((element) {
//     syncActionList.add(SyncResponse.fromJsonDB(element));
//   });
//   return syncActionList;
// }
//
// Future<List<SyncResponse>> getSyncActionList({bool? isAutoSync}) async {
//   List<SyncResponse> syncActionList = [];
//   List<Map<String, dynamic>> list;
//   if (isAutoSync != null) {
//     list = await _sqlFLiteHelper.readDataByWhereArgs(
//         tableName: DBConstant.mscmSyncActionTable,
//         where: '${DBConstant.isAutoSync} = ?',
//         whereArgs: [(isAutoSync ? 1 : 0)]);
//   } else {
//     list = await _sqlFLiteHelper.readAllData(
//         tableName: DBConstant.mscmSyncActionTable);
//   }
//   list.forEach((element) {
//     syncActionList.add(SyncResponse.fromJsonDB(element));
//   });
//   return syncActionList;
// }
//
// Future<List<PriceListItem>> getPriceListItem() async {
//   List<PriceListItem> _priceListItems = [];
//   List<Map<String, dynamic>> jsonList = await _sqlFLiteHelper.readAllData(
//       tableName: DBConstant.priceListItemTable,
//       orderBy: '${DBConstant.fixedPrice} DESC');
//   for (Map value in jsonList) {
//     _priceListItems.add(PriceListItem.fromJson(value));
//   }
//   return _priceListItems;
// }
//
// Future<bool> insertUrl(String serverUrl) async {
//   return _configInsert(ShKeys.serverUrlKey, serverUrl);
// }
//
// Future<bool> insertUsername(String username) async {
//   return _configInsert(ShKeys.username, username);
// }
//
// Future<bool> insertPassword(String password) async {
//   return _configInsert(ShKeys.password, password);
// }
//
// Future<bool> _configInsert(String key, String value) async {
//   List data = await _sqlFLiteHelper.readDataByWhereArgs(
//       tableName: DBConstant.configTable,
//       where: '${DBConstant.name} = ?',
//       whereArgs: [key]);
//   if (data.isNotEmpty) {
//     return _sqlFLiteHelper.updateData(
//         table: DBConstant.configTable,
//         where: '${DBConstant.name} = ?',
//         whereArgs: [
//           key
//         ],
//         data: {
//           DBConstant.name: key,
//           DBConstant.value: value,
//         });
//   } else {
//     return _sqlFLiteHelper.insertData(DBConstant.configTable, {
//       DBConstant.name: key,
//       DBConstant.value: value,
//     });
//   }
// }
}
