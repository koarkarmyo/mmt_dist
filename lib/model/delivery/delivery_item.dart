
import '../product/product.dart';
import '../product/uom_lines.dart';
import '../stock_picking/stock_picking_model.dart';

class DeliveryItem {
  int? productId;
  String? productName;
  double? orderRefQty;
  double? deliverRefQty;
  double? deliverBQty;
  double? deliverLQty;
  String? balanceString;
  Product? product;
  double? subtotal;
  double? bPrice;
  SaleType? saleType;
  double? lPrice;
  double? refPrice = 0;
  UomLine? uomLine;
  double? balanceQty;

  DeliveryItem({
    this.productId,
    this.productName,
    this.orderRefQty,
    this.deliverRefQty,
    this.deliverBQty,
    this.deliverLQty,
    this.balanceString,
    this.subtotal,
    this.product,
    this.saleType,
    this.bPrice,
    this.lPrice,
    this.refPrice,
    this.uomLine,
    this.balanceQty,
  }) {
    calculateSubtotal();
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {};

    data['product_id'] = productId;
    data['product_name'] = productName;
    data['uomline'] = uomLine?.toJson();
    data['qty'] = deliverBQty;

    return data;

  }

  DeliveryItem copyWith({
    int? productId,
    String? productName,
    double? orderRefQty,
    double? deliverRefQty,
    double? deliverBQty,
    String? balanceString,
    Product? product,
    double? subtotal,
    SaleType? saleType,
    double? deliverLQty,
    double? bPrice,
    double? lPrice,
    double? refPrice,
    UomLine? uomLine,
    double? balanceQty,
  }) {
    return DeliveryItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      balanceString: balanceString ?? this.balanceString,
      orderRefQty: orderRefQty ?? this.orderRefQty,
      product: product ?? this.product,
      deliverRefQty: deliverRefQty ?? this.deliverRefQty,
      subtotal: subtotal ?? this.subtotal,
      deliverBQty: deliverBQty ?? this.deliverBQty,
      saleType: saleType ?? this.saleType,
      deliverLQty: deliverLQty ?? this.deliverLQty,
      bPrice: bPrice ?? this.bPrice,
      lPrice: lPrice ?? this.lPrice,
      refPrice: refPrice ?? this.refPrice,
      uomLine: uomLine ?? this.uomLine,
      balanceQty: balanceQty ?? this.balanceQty,
    );
  }

  void calculateSubtotal() {
    double bTotal = (this.bPrice ?? 0) * (this.deliverBQty ?? 0);
    double lTotal = (this.lPrice ?? 0) * (this.deliverLQty ?? 0);
    this.subtotal = bTotal + lTotal;
  }

  // String get balanceQtyWithoutLooseBox {
  //   print('CCCCCCCCCCCCC:::::$balanceQty');
  //   return MMTApplication.nestedUomChanger(
  //       this.balanceQty ?? 0, product?.uomLines ?? []);
  // }
}
