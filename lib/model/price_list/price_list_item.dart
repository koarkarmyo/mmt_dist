import 'dart:convert';

/// id : 4
/// product_tmpl_id : 3
/// categ_id : null
/// min_quantity : 1.0
/// applied_on : "1_product"
/// price_discount : null
/// fixed_price : 35000.0
/// date_start : null
/// date_end : null
/// product_uom_name : "CTN-48"
/// product_uom_id : 32
/// product_tmpl_name : "DM 90ML"

PriceListItem priceItemFromJson(String str) =>
    PriceListItem.fromJson(json.decode(str));

String priceItemToJson(PriceListItem data) => json.encode(data.toJson());

class PriceListItem {
  PriceListItem({
    this.id,
    this.productTmplId,
    this.categId,
    this.minQuantity,
    this.appliedOn,
    this.priceDiscount,
    this.fixedPrice,
    this.priceGroupId,
    this.dateStart,
    this.dateEnd,
    this.productUomName,
    this.productUomId,
    this.productTmplName,
  });

  PriceListItem.fromJson(dynamic json) {
    id = json['id'];
    productTmplId = json['product_tmpl_id'];
    categId = json['categ_id'];
    minQuantity = json['min_quantity'].toDouble();
    appliedOn = json['applied_on'];
    priceDiscount = json['price_discount'];
    fixedPrice = json['fixed_price'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    priceGroupId = json['price_group_id'];
    productUomName = json['product_uom_name'];
    productUomId = json['product_uom'];
    productTmplName = json['product_tmpl_name'];

  }

  int? id;
  int? productTmplId;
  dynamic categId;
  double? minQuantity;
  String? appliedOn;
  dynamic priceDiscount;
  double? fixedPrice;
  dynamic dateStart;
  dynamic dateEnd;
  String? productUomName;
  int? productUomId;
  String? productTmplName;
  int? priceGroupId;

  PriceListItem copyWith({
    int? id,
    int? productTmplId,
    dynamic categId,
    double? minQuantity,
    String? appliedOn,
    dynamic priceDiscount,
    double? fixedPrice,
    dynamic dateStart,
    dynamic dateEnd,
    String? productUomName,
    int? productUomId,
    int? priceGroupId,
    String? productTmplName,
  }) =>
      PriceListItem(
        id: id ?? this.id,
        productTmplId: productTmplId ?? this.productTmplId,
        categId: categId ?? this.categId,
        minQuantity: minQuantity ?? this.minQuantity,
        appliedOn: appliedOn ?? this.appliedOn,
        priceDiscount: priceDiscount ?? this.priceDiscount,
        fixedPrice: fixedPrice ?? this.fixedPrice,
        dateStart: dateStart ?? this.dateStart,
        priceGroupId: priceGroupId ?? this.priceGroupId,
        dateEnd: dateEnd ?? this.dateEnd,
        productUomName: productUomName ?? this.productUomName,
        productUomId: productUomId ?? this.productUomId,
        productTmplName: productTmplName ?? this.productTmplName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_tmpl_id'] = productTmplId;
    map['categ_id'] = categId;
    map['min_quantity'] = minQuantity;
    map['applied_on'] = appliedOn;
    map['price_discount'] = priceDiscount;
    map['fixed_price'] = fixedPrice;
    map['date_start'] = dateStart;
    map['date_end'] = dateEnd;
    map['price_group_id'] = priceGroupId;
    map['product_uom_name'] = productUomName;
    map['product_uom'] = productUomId;
    map['product_tmpl_name'] = productTmplName;
    return map;
  }

  @override
  String toString() {
    return 'PriceListItem{id: $id, productTmplId: $productTmplId, categId: $categId, minQuantity: $minQuantity, appliedOn: $appliedOn, priceDiscount: $priceDiscount, fixedPrice: $fixedPrice, dateStart: $dateStart, dateEnd: $dateEnd, productUomName: $productUomName, productUomId: $productUomId, productTmplName: $productTmplName, priceGroupId: $priceGroupId}';
  }
}
