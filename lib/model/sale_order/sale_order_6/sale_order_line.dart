// import '../../stock_picking/stock_picking_model.dart';
//
// class SaleOrderLineN {
//   int? id;
//   int? orderId;
//   String? name;
//   SaleType? saleType;
//   double? productUomQty;
//   String? productUom;
//   double? qtyDelivered;
//   double? qtyInvoiced;
//   double? priceUnit;
//   double? priceSubtotal;
//
//   SaleOrderLineN({
//     this.id,
//     this.orderId,
//     this.name,
//     this.saleType,
//     this.productUomQty,
//     this.productUom,
//     this.qtyDelivered,
//     this.qtyInvoiced,
//     this.priceUnit,
//     this.priceSubtotal,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': this.id,
//       'order_id': this.orderId,
//       'name': this.name,
//       'sale_type': this.saleType,
//       'product_uom_qty': this.productUomQty,
//       'product_uom': this.productUom,
//       'qty_delivered': this.qtyDelivered,
//       'qty_invoiced': this.qtyInvoiced,
//       'price_unit': this.priceUnit,
//       'price_subtotal': this.priceSubtotal,
//     };
//   }
//
//   factory SaleOrderLineN.fromMap(Map<String, dynamic> map) {
//     return SaleOrderLineN(
//       id: map['id'],
//       orderId: map['order_id'],
//       name: map['name'],
//       saleType: map['sale_type'],
//       productUomQty: map['product_uom_qty'],
//       productUom: map['product_uom'],
//       qtyDelivered: map['qty_delivered'],
//       qtyInvoiced: map['qty_invoiced'],
//       priceUnit: map['price_unit'],
//       priceSubtotal: map['price_subtotal'],
//     );
//   }
//
//   SaleOrderLineN copyWith({
//     int? id,
//     int? orderId,
//     String? name,
//     SaleType? saleType,
//     double? productUomQty,
//     String? productUom,
//     double? qtyDelivered,
//     double? qtyInvoiced,
//     double? priceUnit,
//     double? priceSubtotal,
//   }) {
//     return SaleOrderLineN(
//       id: id ?? this.id,
//       orderId: orderId ?? this.orderId,
//       name: name ?? this.name,
//       saleType: saleType ?? this.saleType,
//       productUomQty: productUomQty ?? this.productUomQty,
//       productUom: productUom ?? this.productUom,
//       qtyDelivered: qtyDelivered ?? this.qtyDelivered,
//       qtyInvoiced: qtyInvoiced ?? this.qtyInvoiced,
//       priceUnit: priceUnit ?? this.priceUnit,
//       priceSubtotal: priceSubtotal ?? this.priceSubtotal,
//     );
//   }
// }
