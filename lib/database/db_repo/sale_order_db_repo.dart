import 'package:flutter/cupertino.dart';
import 'package:mmt_mobile/model/product/uom_lines.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:mmt_mobile/src/extension/nullable_extension.dart';
import 'package:mmt_mobile/utils/number_series_generator.dart';

import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';
import 'package:collection/collection.dart';

class SaleOrderDBRepo extends BaseDBRepo {
  static final SaleOrderDBRepo instance = SaleOrderDBRepo._();

  SaleOrderDBRepo._();

  factory SaleOrderDBRepo() {
    return instance;
  }

  Future<bool> saveSaleOrder(
      {required SaleOrder saleOrder,
      required List<SaleOrderLine> saleOrderLineList}) async {
    try {
      String vrNo = await NoSeriesGenerator.generateNoSeries(
          docType: NoSeriesDocType.order);
      saleOrder.name = vrNo;
      //
      int? id = await helper.insertData(
        table: DBConstant.saleOrderTable,
        values: saleOrder.toJsonDB(),
      );
      List<Map<String, dynamic>> saleOrderLineMapList = [];
      //
      saleOrderLineList.forEach(
        (element) {
          Map<String, dynamic> jsonData = element.toJsonDB();
          jsonData[DBConstant.orderNo] = saleOrder.name;
          saleOrderLineMapList.add(jsonData);
        },
      );

      await helper.insertDataListBath(
          DBConstant.saleOrderLineTable, saleOrderLineMapList);

      return true;
    } on Exception {
      return Future.value(false);
    }
  }

  Future<List<SaleOrder>> fetchSaleOrder(
      {bool? isUpload,
      String? customer,
      String? so,
      List<String>? fromToDate}) async {
    List<Map<String, dynamic>> uomJsonList =
        await helper.readAllData(tableName: DBConstant.productUomTable);
    //
    List<UomLine> uomLines = [];
    uomJsonList.forEach((element) {
      uomLines.add(UomLine.fromJsonDB(element));
    });
    //
    List<SaleOrder> saleOrderList = [];
    String query = '';
    List whereArgs = [];
    //
    if (so.isNull) {
      query += '${addAnd(query)} ${DBConstant.name} LIKE ? ';
      whereArgs.add('%%');
    }

    if (isUpload.isNotNull) {
      query += '${addAnd(query)} ${DBConstant.isUpload} =? ';
      whereArgs.add((isUpload ?? true) ? 1 : 0);
    }

    if (customer.isNotNull && customer!.isNotEmpty) {
      query += '${addAnd(query)} ${DBConstant.partnerName} LIKE ? ';
      whereArgs.add('%$customer%');
    }
    //
    if (so.isNotNull) {
      query += '${addAnd(query)} ${DBConstant.name} LIKE ? ';
      whereArgs.add('%$so%');
    }

    if (fromToDate.isNotNull && fromToDate!.length > 1) {
      // ${fromToDate[1]}
      query += '${addAnd(query)} ${DBConstant.dateOrder} BETWEEN ? AND ? ';
      whereArgs.add(fromToDate[0]);
      whereArgs.add(fromToDate[1]);
    }

    //
    List<Map<String, dynamic>> soList = await helper.readDataByWhereArgs(
      tableName: DBConstant.saleOrderTable,
      where: query,
      whereArgs: whereArgs,
      orderBy: '${DBConstant.id} DESC'
    );

    soList.forEach((element) {
      saleOrderList.add(SaleOrder.fromJsonDB(element));
    });

    List<Map<String, dynamic>> lineList = await helper.readDataByWhereArgs(
        tableName: DBConstant.saleOrderLineTable,
        where:
            '${DBConstant.orderNo} IN (${List.filled(saleOrderList.length, '?').join(',')})',
        whereArgs: saleOrderList.map((e) => e.name ?? '').toList());

    List<SaleOrderLine> lines = [];

    lineList.forEach((e) {
      SaleOrderLine line = SaleOrderLine.fromJson(e);
      line.uomLine =
          uomLines.firstWhereOrNull((e) => e.uomId == line.productUom);
      lines.add(line);
    });

    List<SaleOrder> tmp = [];

    saleOrderList.forEach((so) {
      so.orderLines =
          lines.where((element) => element.orderNo == so.name).toList();
      tmp.add(so);
    });

    return tmp;
  }
}
