//
//
// class SaleOrderDBRepo extends BaseDBRepo {
//   static final SaleOrderDBRepo instance = SaleOrderDBRepo._();
//
//   SaleOrderDBRepo._();
//
//   Future<bool> updateSaleOrderQtyDelivered(SaleOrderLine saleOrderLine) async {
//     return helper.updateData(
//         table: DBConstant.saleOrderLineTable,
//         where: '${DBConstant.id} =? ',
//         whereArgs: [saleOrderLine.id],
//         data: saleOrderLine.toJson());
//   }
//
//   Future<void> insertCustVist(LocationData position, String docNo,
//       {bool fromWh = false}) async {
//     Partner customer = MMTApplication.currentSelectedCustomer!;
//     LoginResponse loginResponse = MMTApplication.loginResponse!;
//     CustVisit custVisit = CustVisit(
//         customerId: customer.id!,
//         customerName: customer.name,
//         docNo: docNo,
//         docDate: DateTimeUtils.yMmDdHMS.format(DateTime.now()),
//         docType: CustVisitTypes.order,
//         employeeId: loginResponse.id!,
//         vehicleId: loginResponse.currentLocationId,
//         fromWh: fromWh,
//         // vehicleId: loginResponse.deviceId!.vehicleId!.id!,
//         deviceId: loginResponse.deviceId!.id!,
//         latitude: position.latitude ?? 0.0,
//         fromDelivery: MMTApplication.fromDelivery,
//         longitude: position.longitude ?? 0.0,
//         isUpload: 0);
//     await DataObject.instance.insertCustVisit(custVisit);
//   }
//
//   Future<void> saveSaleOrder(SaleOrderHeader saleOrderHeader) async {
//     List<Map<String, dynamic>> saleOrderLineJsons = [];
//     for (SaleOrderLine saleOrderLine in saleOrderHeader.orderLine ?? []) {
//       saleOrderLineJsons.add(saleOrderLine.toJson());
//     }
//
//     await helper.insertDataListBath(
//         DBConstant.saleOrderLineTable, saleOrderLineJsons);
//     await helper.insertData(
//         DBConstant.saleOrderTable, saleOrderHeader.toJsonDB());
//   }
//
//   Future<List<SaleOrderLine>> getSaleOrderLineByOrderNoAndProductId(
//       String? orderNo, int? productId) async {
//     final jsonList = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderLineTable,
//         where: '${DBConstant.productId} = ? AND ${DBConstant.orderNo} =? ',
//         whereArgs: [orderNo, productId]);
//     List<SaleOrderLine> saleOrderLines = [];
//     jsonList.forEach((json) {
//       final saleOrderLine = SaleOrderLine.fromJson(json);
//       saleOrderLines.add(saleOrderLine);
//     });
//     return saleOrderLines;
//   }
//
//   Future<List<SaleOrderLine>> getSaleOrderReport(
//       {required String startDate, required String endDate}) async {
//     //
//     List<Product> products = await dataObject.getProducts();
//
//     final jsonList = await helper.rawQueryC(
//         """SELECT orderLine.* FROM sale_order saleOrder INNER JOIN sale_order_line orderLine on saleOrder.name = orderLine.order_no
//         WHERE (saleOrder.date_order BETWEEN \'$startDate\' AND \'$endDate\') ORDER BY orderLine.product_name
//         """);
//
//     // "2023-01-10%"
//     // var reportMap = jsonList.groupBy((p0) => p0['product_name']);
//     // print('Group by List: $reportMap');
//     List<SaleOrderLine> saleOrderLines = [];
//     jsonList.forEach((json) {
//       final saleOrderLine = SaleOrderLine.fromJson(json);
//
//       final product = products.firstWhereOrNull(
//           (element) => element.productId == saleOrderLine.productId);
//       saleOrderLine.product = product;
//       saleOrderLines.add(saleOrderLine);
//     });
//
//     return saleOrderLines;
//   }
//
//   Future<String> getCustomerSaleOrderWriteDate(int customerId) async {
//     List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderTable,
//         columns: ['write_date'],
//         where: '${DBConstant.partnerId} =?',
//         orderBy: '${DBConstant.writeDate} DESC',
//         whereArgs: [customerId]);
//     return jsonList.isEmpty
//         ? MMTApplication.loginResponse?.initialDatetime ?? '2021-03-23 13:34:12'
//         : jsonList.first['write_date'];
//   }
//
//   Future<List<SaleOrderLine>> getSaleOrderLineByOrderNo(String? name) async {
//     final jsonList = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderLineTable,
//         where: '${DBConstant.orderNo} =? ',
//         whereArgs: [name]);
//     List<SaleOrderLine> saleOrderLines = [];
//     jsonList.forEach((json) {
//       final saleOrderLine = SaleOrderLine.fromJson(json);
//       saleOrderLines.add(saleOrderLine);
//     });
//     return saleOrderLines;
//   }
//
//   deleteSaleOrder(BaseApiResponse apiResponse) async {
//     await helper.deleteRows(
//         tableName: DBConstant.saleOrderLineTable,
//         where: DBConstant.orderNo,
//         wantDeleteRow: apiResponse.data!.map((e) => e.name).toList());
//     await helper.deleteRows(
//         tableName: DBConstant.saleOrderTable,
//         where: DBConstant.name,
//         wantDeleteRow: apiResponse.data!.map((e) => e.name).toList());
//   }
//
//   Future<List<SaleOrderHeader>> insertCustSaleOrder(List<SaleOrderHeader> data,
//       {bool isUpload = false}) async {
//     List<Map<String, dynamic>> saleOrderLineJsonList = [];
//     List<Map<String, dynamic>> saleOrderHdrJsonList = data.map((saleOrder) {
//       saleOrder.isUpload = isUpload ? 1 : 0;
//       List<Map<String, dynamic>> temp =
//           saleOrder.orderLine?.map((saleOrderLine) {
//                 saleOrderLine.orderNo = saleOrder.name;
//                 return saleOrderLine.toJson();
//               }).toList() ??
//               [];
//       if (temp.isNotEmpty) saleOrderLineJsonList.addAll(temp);
//       return saleOrder.toJsonDB();
//     }).toList();
//     bool saleOrderSuccess = await helper.insertDataListBath(
//         DBConstant.saleOrderLineTable, saleOrderLineJsonList);
//     bool saleOrderLineSuccess = await helper.insertDataListBath(
//         DBConstant.saleOrderTable, saleOrderHdrJsonList);
//     if (saleOrderLineSuccess && saleOrderLineSuccess) {
//       return data;
//     }
//     return [];
//   }
//
//   getCustomerSaleOrderHdrs(int custID) async {
//     List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderTable,
//         where: '${DBConstant.partnerId} =?',
//         whereArgs: [custID]);
//     List<SaleOrderHeader> saleOrderHdrList = [];
//     jsonList.forEach((saleOrderJson) {
//       saleOrderHdrList.add(SaleOrderHeader.fromJson(saleOrderJson));
//     });
//     return saleOrderHdrList;
//   }
//
//   getDraftSaleOrderHdrs() async {
//     List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderTable,
//         where: '${DBConstant.isUpload} =?',
//         whereArgs: [0]);
//     List<SaleOrderHeader> saleOrderHdrList = [];
//     jsonList.forEach((saleOrderJson) {
//       saleOrderHdrList.add(SaleOrderHeader.fromJson(saleOrderJson));
//     });
//     return saleOrderHdrList;
//   }
//
//   Future<List<CartOrderDetail>> orderCartFetchListFromSaleOrder(
//       String orderNo, List<SaleOrderLine> saleOrderLines) async {
//     List<CartOrderDetail> cartOrderDetails = [];
//     List<Product> products = await dataObject.getProducts();
//     await Future.forEach<SaleOrderLine>(saleOrderLines, (saleOrderLine) async {
//       Product? product = products.firstWhereOrNull(
//           (element) => element.productId == saleOrderLine.productId);
//       // add price list to cart Item model
//       if (product != null) {
//         List<ProductPriceListItem> priceListItems = await ProductDBRepo.instance
//             .getPriceList(
//                 productId: product.id!,
//                 groupId: MMTApplication.currentSelectedCustomer!.pricelistId!);
//
//         // TODO : get balanceRefQty from server and show to
//         double balanceRefQty = 0.0;
//         // List<QtyCheckResponse> response =
//         // await QtyBalanceApiRepo().getBalanceQty([product.id ?? 0]);
//         // if (response.isNotEmpty) {
//         //   balanceRefQty = response.first.qtyAvailable ?? 0.0;
//         // }
//         CartOrderDetail cartOrderDetail;
//         // check promotion item or not
//         // if (product.productDetailType == ProductDetailTypes.product) {
//         if (MMTApplication.selectedCompany?.useLooseUom ?? true) {
//           // MMTApplication.loginResponse!.deviceId!.useLooseUom
//           // print("uom line : : ${product.uomLines.toString()}");
//           // print(saleOrderLine.productUom);
//           UomLine uomLine = product.uomLines!.firstWhere(
//               (element) => element.uomId == saleOrderLine.productUom);
//           double refQty = 0;
//           if (uomLine.uomType == 'reference') {
//             refQty = saleOrderLine.productUomQty!;
//           } else {
//             refQty = uomLine.ratio! * saleOrderLine.productUomQty!;
//           }
//           //
//           UomLine? boxUom = product.uomLines!
//               .firstWhereOrNull((element) => element.uomId == product.boxUomId);
//           double lQty = refQty % boxUom!.ratio!;
//           int bQty = refQty ~/ boxUom.ratio!;
//           cartOrderDetail = CartOrderDetail(
//               product: product,
//               saleType: saleOrderLine.saleType!,
//               suggestTotalQty: 0,
//               bQty: bQty.toDouble(),
//               bUomId: product.boxUomId,
//               bUomName: product.boxUomName,
//               lQty: lQty,
//               discount: saleOrderLine.discount ?? 0,
//               balanceQty: balanceRefQty,
//               lUomId: product.looseUomId,
//               lUomName: product.looseUomName,
//               defaultPrice: product.listPrice!,
//               priceListItems: priceListItems);
//         } else {
//           //
//           // UomLine? saleUom = product.uomLines!.firstWhereOrNull(
//           //     (element) => element.uomId == saleOrderLine.productUom);
//           // double lQty = MMTApplication.refToUom(saleUom!, saleOrderLine.productUomQty ?? 0);
//           cartOrderDetail = CartOrderDetail(
//               product: product,
//               saleType: saleOrderLine.saleType!,
//               suggestTotalQty: 0,
//               discount: saleOrderLine.discount ?? 0,
//               balanceQty: balanceRefQty,
//               lQty: saleOrderLine.productUomQty ?? 0,
//               lUomId: saleOrderLine.productUom,
//               lUomName: saleOrderLine.productUomName,
//               defaultPrice: product.listPrice ?? 0,
//               priceListItems: priceListItems,
//               bQty: 0);
//           cartOrderDetail.lPrice = saleOrderLine.priceUnit ?? 0;
//           cartOrderDetail.calculateSubtotal();
//         }
//         // } else {
//         // cartOrderDetail = CartOrderDetail(
//         // product: product,
//         // saleType: saleOrderLine.saleType!,
//         // suggestTotalQty: 0,
//         // balanceQty: balanceRefQty,
//         // discount: saleOrderLine.discount ?? 0,
//         // lQty: saleOrderLine.productUomQty ?? 0.0,
//         // lUomId: product.looseUomId,
//         // lUomName: product.looseUomName,
//         // defaultPrice: product.listPrice ?? 0.0,
//         // priceListItems: [],
//         // bQty: 0);
//
//         // }
//
//         // if(cartOrderDetail.product.)
//         // cartOrderDetail.lPrice = saleOrderLine.priceUnit ?? 0.0;
//         // if(cartOrderDetail.saleType == SaleType.values.first)
//         // cartOrderDetail.bPrice = saleOrderLine.priceUnit ?? 0.0;
//         // else
//         //   cartOrderDetail.lPrice = saleOrderLine.priceUnit ?? 0.0;
//         //
//         // cartOrderDetail.calculateSubtotal();
//
//         //TODO:Don't touch This Line(Kyaw Gyi)
//         cartOrderDetail.setPrice(saleOrderLine.priceUnit ?? 0.0);
//         if (saleOrderLine.priceUnit!.isNegative) {
//           cartOrderDetail.setPrice((saleOrderLine.priceUnit ?? 0.0).abs());
//         }
//         cartOrderDetail.setSubtotal(saleOrderLine.priceSubtotal ?? 0.0);
//
//         if (saleOrderLine.productUom == product.boxUomId) {
//           cartOrderDetail.bPrice = saleOrderLine.priceUnit ?? 0.0;
//           if (cartOrderDetail.bPrice.isNegative)
//             cartOrderDetail.bPrice = cartOrderDetail.bPrice.abs();
//         }
//
//         if (saleOrderLine.productUom == product.looseUomId) {
//           cartOrderDetail.lPrice = saleOrderLine.priceUnit ?? 0.0;
//           if (cartOrderDetail.lPrice.isNegative)
//             cartOrderDetail.lPrice = cartOrderDetail.lPrice.abs();
//         }
//
//         // if(saleOrderLine.priceSubtotal == 0.0)
//         cartOrderDetail.calculateSubtotal();
//
//         cartOrderDetails.add(cartOrderDetail);
//       }
//     });
//
//     print(cartOrderDetails.length);
//
//     List<CartOrderDetail> tempList = [];
//     cartOrderDetails.forEach((cartOrderDetail) {
//       print(cartOrderDetail.price);
//       print(cartOrderDetail.subtotal);
//       int index = tempList.indexWhere((element) {
//         return element.saleType == cartOrderDetail.saleType &&
//             element.product.id == cartOrderDetail.product.id;
//         // return element.saleType == cartOrderDetail.saleType &&
//         //         element.product.id == cartOrderDetail.product.id &&
//         //         (MMTApplication.selectedCompany?.useLooseUom ?? true)
//         //     ? true
//         //     : cartOrderDetail.lUomId == element.lUomId;
//       });
//       if (index < 0) {
//         tempList.add(cartOrderDetail);
//       } else {
//         CartOrderDetail detail = tempList[index];
//         // CartOrderDetail temp = detail.copyWith(
//         //     bQty: cartOrderDetail.bQty + detail.bQty,
//         //     lQty: cartOrderDetail.lQty + detail.lQty);
//         detail.lPrice = cartOrderDetail.lPrice;
//         detail.bQty = cartOrderDetail.bQty + detail.bQty;
//         detail.lQty = cartOrderDetail.lQty + detail.lQty;
//         detail.calculateSubtotal();
//         tempList[index] = detail;
//       }
//     });
//
//     return tempList;
//   }
//
//   Future<SaleOrderHeader?> getSaleOrderById(int? orderId) async {
//     SaleOrderHeader? saleOrderHeader;
//     List<Map<String, dynamic>> saleOrderJsonList = await helper
//         .readDataByWhereArgs(
//             tableName: DBConstant.saleOrderTable,
//             where: '${DBConstant.id}=?',
//             whereArgs: [orderId]);
//
//     if (saleOrderJsonList.isNotEmpty) {
//       saleOrderHeader = SaleOrderHeader.fromJson(saleOrderJsonList.first);
//
//       List<Map<String, dynamic>> orderLineJsonList = await helper
//           .readDataByWhereArgs(
//               tableName: DBConstant.saleOrderLineTable,
//               where: '${DBConstant.orderNo}=?',
//               whereArgs: [saleOrderHeader.name]);
//
//       if (orderLineJsonList.isNotEmpty) {
//         List<SaleOrderLine> orderLines =
//             orderLineJsonList.map((e) => SaleOrderLine.fromJson(e)).toList();
//         saleOrderHeader.orderLine = orderLines;
//       }
//     }
//   }
//
//   Future<SaleOrderHeader?> getSaleOrderByOrderNo(String? orderNo) async {
//     SaleOrderHeader? saleOrderHeader;
//     List<Map<String, dynamic>> saleOrderJsonList = await helper
//         .readDataByWhereArgs(
//             tableName: DBConstant.saleOrderTable,
//             where: '${DBConstant.name}=?',
//             whereArgs: [orderNo]);
//
//     if (saleOrderJsonList.isNotEmpty) {
//       saleOrderHeader = SaleOrderHeader.fromJson(saleOrderJsonList.first);
//       List<SaleOrderLine> saleOrderLine =
//           await getSaleOrderLineByOrderNo(orderNo);
//       saleOrderHeader.orderLine = saleOrderLine;
//     }
//
//     return saleOrderHeader;
//   }
//
//   Future<bool> insertDeletedSaleOrder(
//       {required int newId, required SaleOrderHeader saleOrderHdr}) async {
//     List<Map<String, dynamic>> orderLineJsonList = [];
//
//     if (saleOrderHdr.orderLine?.isNotEmpty == true) {
//       orderLineJsonList =
//           saleOrderHdr.orderLine?.map((e) => e.toJson()).toList() ?? [];
//     }
//
//     bool isDeleted = await helper.deleteData(DBConstant.saleOrderLineTable,
//         '${DBConstant.orderNo}=?', [saleOrderHdr.name]);
//
//     bool isUpdated = await helper.updateData(
//         table: DBConstant.saleOrderTable,
//         where: '${DBConstant.id}=?',
//         whereArgs: [saleOrderHdr.id],
//         data: saleOrderHdr.toJsonDB());
//
//     bool isLinesInserted = await helper.insertDataListBath(
//         DBConstant.saleOrderLineTable, orderLineJsonList);
//
//     return isDeleted && isUpdated && isLinesInserted;
//   }
//
//   Future<bool> checkQtyAvailableOrNot(List<SaleOrderLine> saleOrderLines,
//       [bool fromDirectSale = false]) async {
//     // remove duplicate item
//     List<int> tempIds = _getIdFromOrderDetails(saleOrderLines).toSet().toList();
//
//     // normal sale
//     if (!MMTApplication.loginResponse!.deviceId!.useLooseUom! ||
//         MMTApplication.fromDirectSale) {
//       // clear and add to list
//       saleOrderLines =
//           await SaleOrderUtils.getSaleOrderLinesRef(saleOrderLines);
//     }
//
//     List<SaleOrderLine> tempLines = [];
//
//     saleOrderLines.forEach((orderLine) {
//       int index = tempLines
//           .indexWhere((element) => element.productId == orderLine.productId);
//       if (index > -1) {
//         // if(tempLines[index].productUomId != orderLine.productUomId){
//         //   tempLines[index].productUomQty = tempLines[index];
//         // }
//
//         double qty = tempLines[index].productUomQty! + orderLine.productUomQty!;
//         tempLines[index] = orderLine.copyWith(productUomQty: qty);
//         // tempLines[index].productUomQty =
//         //     tempLines[index].productUomQty! + orderLine.productUomQty!;
//       } else {
//         tempLines.add(orderLine);
//       }
//     });
//
//     List<QtyCheckResponse> qtyCheckList = [];
//
//     String resultString = "(${tempIds.join(',')})";
//
//     if (MMTApplication.loginResponse!.deviceId!.checkAvailableQuantity!) {
//       int locationId =
//           MMTApplication.loginResponse?.warehouseStockLocationId ?? 0;
//       if (fromDirectSale)
//         locationId = MMTApplication.loginResponse?.currentLocationId ?? 0;
//
//       List<Map<String, dynamic>> jsonList = await helper.readDataRaw(
//           'SELECT * FROM ${DBConstant.stockQuantTable} WHERE ${DBConstant.locationId} = $locationId AND ${DBConstant.productId} IN $resultString');
//       List<StockQuant> stockProducts =
//           jsonList.map((e) => StockQuant.fromJson(e)).toList();
//       for (final stockQuant in stockProducts) {
//         qtyCheckList.add(QtyCheckResponse(
//             id: stockQuant.productId,
//             qtyAvailable: stockQuant.availableQuantity));
//       }
//     }
//
//     tempLines.forEach((saleOrderLine) {
//       QtyCheckResponse? qtyCheckResponse = qtyCheckList.firstWhereOrNull(
//           (qtyResponse) => qtyResponse.id == saleOrderLine.productId);
//       if (saleOrderLine.productUomQty! >
//           (qtyCheckResponse?.qtyAvailable ?? 0.0)) {
//         throw QtyNotAvailableException(saleOrderLine.productName!);
//       }
//     });
//     // for (int i = 0; i < tempLines.length; i++) {
//     // promotion check only saleable product
//     // if (tempLines[i].productUomQty! >
//     //     (baseApiResponse.data![i].qtyAvailable ?? 0.0)) {
//     //
//     // }
//     // }
//
//     return true;
//   }
//
//   List<int> _getIdFromOrderDetails(List<SaleOrderLine> orderDetails) {
//     List<int> orderLineIds = [];
//     orderDetails.forEach((element) {
//       orderLineIds.add(element.productId!);
//     });
//     return orderLineIds;
//   }
//
//   updateNoSeries() async {
//     /* Update Number Series After Local Save*/
//     await helper.updateData(
//         table: DBConstant.numberSeriesTable,
//         where: '${DBConstant.name} =?',
//         whereArgs: [
//           NoSeriesDocType.order.name
//         ],
//         data: {
//           DBConstant.numberLast: MMTApplication.generatedNoSeries!.numberLast,
//           DBConstant.yearLast: MMTApplication.generatedNoSeries!.yearLast,
//           DBConstant.monthLast: MMTApplication.generatedNoSeries!.monthLast,
//           DBConstant.dayLast: MMTApplication.generatedNoSeries!.dayLast,
//         });
//   }
//
//   updateResponseOrder(
//       {required SaleOrderHeader preOrder,
//       required SaleOrderHeader curOrder}) async {
//     List<SaleOrderLine> saleLines = curOrder.orderLine ?? [];
//     // delete from response
//     await helper.deleteData(
//         DBConstant.saleOrderTable, '${DBConstant.name}=?', [curOrder.name]);
//     // delete from old
//     await helper.deleteData(
//         DBConstant.saleOrderTable, '${DBConstant.name}=?', [preOrder.name]);
//     // delete from id
//     await helper.deleteData(
//         DBConstant.saleOrderTable, '${DBConstant.id}=?', [curOrder.id]);
//     // delete from response
//     await helper.deleteData(DBConstant.saleOrderLineTable,
//         '${DBConstant.orderNo}=?', [preOrder.name]);
//     // delete form old
//     await helper.deleteData(DBConstant.saleOrderLineTable,
//         '${DBConstant.orderNo}=?', [curOrder.name]);
//     // delete from id
//     await helper.deleteData(DBConstant.saleOrderLineTable,
//         '${DBConstant.orderId}=?', [curOrder.id]);
//
//     List<Map<String, dynamic>> jsonList =
//         saleLines.map((e) => e.toJson()).toList();
//
//     await helper.insertData(DBConstant.saleOrderTable, curOrder.toJsonDB());
//     await helper.insertDataListBath(DBConstant.saleOrderLineTable, jsonList);
//   }
//
//   Future<List<SaleOrderHeader>> getSaleOrderHdrOnly(String date) async {
//     List<Map<String, dynamic>> jsonMap = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderTable,
//         where: '${DBConstant.writeDate} Like ?',
//         whereArgs: ['$date%']);
//     List<SaleOrderHeader> saleOrderHdrList = [];
//     jsonMap.forEach((element) {
//       saleOrderHdrList.add(SaleOrderHeader.fromJson(element));
//     });
//     return saleOrderHdrList;
//   }
//
//   Future<List<SaleOrderHeader>> getSaleOrderHdrOnlyDateRange(
//       {required String? fromDate,
//       required String? toDate,
//       required DeliveryReportTypes filterTypes}) async {
//     String filterQuery;
//     if (filterTypes == DeliveryReportTypes.all) {
//       filterQuery = '%';
//     } else {
//       filterQuery = '${filterTypes.name}';
//     }
//
//     List<Map<String, dynamic>> jsonMap = await helper.readDataByWhereArgs(
//         tableName: DBConstant.saleOrderTable,
//         where:
//             '${DBConstant.writeDate} Between ? and ? and ${DBConstant.deliveryStatus} like  \'%$filterQuery%\'',
//         whereArgs: ['$fromDate%', '$toDate%']);
//     List<SaleOrderHeader> saleOrderHdrList = [];
//     jsonMap.forEach((element) {
//       saleOrderHdrList.add(SaleOrderHeader.fromJson(element));
//     });
//     return saleOrderHdrList;
//   }
//
//   Future<List<SaleOrderLine>> getUnsoldOrderLine(
//       {required String startDate, required String endDate}) async {
//     List<SaleOrderLine> saleOrderLineList = [];
//
//     List<Product> productList =
//         await getUnsoldProduct(startDate: startDate, endDate: endDate);
//     productList.forEach((element) {
//       SaleOrderLine saleOrderLine = SaleOrderLine(
//           productName: element.name, productId: element.productId);
//       saleOrderLineList.add(saleOrderLine);
//     });
//
//     return saleOrderLineList;
//   }
//
//   Future<List<Product>> getUnsoldProduct(
//       {required String startDate, required String endDate}) async {
//     List<Map<String, dynamic>> jsonList = await helper
//         .rawQueryC('''SELECT * FROM products WHERE product_id not in
//     (SELECT DISTINCT line.product_id FROM sale_order so JOIN sale_order_line
//     line on so.name = line.order_no
//     WHERE ${DBConstant.dateOrder} Between \'${startDate}\' and \'${endDate}\' AND picking_no IS NULL
//     AND sale_person = ${MMTApplication.loginResponse?.id ?? 0}
//         ORDER BY write_date DESC) AND detailed_type = \'${ProductDetailTypes.product.name}\'''');
//     List<Product> productList = [];
//     jsonList.forEach((element) {
//       productList.add(Product.fromJsonDB(element));
//     });
//
//     return productList;
//   }
//
//   Future<List<DailySale>> getTodaySale(
//       {required String startDate, required String endDate}) async {
//     List<Map<String, dynamic>> jsonList = await helper.rawQueryC(
//         '''SELECT sum(line.product_uom_qty) as product_uom_qty, line.product_name,so.partner_id, so.partner_name, line.product_uom, line.product_uom_name, line.price_subtotal FROM sale_order so JOIN sale_order_line line
//            on so.name = line.order_no WHERE so.date_order BETWEEN '$startDate' AND '$endDate' GROUP BY line.product_id, line.product_uom''');
//     List<DailySale> dailySaleList = [];
//
//     jsonList.forEach((element) {
//       dailySaleList.add(DailySale.fromMap(element));
//     });
//
//     return dailySaleList;
//   }
//
//   Future<List<Map<String, dynamic>>> needToInsertData(
//       {required String startDate, required String endDate}) async {
//     List<Map<String, dynamic>> data = await helper.rawQueryC(
//         '''Select A.row_1, A.row_2, A.col_1, A.col_2, sum(A.qty) qty,A.l_ratio, A.b_ratio,'0/0' lb_qty, sum(A.price_subtotal) as total_amount
// from (
// SELECT so.partner_id row_1,so.partner_name row_2,sol.product_id col_1,sol.product_name col_2,
// l_uom.ratio as l_ratio,b_uom.ratio as b_ratio,
// sol.product_uom_qty * uom.ratio as qty, sol.price_subtotal
// from sale_order so
// inner JOIN sale_order_line sol on so.id = sol.order_id
// inner JOIN uom_uom uom on sol.product_id = uom.product_id and sol.product_uom = uom.uom_id
// inner join products p on sol.product_id = p.product_id
// left join uom_uom l_uom on p.product_id = l_uom.product_id and  p.loose_uom_id = l_uom.uom_id
// left join uom_uom b_uom on p.product_id = b_uom.product_id and  p.box_uom_id = b_uom.uom_id WHERE so.date_order BETWEEN '$startDate' AND '$endDate') as A
// group by A.row_1, A.row_2, A.col_1, A.col_2
// UNION
// Select B.row_1, B.row_2, B.col_1, B.col_2, sum(B.qty) qty,B.l_ratio, B.b_ratio,'0/0' lb_qty, sum(B.price_subtotal) as total_amount
// from (
// SELECT 999999 row_1,'TOTAL' row_2,sol.product_id col_1,sol.product_name col_2,
// l_uom.ratio as l_ratio,b_uom.ratio as b_ratio,
// sol.product_uom_qty * uom.ratio as qty, sol.price_subtotal
// from sale_order so
// inner JOIN sale_order_line sol on so.id = sol.order_id
// inner JOIN uom_uom uom on sol.product_id = uom.product_id and sol.product_uom = uom.uom_id
// inner join products p on sol.product_id = p.product_id
// left join uom_uom l_uom on p.product_id = l_uom.product_id and  p.loose_uom_id = l_uom.uom_id
// left join uom_uom b_uom on p.product_id = b_uom.product_id and  p.box_uom_id = b_uom.uom_id WHERE so.date_order BETWEEN '$startDate' AND '$endDate') as B
// group by B.row_1, B.row_2, B.col_1, B.col_2;''');
//     List<DailySaleTemp> tempList = [];
//
//     data.forEach((element) {
//       DailySaleTemp temp = DailySaleTemp.fromMap(element);
//       // print(temp.lbQty);
//       tempList.add(temp);
//     });
//
//     List<Map<String, dynamic>> tempJson = [];
//     tempList.forEach((element) {
//       tempJson.add(element.toMap());
//     });
//
//     await helper.deleteAllRow(tableName: DBConstant.dailyReportTempTable);
//
//     await helper.insertDataListBath(DBConstant.dailyReportTempTable, tempJson);
//
//     List<DailySale> dailySaleList =
//         await getTodaySale(startDate: startDate, endDate: endDate);
//
//     if (dailySaleList.isNotEmpty) {
//       String queryData = '';
//       for (int i = 0; i < dailySaleList.length; i++) {
//         String value =
//             "MAX(CASE WHEN col_2='${dailySaleList[i].productName}' THEN lb_qty END) AS \'${dailySaleList[i].productName}\'";
//         queryData += "$value${i != (dailySaleList.length - 1) ? ',' : ''}";
//       }
//
//       List<Map<String, dynamic>> jsonList = await helper.rawQueryC(
//           '''select row_2 as partner_name, $queryData,sum(total_amount) total_amount
//           from ${DBConstant.dailyReportTempTable}
//           group by row_2 order by row_1 ASC''');
//       return jsonList;
//     }
//     return [];
//   }
//
//   Future<List<Map<String, dynamic>>> getSaleDaily(
//       {required String startDate, required String endDate}) async {
//     List<DailySale> dailySaleList =
//         await getTodaySale(startDate: startDate, endDate: endDate);
//
//     String queryData = '';
//     for (int i = 0; i < dailySaleList.length; i++) {
//       String value =
//           "MAX(CASE WHEN product_name='${dailySaleList[i].productName}' THEN quantity END) AS \'${dailySaleList[i].productName}\'";
//       queryData += "$value${i != (dailySaleList.length - 1) ? ',' : ''}";
//     }
//
//     String query = '''
//     WITH customer_products AS (
// SELECT so.partner_id,so.partner_name,sol.product_name,sol.product_uom_qty as quantity
// from sale_order so
// inner JOIN sale_order_line sol on so.id = sol.order_id)
// SELECT
//   partner_name,
//   $queryData
// FROM
//   customer_products
// GROUP BY
//   partner_name
//     ''';
//
//     List<Map<String, dynamic>> json = await helper.rawQueryC(query);
//     print(json.length);
//     print(json.toString());
//
//     return json;
//   }
// }
