import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mmt_mobile/model/product/uom_lines.dart';
import 'package:collection/collection.dart';

import '../../src/enum.dart';
import '../../src/mmt_application.dart';
import '../price_list/price_list_item.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product extends Equatable {
  int? id;
  int? productId;
  String? name;
  int? categId;
  List<UomLine>? uomLines;
  double? listPrice;
  String? defaultCode;
  String? barcode;
  String? image128;
  String? image512;
  int? looseUomId;
  String? looseUomName;
  int? boxUomId;
  String? boxUomName;
  bool? active;
  String? writeDate;
  String? categName;
  int? productGroupId;
  double? refQty;
  String? balanceQtyString;
  ProductDetailTypes? productDetailType;
  List<PriceListItem>? priceListItems;
  String? displayName;
  int? companyId;
  String? companyName;
  String? detailedType;
  bool? saleOk;
  bool? purchaseOk;
  bool? canBeExpensed;
  int? productTmplId;
  String? productTmplName;
  int? uomCategoryId;
  String? uomCategoryName;
  int? uomId;
  String? uomName;
  int? uomPoId;
  int? saleUomId;
  String? saleUomName;
  String? uomPoName;
  ServiceProductType? serviceProductType;

  Product(
      {this.id,
      this.name,
      this.categId,
      this.productId,
      this.uomLines,
      this.listPrice,
      this.defaultCode,
      this.barcode,
      this.image128,
      this.looseUomId,
      this.looseUomName,
      this.boxUomId,
      this.boxUomName,
      this.refQty,
      this.balanceQtyString,
      this.image512,
      this.active,
      this.writeDate,
      this.categName,
      this.productGroupId,
      this.productDetailType,
      this.priceListItems,
      this.serviceProductType,
      this.saleUomId,
      this.saleUomName,
      this.uomCategoryId,
      this.uomCategoryName});

  Product.fromJson(dynamic json) {
    id = json['product_tmpl_id'];
    productId = json['product_id'];
    name = json['name'];
    categId = json['categ_id'];
    if (json['uom_lines'] != null) {
      uomLines = [];
      json['uom_lines'].forEach((v) {
        uomLines?.add(UomLine.fromJson(v));
      });
    }
    listPrice = json['list_price'];
    defaultCode = json['default_code'];
    barcode = json['barcode'];
    image128 = json['image_128'];
    image512 = json['image_512'];
    looseUomId = json['loose_uom_id'];
    looseUomName = json['loose_uom_name'];
    boxUomId = json['box_uom_id'];
    boxUomName = json['box_uom_name'];
    active = json['active'];
    writeDate = json['write_date'];
    categName = json['categ_name'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    productGroupId = json['product_group_id'];
    saleUomId = json['sale_uom_id'];
    saleUomName = json['sale_uom_name'];
    saleOk = json['sale_ok'];
    purchaseOk = json['purchase_ok'];
    productDetailType = ProductDetailTypes.values.firstWhereOrNull((e) =>
        e.name.toLowerCase() == json['detailed_type'].toString().toLowerCase());
    serviceProductType = ServiceProductType.values.firstWhereOrNull((e) =>
        e.name.toLowerCase() ==
        json['service_product_type'].toString().toLowerCase());
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['id'] = productId;
    map['id'] = id;
    map['product_id'] = productId;
    map['name'] = name;
    map['categ_id'] = categId;
    if (uomLines != null) {
      map['uom_lines'] = uomLines?.map((v) => v.toJson()).toList();
    }
    map['box_uom_id'] = boxUomId;
    map['box_uom_name'] = boxUomName;
    map['loose_uom_id'] = looseUomId;
    map['loose_uom_name'] = looseUomName;
    map['list_price'] = listPrice;
    map['default_code'] = defaultCode;
    map['barcode'] = barcode;
    map['image_128'] = image128;
    map['image_512'] = image512;
    map['active'] = active;
    map['write_date'] = writeDate;
    map['categ_name'] = categName;
    map['product_group_id'] = productGroupId;
    map['detailed_type'] = this.productDetailType?.name;
    map['uom_category_id'] = this.uomCategoryId;
    map['uom_category_name'] = this.uomCategoryName;
    map['sale_uom_id'] = this.saleUomId;
    map['sale_uom_name'] = this.saleUomName;
    map['service_product_type'] = this.serviceProductType?.name;
    map['sale_ok'] = saleOk;
    map['purchase_ok'] = purchaseOk;
    return map;
  }

  @override
  List<Object?> get props => [
        this.id,
        this.productId,
        this.name,
        this.categId,
        this.uomLines,
        this.listPrice,
        this.defaultCode,
        this.looseUomId,
        this.looseUomName,
        this.boxUomId,
        this.boxUomName,
        this.barcode,
        this.image128,
        this.image512,
        this.active,
        this.writeDate,
        this.categName,
        this.productGroupId,
        this.productDetailType,
        this.priceListItems,
        this.uomCategoryId
      ];

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['id'] = productId;
    // map['product_id'] = productId;
    map['name'] = name;
    map['categ_id'] = categId;
    map['list_price'] = listPrice;
    map['default_code'] = defaultCode;
    map['barcode'] = barcode;
    map['image_128'] = image128;
    map['image_512'] = image512;
    map['loose_uom_id'] = looseUomId;
    map['loose_uom_name'] = looseUomName;
    map['box_uom_id'] = boxUomId;
    map['box_uom_name'] = boxUomName;
    map['active'] = active! ? 1 : 0;
    map['write_date'] = writeDate;
    map['categ_name'] = categName;
    map['uom_category_id'] = uomCategoryId;
    map['product_group_id'] = productGroupId;
    map['sale_uom_id'] = saleUomId;
    map['sale_uom_name'] = saleUomName;
    map['detailed_type'] = this.productDetailType?.name;
    map['service_product_type'] = this.serviceProductType?.name;
    map['sale_ok'] = saleOk! ? 1 : 0;
    map['purchase_ok'] = purchaseOk! ? 1 : 0;
    return map;
  }

  Product.fromJsonDB(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    categId = json['categ_id'];
    // if (json['uom_lines'] != null) {
    //   uomLines = [];
    //   json['uom_lines'].forEach((v) {
    //     uomLines?.add(UomLines.fromJson(v));
    //   });
    // }
    productDetailType = ProductDetailTypes.values.firstWhereOrNull((e) =>
        e.name.toLowerCase() == json['detailed_type'].toString().toLowerCase());
    looseUomId = json['loose_uom_id'];
    looseUomName = json['loose_uom_name'];
    boxUomId = json['box_uom_id'];
    boxUomName = json['box_uom_name'];
    listPrice = json['list_price'];
    defaultCode = json['default_code'];
    barcode = json['barcode'];
    image128 = json['image_128'];
    image512 = json['image_512'];
    active = json['active'] == 1;
    writeDate = json['write_date'];
    categName = json['categ_name'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    productGroupId = json['product_group_id'];
    saleUomId = json['sale_uom_id'];
    saleUomName = json['sale_uom_name'];
    serviceProductType = ServiceProductType.values.firstWhereOrNull((e) =>
        e.name.toLowerCase() ==
        json['service_product_type'].toString().toLowerCase());
    saleOk = json['sale_ok'] == 1;
    purchaseOk = json['purchase_ok'] == 1;
  }

  UomLine? getRefUom() => MMTApplication.getReferenceUomLine(uomLines!);

  UomLine? getUomLine(int id) =>
      uomLines?.firstWhere((element) => element.uomId == id);

  @override
  String toString() {
    return 'Product{id: $id, productId: $productId, name: $name, categId: $categId, uomLines: $uomLines, listPrice: $listPrice, defaultCode: $defaultCode, barcode: $barcode, image128: $image128, image512: $image512, looseUomId: $looseUomId, looseUomName: $looseUomName, boxUomId: $boxUomId, boxUomName: $boxUomName, active: $active, writeDate: $writeDate, categName: $categName, productGroupId: $productGroupId}';
  }

  Product copyWith({
    int? id,
    int? productId,
    String? name,
    int? categId,
    List<UomLine>? uomLines,
    double? listPrice,
    String? defaultCode,
    String? barcode,
    String? image128,
    String? image512,
    int? looseUomId,
    String? looseUomName,
    int? boxUomId,
    String? boxUomName,
    bool? active,
    String? writeDate,
    String? categName,
    int? productGroupId,
    double? refQty,
    String? balanceQtyString,
    ProductDetailTypes? productDetailType,
    List<PriceListItem>? priceListItems,
    String? displayName,
    int? companyId,
    String? companyName,
    String? detailedType,
    bool? saleOk,
    bool? purchaseOk,
    bool? canBeExpensed,
    int? productTmplId,
    String? productTmplName,
    int? uomCategoryId,
    int? uomId,
    String? uomName,
    int? uomPoId,
    int? saleUomId,
    String? saleUomName,
    String? uomPoName,
    ServiceProductType? serviceProductType,
  }) {
    return Product(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      categId: categId ?? this.categId,
      uomLines: uomLines ?? this.uomLines,
      listPrice: listPrice ?? this.listPrice,
      defaultCode: defaultCode ?? this.defaultCode,
      barcode: barcode ?? this.barcode,
      image128: image128 ?? this.image128,
      image512: image512 ?? this.image512,
      looseUomId: looseUomId ?? this.looseUomId,
      looseUomName: looseUomName ?? this.looseUomName,
      boxUomId: boxUomId ?? this.boxUomId,
      boxUomName: boxUomName ?? this.boxUomName,
      active: active ?? this.active,
      writeDate: writeDate ?? this.writeDate,
      categName: categName ?? this.categName,
      productGroupId: productGroupId ?? this.productGroupId,
      refQty: refQty ?? this.refQty,
      balanceQtyString: balanceQtyString ?? this.balanceQtyString,
      productDetailType: productDetailType ?? this.productDetailType,
      priceListItems: priceListItems ?? this.priceListItems,
      uomCategoryId: uomCategoryId ?? this.uomCategoryId,
      saleUomId: saleUomId ?? this.saleUomId,
      saleUomName: saleUomName ?? this.saleUomName,
      serviceProductType: serviceProductType ?? this.serviceProductType,
    );
  }

  String get getBalanceQtyThreeConversion {
    return MMTApplication.nestedUomChanger(refQty ?? 0, uomLines ?? []);
  }
}
