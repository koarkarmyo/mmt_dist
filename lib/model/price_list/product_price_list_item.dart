/// id : 70
/// pricelist_id : 1
/// product_tmpl_id : 88
/// product_uom : 38
/// min_quantity : 1
/// fixed_price : 500.0
/// date_start : null
/// date_end : null
/// write_date : "2022-09-03 02:46:00"
/// pricelist_name : "Public Pricelist (MMK)"
/// product_tmpl_name : "[W1000] WATER 1L NEW"
/// product_uom_name : "PCS"

class ProductPriceListItem {
  ProductPriceListItem({
    this.id,
    this.pricelistId,
    this.productTmplId,
    this.productUom,
    this.minQuantity,
    this.fixedPrice,
    this.dateStart,
    this.dateEnd,
    this.writeDate,
    this.categId,
    this.priceDiscount,
    this.pricelistName,
    this.productTmplName,
    this.productUomName,
  });

  ProductPriceListItem.fromJson(dynamic json) {
    id = json['id'];
    pricelistId = json['pricelist_id'];
    productTmplId = json['product_tmpl_id'];
    productUom = json['product_uom'];
    minQuantity = json['min_quantity'];
    fixedPrice = json['fixed_price'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    categId = json['categ_id'];
    priceDiscount = json['price_discount'];
    writeDate = json['write_date'];
    pricelistName = json['pricelist_name'];
    productTmplName = json['product_tmpl_name'];
    productUomName = json['product_uom_name'];
  }

  int? id;
  int? pricelistId;
  int? productTmplId;
  int? productUom;
  double? minQuantity;
  double? fixedPrice;
  String? dateStart;
  int? categId;
  double? priceDiscount;
  String? dateEnd;
  String? writeDate;
  String? pricelistName;
  String? productTmplName;
  String? productUomName;

  ProductPriceListItem copyWith({
    int? id,
    int? pricelistId,
    int? productTmplId,
    int? productUom,
    double? minQuantity,
    double? fixedPrice,
    String? dateStart,
    String? dateEnd,
    String? writeDate,
    int? categId,
    double? priceDiscount,
    String? pricelistName,
    String? productTmplName,
    String? productUomName,
  }) =>
      ProductPriceListItem(
        id: id ?? this.id,
        pricelistId: pricelistId ?? this.pricelistId,
        productTmplId: productTmplId ?? this.productTmplId,
        productUom: productUom ?? this.productUom,
        minQuantity: minQuantity ?? this.minQuantity,
        fixedPrice: fixedPrice ?? this.fixedPrice,
        dateStart: dateStart ?? this.dateStart,
        dateEnd: dateEnd ?? this.dateEnd,
        writeDate: writeDate ?? this.writeDate,
        categId: categId ?? this.categId,
        priceDiscount: priceDiscount ?? this.priceDiscount,
        pricelistName: pricelistName ?? this.pricelistName,
        productTmplName: productTmplName ?? this.productTmplName,
        productUomName: productUomName ?? this.productUomName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pricelist_id'] = pricelistId;
    map['product_tmpl_id'] = productTmplId;
    map['product_uom'] = productUom;
    map['min_quantity'] = minQuantity;
    map['fixed_price'] = fixedPrice;
    map['date_start'] = dateStart;
    map['date_end'] = dateEnd;
    map['write_date'] = writeDate;
    map['categ_id'] = categId;
    map['price_discount'] = priceDiscount;
    map['pricelist_name'] = pricelistName;
    map['product_tmpl_name'] = productTmplName;
    map['product_uom_name'] = productUomName;
    return map;
  }
}
