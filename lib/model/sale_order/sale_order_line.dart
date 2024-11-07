import '../../src/mmt_application.dart';
import '../product/product.dart';
import '../product/uom_lines.dart';
import '../stock_picking/stock_picking_model.dart';
import 'package:collection/collection.dart';

class SaleOrderLine {
  int? id;
  String? orderNo;
  int? orderId;
  int? productId;
  String? productName;
  SaleType? saleType;
  double? productUomQty;
  UomLine? uomLine;
  double? pkQty;
  double? pcQty;
  double? singleItemPrice;
  double? subTotal;
  double? singlePKPrice;
  double? singlePCPrice;

  SaleOrderLine({
    this.productId,
    this.id,
    this.productName,
    this.orderId,
    this.saleType,
    this.productUomQty,
    this.orderNo,
    this.uomLine,
    this.pkQty,
    this.pcQty,
    this.singleItemPrice,
    this.subTotal,
    this.singlePCPrice,
    this.singlePKPrice
  });

  SaleOrderLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderNo = json['order_no'];
    orderId = json['order_id'];
    productName = json['product_name'];
    saleType = SaleType.values.firstWhereOrNull(
            (element) => element.name.toLowerCase() == json['sale_type']) ??
        SaleType.sale;
    // saleType =
    //     json['sale_type'] == SaleType.sale.name ? SaleType.sale : SaleType.foc;
    productUomQty = json['product_uom_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_no'] = this.orderNo;
    data['order_id'] = this.orderId;
    data['product_name'] = this.productName;
    data['sale_type'] = this.saleType?.name;
    data['product_uom_qty'] = this.productUomQty;
    data['pk_qty'] = this.pkQty;
    data['pc_qty'] = pcQty;

    return data;
  }

  Map<String, dynamic> toJsonForSaleOrderApi({String state = 'draft'}) {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['order_no'] = orderNo;
    // map['order_id'] = orderId;
    map['product_id'] = productId;
    map['sale_type'] = saleType!.name.toLowerCase();
    map['name'] = productName;
    // map['state'] = state;


    map['product_uom_qty'] = productUomQty;
    return map;
  }

  SaleOrderLine copyWith({
    int? id,
    String? orderNo,
    int? orderId,
    int? productId,
    String? productName,
    SaleType? saleType,
    double? productUomQty,
    UomLine? uomLine,
    double? pkQty,
    double? pcQty,
    double? singleItemPrice,
    double? subTotal,
    double? singlePKPrice,
    double? singlePCPrice
  }) {
    return SaleOrderLine(id: id ?? this.id,
        orderNo: orderNo ?? this.orderNo,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        uomLine: uomLine ?? this.uomLine,
        pcQty: pcQty ?? this.pcQty,
        pkQty: pkQty ?? this.pkQty,
        productUomQty: productUomQty ?? this.productUomQty,
    );
  }


}
