class StockMoveLine {
  String? batchNo;
  String? scheduledDate;
  int? pickingId;
  String? pickingName;
  double? productsAvailability;
  int? partnerId;
  String? partnerName;
  String? origin;
  int? locationId;
  int? moveId;
  int? saleLineId;
  int? productId;
  String? productName;
  int? productUomId;
  String? productUomName;
  int? productQty;
  double? productUomQty;
  double? qtyDone;

  StockMoveLine(
      {this.batchNo,
      this.scheduledDate,
      this.pickingId,
      this.pickingName,
      this.productsAvailability,
      this.partnerId,
      this.partnerName,
      this.origin,
      this.locationId,
      this.moveId,
      this.saleLineId,
      this.productId,
      this.productName,
      this.productUomId,
      this.productUomName,
      this.productQty,
      this.productUomQty,
      this.qtyDone});

  StockMoveLine.fromJson(Map<String, dynamic> json) {
    batchNo = json['batch_no'];
    scheduledDate = json['scheduled_date'];
    pickingId = json['picking_id'];
    pickingName = json['picking_name'];
    productsAvailability = json['products_availability'];
    partnerId = json['partner_id'];
    partnerName = json['partner_name'];
    origin = json['origin'];
    locationId = json['location_id'];
    moveId = json['move_id'];
    saleLineId = json['sale_line_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productUomId = json['product_uom_id'];
    productUomName = json['product_uom_name'];
    productQty = json['product_qty'];
    productUomQty = json['product_uom_qty'];
    qtyDone = json['qty_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['batch_no'] = batchNo;
    data['scheduled_date'] = scheduledDate;
    data['picking_id'] = pickingId;
    data['picking_name'] = pickingName;
    data['products_availability'] = productsAvailability;
    data['partner_id'] = partnerId;
    data['partner_name'] = partnerName;
    data['origin'] = origin;
    data['location_id'] = locationId;
    data['move_id'] = moveId;
    data['sale_line_id'] = saleLineId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_uom_id'] = productUomId;
    data['product_uom_name'] = productUomName;
    data['product_qty'] = productQty;
    data['product_uom_qty'] = productUomQty;
    data['qty_done'] = qtyDone;
    return data;
  }
}
