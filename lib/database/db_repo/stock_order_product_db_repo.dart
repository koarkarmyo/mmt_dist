
import '../../model/product/uom_lines.dart';
import '../../model/stock_order.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

class StockOrderDBRepo extends BaseDBRepo {
  static final StockOrderDBRepo _instance = StockOrderDBRepo._();

  StockOrderDBRepo._();

  factory StockOrderDBRepo() {
    return _instance;
  }

  Future<List<StockOrderLine>> getStockOrderLines() async {
    List<StockOrderLine> stockOrderLines = [];

    List<Map<String, dynamic>> jsonList =
        await helper.readAllData(tableName: DBConstant.stockOrderLineTable);

    for (final json in jsonList) {
      stockOrderLines.add(StockOrderLine.fromJson(json));
    }

    return stockOrderLines;
  }

  Future<bool> updateStockOrderProcess(StockOrderLine stockOrderLine) async {
    return await helper.updateData(
        table: DBConstant.stockOrderLineTable,
        where: '${DBConstant.productId}=?',
        whereArgs: [stockOrderLine.productId],
        data: stockOrderLine.toJsonDB());
  }

  Future<List<UomLine>> getUomLines(int productId) async {
    List<UomLine> uomLines = [];
    List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
        tableName: DBConstant.productUomTable,
        where: '${DBConstant.productId}=?',
        whereArgs: [productId]);

    for (final json in jsonList) {
      uomLines.add(UomLine.fromJsonDB(json));
    }

    return uomLines;
  }

  Future<bool> insertStockOrder(StockOrder stockOrder) async {
    int? id= await helper.insertData(
       table:  DBConstant.stockOrderTable, values:  stockOrder.toJsonDB());
    return id != null;
  }

  Future<bool> insertStockOrderLines(
      List<StockOrderLine> stockOrderLines) async {
    List<Map<String, dynamic>> jsonList = [];

    for (final orderLine in stockOrderLines) {
      jsonList.add(orderLine.toJsonDB());
    }

    bool isInserted = await helper.insertDataListBath(
        DBConstant.stockOrderLineTable, jsonList);
    return isInserted;
  }

  Future<List<StockOrder>> fetchStockOrder(
      {String? startDate, String? endDate}) async {
    List<StockOrder> stockOrders = [];
    List<StockOrderLine> stockOrderLine = [];

    List<Map<String, dynamic>> orderJson = await helper.readDataRaw(
        'SELECT * FROM ${DBConstant.stockOrderTable} WHERE (${DBConstant.writeDate} BETWEEN \'$startDate\' AND \'$endDate\') ');
    List<Map<String, dynamic>> orderLineJson =
        await helper.readAllData(tableName: DBConstant.stockOrderLineTable);

    orderJson.forEach((element) {
      stockOrders.add(StockOrder.fromJson(element));
    });

    orderLineJson.forEach((element) {
      stockOrderLine.add(StockOrderLine.fromJson(element));
    });

    stockOrders.forEach((order) {
      order.stockOrderLine = stockOrderLine
          .where((element) => element.orderId == order.id)
          .toList();
    });

    return stockOrders;
  }
}
