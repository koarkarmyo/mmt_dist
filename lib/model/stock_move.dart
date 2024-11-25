import 'package:flutter/cupertino.dart';

import 'lot.dart';

class StockMoveLine {
  int? id;
  String? batchNo;
  String? scheduledDate;
  int? pickingId;
  String? pickingName;
  double? productsAvailability;
  int? partnerId;
  String? partnerName;
  String? origin;
  int? locationId;
  int? locationDestId;
  int? moveId;
  int? saleLineId;
  int? productId;
  String? productName;
  int? productUomId;
  String? productUomName;
  double? productQty;
  double? productUomQty;
  double? qtyDone;
  int? lotId;
  String? lotName;
  bool? isChecked;
  List<Lot>? lotList;
  bool? isLot;
  List<StockMoveData>? data;
  TextEditingController? controller;

  StockMoveLine(
      {this.id,
      this.batchNo,
      this.scheduledDate,
      this.pickingId,
      this.pickingName,
      this.productsAvailability,
      this.partnerId,
      this.partnerName,
      this.origin,
      this.locationId,
      this.locationDestId,
      this.moveId,
      this.saleLineId,
      this.productId,
      this.productName,
      this.productUomId,
      this.productUomName,
      this.productQty,
      this.productUomQty,
      this.qtyDone,
      this.lotId,
      this.lotName,
      this.isChecked,
      this.lotList,
      this.isLot});

  StockMoveLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchNo = json['batch_no'];
    scheduledDate = json['scheduled_date'];
    pickingId = json['picking_id'];
    pickingName = json['picking_name'];
    productsAvailability = json['products_availability'];
    partnerId = json['partner_id'];
    partnerName = json['partner_name'];
    origin = json['origin'];
    locationId = json['location_id'];
    locationDestId = json['location_dest_id'];
    moveId = json['move_id'];
    saleLineId = json['sale_line_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productUomId = json['product_uom_id'];
    productUomName = json['product_uom_name'];
    productQty = json['product_qty'];
    productUomQty = json['product_uom_qty'];
    qtyDone = json['qty_done'];
    lotId = json['lot_id'];
    lotName = json['lot_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['batch_no'] = batchNo;
    data['scheduled_date'] = scheduledDate;
    data['picking_id'] = pickingId;
    data['picking_name'] = pickingName;
    data['products_availability'] = productsAvailability;
    data['partner_id'] = partnerId;
    data['partner_name'] = partnerName;
    data['origin'] = origin;
    data['location_id'] = locationId;
    data['location_dest_id'] = locationDestId;
    data['move_id'] = moveId;
    data['sale_line_id'] = saleLineId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_uom_id'] = productUomId;
    data['product_uom_name'] = productUomName;
    data['product_qty'] = productQty;
    data['product_uom_qty'] = productUomQty;
    data['qty_done'] = qtyDone;
    data['lot_id'] = lotId;
    data['lot_number'] = lotName;
    return data;
  }

  StockMoveLine copyWith({
    int? id,
    String? batchNo,
    String? scheduledDate,
    int? pickingId,
    String? pickingName,
    double? productsAvailability,
    int? partnerId,
    String? partnerName,
    String? origin,
    int? locationId,
    int? locationDestId,
    int? moveId,
    int? saleLineId,
    int? productId,
    String? productName,
    int? productUomId,
    String? productUomName,
    double? productQty,
    double? productUomQty,
    double? qtyDone,
    int? lotId,
    String? lotName,
    bool? isChecked,
    List<Lot>? lotList,
    bool? isLot,
  }) {
    return StockMoveLine(
      id: id ?? this.id,
      batchNo: batchNo ?? this.batchNo,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      pickingId: pickingId ?? this.pickingId,
      pickingName: pickingName ?? this.pickingName,
      productsAvailability: productsAvailability ?? this.productsAvailability,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      origin: origin ?? this.origin,
      locationId: locationId ?? this.locationId,
      locationDestId: locationDestId ?? this.locationDestId,
      moveId: moveId ?? this.moveId,
      saleLineId: saleLineId ?? this.saleLineId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productUomId: productUomId ?? this.productUomId,
      productUomName: productUomName ?? this.productUomName,
      productQty: productQty ?? this.productQty,
      productUomQty: productUomQty ?? this.productUomQty,
      qtyDone: qtyDone ?? this.qtyDone,
      lotId: lotId ?? this.lotId,
      lotName: lotName ?? this.lotName,
      isChecked: isChecked ?? this.isChecked,
      lotList: lotList ?? this.lotList,
      isLot: isLot ?? this.isLot,
    );
  }
}

class StockMoveData {
  double? qty;
  int? productUomId;
  String? productUomName;

  StockMoveData({this.qty, this.productUomId, this.productUomName});
}
