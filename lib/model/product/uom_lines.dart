import 'dart:convert';

import 'package:equatable/equatable.dart';

UomLine uomLinesFromJson(String str) => UomLine.fromJson(json.decode(str));

String uomLinesToJson(UomLine data) => json.encode(data.toJson());

class UomLine extends Equatable {
  int? uomId;
  String? uomName;
  String? uomType;
  double? ratio;
  int? uomCategoryId;
  int? productId;
  String? uomCategoryName;

  UomLine({
    this.uomId,
    this.uomName,
    this.uomType,
    this.ratio,
    this.uomCategoryId,
    this.uomCategoryName,
    this.productId,
  });

  UomLine.fromJson(dynamic json) {
    uomId = json['id'];
    uomName = json['name'];
    uomType = json['uom_type'];
    ratio = json['ratio'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = uomId;
    map['name'] = uomName;
    map['uom_type'] = uomType;
    map['ratio'] = ratio;
    map['uom_category_id'] = uomCategoryId;
    map['uom_category_name'] = uomCategoryName;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['uom_id'] = uomId;
    map['uom_name'] = uomName;
    map['uom_type'] = uomType;
    map['ratio'] = ratio;
    map['uom_category_id'] = uomCategoryId;
    map['uom_category_name'] = uomCategoryName;
    return map;
  }

  UomLine.fromJsonDB(dynamic json) {
    uomId = json['uom_id'];
    productId = json['product_id'];
    uomName = json['uom_name'];
    uomType = json['uom_type'];
    ratio = json['ratio'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
  }

  @override
  List<Object?> get props => [
        this.uomId,
        this.uomName,
        this.uomType,
        this.ratio,
        this.uomCategoryId,
        this.uomCategoryName,
      ];
}
