import 'package:flutter/foundation.dart';

import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

class SaleOrderDbRepo extends BaseDBRepo {
  static final SaleOrderDbRepo instance = SaleOrderDbRepo._();

  SaleOrderDbRepo._();

  Future<bool> saveSaleOrder(
      {required SaleOrder saleOrder,
      required List<SaleOrderLine> saleOrderLineList}) async {
    try {
      int? id = await helper.insertData(
          table: DBConstant.saleOrderTable, values: saleOrder.toJsonDB());
      List<Map<String, dynamic>> saleOrderLineMapList = [];

      saleOrderLineList.forEach(
        (element) {
          Map<String, dynamic> jsonData = element.toJsonDB();
          jsonData[DBConstant.orderNo] = saleOrder.name;
          saleOrderLineMapList.add(jsonData);
        },
      );

      bool saveSaleOrderLineSuccess = await helper.insertDataListBath(
          DBConstant.saleOrderLineTable, saleOrderLineMapList);

      return saveSaleOrderLineSuccess;
    } on Exception {
      return Future.value(false);
    }
  }
}
