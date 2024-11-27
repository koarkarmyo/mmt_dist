class StockQuant {
  StockQuant({
    this.id,
    this.productId,
    this.productCategId,
    this.locationId,
    this.inventoryQuantityAutoApply,
    this.onhandQuantityUom,
    this.availableQuantity,
    this.availableQuantityUom,
    this.productUomId,
    this.reservedQuantity,
    this.writeDate,
    this.productName,
    this.locationName,
    this.productUomName,
  });

  StockQuant.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    productCategId = json['product_categ_id'];
    locationId = json['location_id'];
    inventoryQuantityAutoApply = json['inventory_quantity_auto_apply'];
    onhandQuantityUom = json['onhand_quantity_uom'];
    availableQuantity = json['available_quantity'];
    availableQuantityUom = json['available_quantity_uom'];
    productUomId = json['product_uom_id'];
    reservedQuantity = json['reserved_quantity'];
    writeDate = json['write_date'];
    productName = json['product_name'];
    locationName = json['location_name'];
    productUomName = json['product_uom_name'];
  }

  int? id;
  int? productId;
  int? productCategId;
  int? locationId;
  double? inventoryQuantityAutoApply;
  String? onhandQuantityUom;
  double? availableQuantity;
  String? availableQuantityUom;
  int? productUomId;
  double? reservedQuantity;
  String? writeDate;
  String? productName;
  String? locationName;
  String? productUomName;

  StockQuant copyWith({
    int? id,
    int? productId,
    int? productCategId,
    int? locationId,
    double? inventoryQuantityAutoApply,
    String? onhandQuantityUom,
    double? availableQuantity,
    String? availableQuantityUom,
    int? productUomId,
    double? reservedQuantity,
    String? writeDate,
    String? productName,
    String? locationName,
    String? productUomName,
  }) =>
      StockQuant(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productCategId: productCategId ?? this.productCategId,
        locationId: locationId ?? this.locationId,
        inventoryQuantityAutoApply:
        inventoryQuantityAutoApply ?? this.inventoryQuantityAutoApply,
        onhandQuantityUom: onhandQuantityUom ?? this.onhandQuantityUom,
        availableQuantity: availableQuantity ?? this.availableQuantity,
        availableQuantityUom: availableQuantityUom ?? this.availableQuantityUom,
        productUomId: productUomId ?? this.productUomId,
        reservedQuantity: reservedQuantity ?? this.reservedQuantity,
        writeDate: writeDate ?? this.writeDate,
        productName: productName ?? this.productName,
        locationName: locationName ?? this.locationName,
        productUomName: productUomName ?? this.productUomName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['product_categ_id'] = productCategId;
    map['location_id'] = locationId;
    map['inventory_quantity_auto_apply'] = inventoryQuantityAutoApply;
    map['onhand_quantity_uom'] = onhandQuantityUom;
    map['available_quantity'] = availableQuantity;
    map['available_quantity_uom'] = availableQuantityUom;
    map['product_uom_id'] = productUomId;
    map['reserved_quantity'] = reservedQuantity;
    map['write_date'] = writeDate;
    map['product_name'] = productName;
    map['location_name'] = locationName;
    map['product_uom_name'] = productUomName;
    return map;
  }
}
