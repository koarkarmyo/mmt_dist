class Lot {
  int? id;
  String? name;
  int? productId;
  String? productName;
  double? productQty;
  int? productUomId;
  String? productUomName;

  Lot(
      {this.id,
        this.name,
        this.productId,
        this.productName,
        this.productQty,
        this.productUomId,
        this.productUomName});

  Lot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    productName = json['product_name'];
    productQty = json['product_qty'];
    productUomId = json['product_uom_id'];
    productUomName = json['product_uom_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_qty'] = this.productQty;
    data['product_uom_id'] = this.productUomId;
    data['product_uom_name'] = this.productUomName;
    return data;
  }
}
