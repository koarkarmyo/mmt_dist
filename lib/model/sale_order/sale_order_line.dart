
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
  double? productRefQty;
  double? qtyDelivered;
  double? qtyInvoiced;
  int? productUom;
  String? productUomName;
  double? priceUnit;
  double? priceSubtotal;
  int? productTemplateId;
  Product? product;
  String? nestedUom = '';
  String? nestedUomQtyDelivered = '';
  double? inputQty;
  double? discount;

  SaleOrderLine(
      {this.productId,
        this.id,
        this.productTemplateId,
        this.productName,
        this.orderId,
        this.saleType,
        this.productUomQty,
        this.qtyDelivered,
        this.qtyInvoiced,
        this.productUom,
        this.productUomName,
        this.priceUnit,
        this.orderNo,
        this.productRefQty,
        this.discount,
        this.priceSubtotal});

  SaleOrderLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderNo = json['order_no'];
    orderId = json['order_id'];
    productName = json['product_name'];
    productTemplateId = json['product_template_id'];
    saleType = SaleType.values.firstWhereOrNull(
            (element) => element.name.toLowerCase() == json['sale_type']) ??
        SaleType.sale;
    // saleType =
    //     json['sale_type'] == SaleType.sale.name ? SaleType.sale : SaleType.foc;
    productUomQty = json['product_uom_qty'];
    qtyDelivered = json['qty_delivered'];
    qtyInvoiced = json['qty_invoiced'];
    productUom = json['product_uom'];
    productUomName = json['product_uom_name'];
    priceUnit = json['price_unit'];
    discount = json['discount'];
    // if (saleType == SaleType.foc) {
    //   priceSubtotal = 0;
    // } else
    priceSubtotal = json['price_subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_no'] = this.orderNo;
    data['order_id'] = this.orderId;
    data['product_name'] = this.productName;
    data['product_template_id'] = this.productTemplateId;
    data['sale_type'] = this.saleType?.name;
    data['product_uom_qty'] = this.productUomQty;
    data['qty_delivered'] = this.qtyDelivered;
    data['qty_invoiced'] = this.qtyInvoiced;
    data['product_uom'] = this.productUom;
    data['product_uom_name'] = this.productUomName;
    data['price_unit'] = this.priceUnit;
    data['price_subtotal'] = this.priceSubtotal;
    data['discount'] = this.discount;
    return data;
  }

  Map<String, dynamic> toJsonForSaleOrderApi({String state = 'draft'}) {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['order_no'] = orderNo;
    // map['order_id'] = orderId;
    map['product_id'] = productId;
    map['product_template_id'] = productTemplateId;
    map['sale_type'] = saleType!.name.toLowerCase();
    map['name'] = productName;
    // map['state'] = state;
    map['price_unit'] = priceUnit;
    if (saleType == SaleType.disc) {
      map['price_unit'] = -(priceUnit ?? 0);
    }
    map['product_uom'] = productUom;
    map['discount'] = discount;
    map['product_uom_qty'] = productUomQty;
    return map;
  }

  double mustSendDeliveryQty() {
    return (productUomQty ?? 0) - (qtyDelivered ?? 0);
  }

  String mustSendQtyNested() {
    return MMTApplication.lBQtyLongFormChanger(
        product: product!, refQty: mustSendDeliveryQty());
  }

  void setDeliveryPrice(double price) {
    priceUnit = price;
    if (saleType == SaleType.foc) {
      priceSubtotal = 0;
    } else
      priceSubtotal = (qtyDelivered ?? 0) * price;
  }

  void setPrice(double price) {
    priceUnit = price;
    if (saleType == SaleType.foc) {
      priceSubtotal = 0;
    } else
      priceSubtotal = (productRefQty ?? 0) * price;
  }

  void setNestedUomQtyDelivered(String value) {
    List<String> list = value.split('/');
    double bQty = double.parse(list.first);
    double lQty = double.parse(list.last);

    UomLine? bUomLine = MMTApplication.getBoxUomLine(product!);
    UomLine? lUomLine = MMTApplication.getLUomLine(product!);
    double bRefQty = 0.0;
    double lRefQty = 0.0;
    if (bUomLine != null)
      bRefQty = MMTApplication.uomQtyToRefTotal(bUomLine, bQty);
    // else
    //   throw Exception('Box Uom Not found');
    if (lUomLine != null)
      lRefQty = MMTApplication.uomQtyToRefTotal(lUomLine, lQty);
    // else
    //   throw Exception('L Uom Not found');
    // double deliQty = qtyDelivered ?? 0;
    double deliQty = 0;
    deliQty += (bRefQty + lRefQty);

    inputQty = deliQty;

    nestedUomQtyDelivered = value;

    if (saleType == SaleType.foc) {
      priceSubtotal = 0;
    } else
      priceSubtotal = (inputQty ?? 0) * (priceUnit ?? 0);
  }

  // void setNestedUomQtyDelivered(String value) {
  //   List<String> list = value.split('/');
  //   double bQty = double.parse(list.first);
  //   double lQty = double.parse(list.last);
  //
  //   UomLine? bUomLine = MMTApplication.getBoxUomLine(product!);
  //   UomLine? lUomLine = MMTApplication.getLUomLine(product!);
  //   double bRefQty = 0.0;
  //   double lRefQty = 0.0;
  //   if (bUomLine != null)
  //     bRefQty = MMTApplication.uomQtyToRefTotal(bUomLine, bQty);
  //   else
  //     throw Exception('Box Uom Not found');
  //   if (lUomLine != null)
  //     lRefQty = MMTApplication.uomQtyToRefTotal(lUomLine, lQty);
  //   else
  //     throw Exception('Box Uom Not found');
  //   double deliQty = qtyDelivered ?? 0;
  //   deliQty += (bRefQty + lRefQty);
  //
  //   inputQty = deliQty;
  //
  //   nestedUomQtyDelivered = value;
  //
  //   if (saleType == SaleType.foc) {
  //     priceSubtotal = 0;
  //   } else
  //     priceSubtotal = (deliQty) * (priceUnit ?? 0);
  // }

  SaleOrderLine copyWith(
      {int? productId,
        int? id,
        int? orderId,
        int? productTemplateId,
        String? productName,
        SaleType? saleType,
        double? productUomQty,
        double? qtyDelivered,
        double? qtyInvoiced,
        int? productUom,
        String? productUomName,
        double? priceUnit,
        String? orderNo,
        double? priceSubtotal,
        double? discount}) {
    return SaleOrderLine(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      productTemplateId: productTemplateId ?? this.productTemplateId,
      productName: productName ?? this.productName,
      saleType: saleType ?? this.saleType,
      productUomQty: productUomQty ?? this.productUomQty,
      qtyDelivered: qtyDelivered ?? this.qtyDelivered,
      qtyInvoiced: qtyInvoiced ?? this.qtyInvoiced,
      productUom: productUom ?? this.productUom,
      productUomName: productUomName ?? this.productUomName,
      priceUnit: priceUnit ?? this.priceUnit,
      orderNo: orderNo ?? this.orderNo,
      priceSubtotal: priceSubtotal ?? this.priceSubtotal,
      discount: discount ?? this.discount,
    );
  }

  @override
  String toString() {
    return 'SaleOrderLine{orderNo: $orderNo, productId: $productId, productName: $productName, saleType: $saleType, productUomQty: $productUomQty, productRefQty: $productRefQty, qtyDelivered: $qtyDelivered, qtyInvoiced: $qtyInvoiced, productUomId: $productUom, productUomName: $productUomName, priceUnit: $priceUnit, priceSubtotal: $priceSubtotal, productTemplateId: $productTemplateId, nestedUom: $nestedUom}';
  }
}