import 'dart:convert';

import 'package:mmt_mobile/model/price_list/price_list_item.dart';


/// id : 1
/// name : "Public Pricelist"
/// active : true
/// currency_id : 115
/// company_id : null
/// discount_policy : "with_discount"
/// display_name : "Public Pricelist (MMK)"
/// write_date : "2022-02-27 05:07:19"
/// currency_name : "MMK"
/// pricelist_items : [{"id":4,"product_tmpl_id":3,"categ_id":null,"min_quantity":48.0,"applied_on":"1_product","price_discount":null,"fixed_price":239.58,"date_start":null,"date_end":null,"product_tmpl_name":"DM 90ML"},{"id":3,"product_tmpl_id":3,"categ_id":null,"min_quantity":1.0,"applied_on":"1_product","price_discount":null,"fixed_price":250.0,"date_start":null,"date_end":null,"product_tmpl_name":"DM 90ML"}]

PriceList priceListFromJson(String str) => PriceList.fromJson(json.decode(str));

String priceListToJson(PriceList data) => json.encode(data.toJson());

class PriceList {
  PriceList({
    this.id,
    this.name,
    this.active,
    this.currencyId,
    this.companyId,
    this.discountPolicy,
    this.displayName,
    this.writeDate,
    this.currencyName,
    this.pricelistItems,
  });

  PriceList.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    currencyId = json['currency_id'];
    companyId = json['company_id'];
    discountPolicy = json['discount_policy'];
    displayName = json['display_name'];
    writeDate = json['write_date'];
    currencyName = json['currency_name'];
    if (json['pricelist_items'] != null) {
      pricelistItems = [];
      json['pricelist_items'].forEach((v) {
        pricelistItems?.add(PriceListItem.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  bool? active;
  int? currencyId;
  dynamic companyId;
  String? discountPolicy;
  String? displayName;
  String? writeDate;
  String? currencyName;
  List<PriceListItem>? pricelistItems;

  PriceList copyWith({
    int? id,
    String? name,
    bool? active,
    int? currencyId,
    dynamic companyId,
    String? discountPolicy,
    String? displayName,
    String? writeDate,
    String? currencyName,
    List<PriceListItem>? pricelistItems,
  }) =>
      PriceList(
        id: id ?? this.id,
        name: name ?? this.name,
        active: active ?? this.active,
        currencyId: currencyId ?? this.currencyId,
        companyId: companyId ?? this.companyId,
        discountPolicy: discountPolicy ?? this.discountPolicy,
        displayName: displayName ?? this.displayName,
        writeDate: writeDate ?? this.writeDate,
        currencyName: currencyName ?? this.currencyName,
        pricelistItems: pricelistItems ?? this.pricelistItems,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['active'] = active;
    map['currency_id'] = currencyId;
    map['company_id'] = companyId;
    map['discount_policy'] = discountPolicy;
    map['display_name'] = displayName;
    map['write_date'] = writeDate;
    map['currency_name'] = currencyName;
    if (pricelistItems != null) {
      map['pricelist_items'] = pricelistItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['currency_id'] = currencyId;
    map['company_id'] = companyId;
    map['discount_policy'] = discountPolicy;
    map['display_name'] = displayName;
    map['write_date'] = writeDate;
    map['currency_name'] = currencyName;
    return map;
  }
}
