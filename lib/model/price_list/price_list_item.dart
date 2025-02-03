class PriceListItem {
  int? id;
  int? productTmplId;
  String? productTmplName;
  int? productId;
  String? productName;
  double? minQuantity;
  double? fixedPrice;
  String? dateStart;
  String? dateEnd;
  int? companyId;
  String? companyName;
  int? pricelistId;
  String? pricelistName;
  int? currencyId;
  String? currencyName;
  double? productUomMinQty;
  int? productUom;
  String? productUomName;
  double? discountPercent;
  String? writeDate;

  PriceListItem(
      {this.id,
      this.productTmplId,
      this.productTmplName,
      this.productId,
      this.productName,
      this.minQuantity,
      this.fixedPrice,
      this.dateStart,
      this.dateEnd,
      this.companyId,
      this.companyName,
      this.pricelistId,
      this.pricelistName,
      this.currencyId,
      this.currencyName,
      this.productUomMinQty,
      this.productUom,
      this.productUomName,
      this.discountPercent,
      this.writeDate});

  PriceListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productTmplId = json['product_tmpl_id'];
    productTmplName = json['product_tmpl_name'];
    productId = json['product_id'];
    productName = json['product_name'];
    minQuantity = json['min_quantity'] as double?;
    fixedPrice = json['fixed_price'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    pricelistId = json['pricelist_id'];
    pricelistName = json['pricelist_name'];
    currencyId = json['currency_id'];
    currencyName = json['currency_name'];
    productUomMinQty = json['product_uom_min_qty'];
    productUom = json['product_uom'];
    productUom = json['product_uom'];
    productUomName = json['product_uom_name'];
    discountPercent = json['discount_percent'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_tmpl_id'] = productTmplId;
    data['product_tmpl_name'] = productTmplName;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['min_quantity'] = minQuantity;
    data['fixed_price'] = fixedPrice;
    data['date_start'] = dateStart;
    data['date_end'] = dateEnd;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['pricelist_id'] = pricelistId;
    data['pricelist_name'] = pricelistName;
    data['currency_id'] = currencyId;
    data['currency_name'] = currencyName;
    data['product_uom_min_qty'] = productUomMinQty;
    data['product_uom'] = productUom;
    data['product_uom_name'] = productUomName;
    data['discount_percent'] = discountPercent;
    data['write_date'] = writeDate;
    return data;
  }
}
