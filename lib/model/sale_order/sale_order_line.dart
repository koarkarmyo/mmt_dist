import '../../database/db_constant.dart';
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
  UomLine? pkUomLine;
  UomLine? pcUomLine;
  double? pkQty;
  double? pcQty;
  double? singleItemPrice;
  double? subTotal;
  double? singlePKPrice;
  double? singlePCPrice;
  double? discountPercent;


  SaleOrderLine({
    this.productId,
    this.id,
    this.productName,
    this.orderId,
    this.saleType,
    this.productUomQty,
    this.orderNo,
    this.uomLine,
    this.pkUomLine,
    this.pcUomLine,
    this.pkQty,
    this.pcQty,
    this.singleItemPrice,
    this.subTotal,
    this.singlePCPrice,
    this.singlePKPrice,
    this.discountPercent
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
    data['pk_qty'] = pkQty;
    data['pc_qty'] = pcQty;
    data['pc_uomline'] = pcUomLine?.toJson();
    data['pk_uomLine'] = pkUomLine?.toJson();

    return data;
  }

  // '(${DBConstant.productId} INTEGER,'
  // '${DBConstant.id} INTEGER,'
  // '${DBConstant.productName} TEXT,'
  // '${DBConstant.orderNo} TEXT,'
  // '${DBConstant.orderId} INTEGER,'
  // '${DBConstant.saleType} TEXT,'
  // '${DBConstant.productUomQty} DOUBLE,'
  // '${DBConstant.productTemplateId} INTEGER,'
  // '${DBConstant.qtyDelivered} DOUBLE,'
  // '${DBConstant.qtyInvoiced} DOUBLE,'
  // '${DBConstant.productUom} INTEGER,'
  // '${DBConstant.productUomName} TEXT,'
  // '${DBConstant.priceUnit} DOUBLE,'
  // '${DBConstant.discount} DOUBLE,'
  // '${DBConstant.priceSubtotal} DOUBLE'

  Map<String,dynamic> toJsonDB(){

    Map<String,dynamic> data = {};

    data['product_id'] = productId;
    data['product_name'] = productName;
    data[DBConstant.orderNo] = orderNo;
    data[DBConstant.saleType] = saleType?.name;
    data[DBConstant.productUomQty] = productUomQty;
    data[DBConstant.productUom] = uomLine?.uomId;
    data[DBConstant.productUomName] = uomLine?.uomId;
    data[DBConstant.priceUnit] = singleItemPrice;
    // '${DBConstant.priceUnit} DOUBLE,'
    // '${DBConstant.discount} DOUBLE,'
    // '${DBConstant.priceSubtotal} DOUBLE'
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
    UomLine? pkUomLine,
    UomLine? pcUomLine,
    double? pkQty,
    double? pcQty,
    double? singleItemPrice,
    double? subTotal,
    double? singlePKPrice,
    double? singlePCPrice,
    double? discountPercent
  }) {
    return SaleOrderLine(id: id ?? this.id,
        orderNo: orderNo ?? this.orderNo,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        uomLine: uomLine ?? this.uomLine,
        pkUomLine: pkUomLine ?? this.pkUomLine,
        pcUomLine: pcUomLine ?? this.pcUomLine,
        pcQty: pcQty ?? this.pcQty,
        pkQty: pkQty ?? this.pkQty,
        productUomQty: productUomQty ?? this.productUomQty,
      singleItemPrice: singleItemPrice ?? this.singlePCPrice,
      singlePCPrice:  singlePCPrice ?? this.singlePCPrice,
      singlePKPrice: singlePKPrice ?? this.singlePKPrice,
      subTotal: subTotal ?? this.subTotal,
      discountPercent: discountPercent ?? this.discountPercent
    );
  }


}
