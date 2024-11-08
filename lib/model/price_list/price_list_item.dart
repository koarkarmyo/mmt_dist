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
    productUomName = json['product_uom_name'];
    discountPercent = json['discount_percent'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_tmpl_id'] = this.productTmplId;
    data['product_tmpl_name'] = this.productTmplName;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['min_quantity'] = this.minQuantity;
    data['fixed_price'] = this.fixedPrice;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['pricelist_id'] = this.pricelistId;
    data['pricelist_name'] = this.pricelistName;
    data['currency_id'] = this.currencyId;
    data['currency_name'] = this.currencyName;
    data['product_uom_min_qty'] = this.productUomMinQty;
    data['product_uom'] = this.productUom;
    data['product_uom_name'] = this.productUomName;
    data['discount_percent'] = this.discountPercent;
    data['write_date'] = this.writeDate;
    return data;
  }
}
