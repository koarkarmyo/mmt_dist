class StockMoveLine {
  int? id;
  int? productId;
  String? productName;
  String? lotId;
  int? locationId;
  int? locationDestId;
  double? qtyDone;
  int? productUomId;
  String? productUomName;
  bool? isSerial;

  StockMoveLine({
    this.id,
    this.productId,
    this.productName,
    this.lotId,
    this.locationId,
    this.locationDestId,
    this.qtyDone,
    this.productUomId,
    this.productUomName,
    this.isSerial,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': this.productId,
      'lot_id': this.lotId,
      'qty_done': this.qtyDone,
      'product_uom_id': this.productUomId,
    };
  }
  Map<String, dynamic> toJsonDB() {
    return {
      'id': this.id,
      'product_id': this.productId,
      'product_name': this.productName,
      'lot_id': this.lotId,
      'location_id': this.locationId,
      'location_dest_id': this.locationDestId,
      'qty_done': this.qtyDone,
      'product_uom_id': this.productUomId,
    };
  }

  factory StockMoveLine.fromMap(Map<String, dynamic> map) {
    return StockMoveLine(
      id: map['id'],
      productId: map['product_id'],
      productName: map['product_name'],
      lotId: map['lot_id'],
      locationId: map['location_id'],
      locationDestId: map['location_dest_id'],
      qtyDone: map['qty_done'],
      productUomId: map['product_uom_id'],
    );
  }

  StockMoveLine copyWith({
    int? id,
    int? productId,
    String? productName,
    String? lotId,
    int? locationId,
    int? locationDestId,
    double? qtyDone,
    int? productUomId,
    String? productUomName,
    bool? isSerial,
  }) {
    return StockMoveLine(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      lotId: lotId ?? this.lotId,
      locationId: locationId ?? this.locationId,
      locationDestId: locationDestId ?? this.locationDestId,
      qtyDone: qtyDone ?? this.qtyDone,
      productUomId: productUomId ?? this.productUomId,
      productUomName: productUomName ?? this.productUomName,
      isSerial: isSerial ?? this.isSerial,
    );
  }
}