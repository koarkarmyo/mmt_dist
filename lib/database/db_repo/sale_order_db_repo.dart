import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:mmt_mobile/src/extension/nullable_extension.dart';
import 'package:mmt_mobile/utils/number_series_generator.dart';

import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

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

      bool saveSaleOrderLineSuccess = await helper.insertDataListBath(
          DBConstant.saleOrderLineTable, saleOrderLineMapList);

      return true;
    } on Exception {
      return Future.value(false);
    }
  }

  Future<List<SaleOrder>> fetchSaleOrder({bool? isUpload}) async {
    List<SaleOrder> saleOrderList = [];
    String query = '';
    List whereArgs = [];

    if (isUpload.isNotNull) {
      query += '${addAnd(query)} ${DBConstant.isUpload} =? ';
      whereArgs.add((isUpload ?? true) ? 1 : 0);
    }

    //
    List<Map<String, dynamic>> soList = await helper.readDataByWhereArgs(
        tableName: DBConstant.saleOrderTable,
        where: query,
        whereArgs: whereArgs);

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
      lines.add(SaleOrderLine.fromJson(e));
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
