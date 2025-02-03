import 'package:collection/collection.dart';
import 'package:mmt_mobile/database/product_repo/product_db_repo.dart';

import '../database/base_db_repo.dart';
import '../database/data_object.dart';
import '../model/product/product_product.dart';
import '../model/product/uom_lines.dart';
import '../model/sale_order/sale_order_line.dart';
import '../model/stock_quant.dart';
import '../src/mmt_application.dart';

class SaleOrderUtils extends BaseDBRepo {
  static Future<List<SaleOrderLine>> getSaleOrderLinesRef(
      List<SaleOrderLine> saleOrderLines) async {
    List<SaleOrderLine> refQtyList = [];
    await Future.forEach<SaleOrderLine>(saleOrderLines, (saleOrderLine) async {
      List<UomLine> uomLines =
          await DataObject.instance.getUomLines(saleOrderLine.productId!);
      UomLine usedUomLine = uomLines.firstWhere(
          (uomLine) => saleOrderLine.uomLine?.uomId == uomLine.uomId);
      double refQty =
          uomQtyToRefTotal(usedUomLine, saleOrderLine.productUomQty!);
      refQtyList.add(saleOrderLine.copyWith(productUomQty: refQty));
    });
    // clear and add to list
    saleOrderLines = refQtyList;
    return saleOrderLines;
  }

  static double uomQtyToRefTotal(UomLine uomLine, double quantity) {
    double totalQty = 0;
    if (uomLine.uomType == 'bigger') {
      totalQty = quantity * uomLine.ratio!;
    } else if (uomLine.uomType == 'smaller') {
      totalQty = quantity / uomLine.ratio!;
    } else if (uomLine.uomType == 'reference') {
      totalQty = quantity * uomLine.ratio!;
    }
    return totalQty;
  }

  static stockQuantQtyToBLString(StockQuant stockQuant, double refQty) async {
    StringBuffer sb = StringBuffer();
    List<UomLine> uomLines =
        await DataObject.instance.getUomLines(stockQuant.productId ?? 0);

    UomLine? uomLine =
        uomLines.firstWhereOrNull((element) => element.uomType == 'bigger');

    if (uomLine != null) {
      int bQty = refQty ~/ uomLine.ratio!;
      int lQty = (refQty % uomLine.ratio!).floor();
      sb.write(bQty);
      sb.write("/");
      sb.write(lQty);
    } else {
      int bQty = refQty ~/ uomLines.first.ratio!;
      int lQty = (refQty % uomLines.first.ratio!).floor();
      sb.write(bQty);
      sb.write("/");
      sb.write(lQty);
    }

    // uomLines.forEach((uomLine) {
    // if (uomLine.uomId == stockQuant.productUomId &&
    //     uomLine.uomType == 'reference') {
    //   int bQty = refQty ~/ uomLine.ratio!;
    //   int lQty = (refQty % uomLine.ratio!).floor();
    //   sb.write(bQty);
    //   sb.write("/");
    //   sb.write(lQty);
    // } else if (uomLine.uomId == stockQuant.productUomId &&
    //     uomLine.uomType == "bigger") {
    //   int bQty = refQty ~/ uomLine.ratio!;
    //   int lQty = (refQty % uomLine.ratio!).floor();
    //   sb.write(bQty);
    //   sb.write("/");
    //   sb.write(lQty);
    // } else if (uomLine.uomId == stockQuant.productUomId &&
    //     uomLine.uomType == 'smaller') {
    //   sb.write(0);
    //   sb.write("/");
    //   double lQty = refQty.floor() * (uomLine.ratio ?? 1);
    //   sb.write(lQty);
    // }
    // });
    return sb.toString();
  }

  static Future<String> refQtyToLBString(int productId, double refQty) async {
    ProductProduct? product =
        await ProductDBRepo.instance.getProductById(productId: productId);

    if (product == null) return '0/$refQty';

    return MMTApplication.lBQtyLongFormChanger(
        product: product, refQty: refQty);
  }
}
