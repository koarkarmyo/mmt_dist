import 'package:mmt_mobile/model/product/uom_lines.dart';

import '../src/enum.dart';

class ProductTemplate {
  int? id;
  String? name;
  int? categId;
  String? categName;
  int? companyId;
  String? companyName;
  double? listPrice;
  String? defaultCode;
  String? detailedType;
  bool? saleOk;
  bool? purchaseOk;
  bool? canBeExpensed;
  String? barcode;
  bool? active;
  int? uomCategoryId;
  String? uomCategoryName;
  int? uomId;
  String? uomName;
  int? uomPoId;
  String? uomPoName;
  int? looseUomId;
  String? looseUomName;
  int? boxUomId;
  String? boxUomName;
  List<UomLine>? uomLines;
  String? writeDate;
  TrackingType? trackingType;

  ProductTemplate(
      {this.id,
      this.name,
      this.categId,
      this.categName,
      this.companyId,
      this.companyName,
      this.listPrice,
      this.defaultCode,
      this.detailedType,
      this.saleOk,
      this.purchaseOk,
      this.canBeExpensed,
      this.barcode,
      this.active,
      this.uomCategoryId,
      this.uomCategoryName,
      this.uomId,
      this.uomName,
      this.uomPoId,
      this.uomPoName,
      this.looseUomId,
      this.looseUomName,
      this.boxUomId,
      this.boxUomName,
      this.uomLines,
      this.trackingType,
      this.writeDate});

  ProductTemplate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categId = json['categ_id'];
    categName = json['categ_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    listPrice = json['list_price'];
    defaultCode = json['default_code'];
    detailedType = json['detailed_type'];
    saleOk = json['sale_ok'];
    purchaseOk = json['purchase_ok'];
    canBeExpensed = json['can_be_expensed'];
    barcode = json['barcode'];
    active = json['active'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    uomId = json['uom_id'];
    uomName = json['uom_name'];
    uomPoId = json['uom_po_id'];
    uomPoName = json['uom_po_name'];
    looseUomId = json['loose_uom_id'];
    looseUomName = json['loose_uom_name'];
    boxUomId = json['box_uom_id'];
    boxUomName = json['box_uom_name'];
    if (json['uom_lines'] != null) {
      uomLines = <UomLine>[];
      json['uom_lines'].forEach((v) {
        uomLines!.add(UomLine.fromJson(v));
      });
    }
    writeDate = json['write_date'];
    TrackingType.values.forEach(
      (element) {
        if (element.name == json['tracking']) {
          print("tracking type : ${element.name}");
          trackingType = element;
        }
      },
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categ_id'] = this.categId;
    data['categ_name'] = this.categName;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['list_price'] = this.listPrice;
    data['default_code'] = this.defaultCode;
    data['detailed_type'] = this.detailedType;
    data['sale_ok'] = this.saleOk;
    data['purchase_ok'] = this.purchaseOk;
    data['can_be_expensed'] = this.canBeExpensed;
    data['barcode'] = this.barcode;
    data['active'] = this.active;
    data['uom_category_id'] = this.uomCategoryId;
    data['uom_category_name'] = this.uomCategoryName;
    data['uom_id'] = this.uomId;
    data['uom_name'] = this.uomName;
    data['uom_po_id'] = this.uomPoId;
    data['uom_po_name'] = this.uomPoName;
    data['loose_uom_id'] = this.looseUomId;
    data['loose_uom_name'] = this.looseUomName;
    data['box_uom_id'] = this.boxUomId;
    data['box_uom_name'] = this.boxUomName;
    if (this.uomLines != null) {
      data['uom_lines'] = this.uomLines!.map((v) => v.toJson()).toList();
    }
    data['write_date'] = this.writeDate;
    data['tracking'] = trackingType?.name;
    return data;
  }

  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categ_id'] = this.categId;
    data['categ_name'] = this.categName;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['list_price'] = this.listPrice;
    data['default_code'] = this.defaultCode;
    data['detailed_type'] = this.detailedType;
    data['sale_ok'] = this.saleOk ?? false ? 1 : 0;
    data['purchase_ok'] = this.purchaseOk ?? false ? 1 : 0;
    data['can_be_expensed'] = this.canBeExpensed ?? false ? 1 : 0;
    data['barcode'] = this.barcode;
    data['active'] = this.active ?? false ? 1 : 0;
    data['uom_category_id'] = this.uomCategoryId;
    data['uom_category_name'] = this.uomCategoryName;
    data['uom_id'] = this.uomId;
    data['uom_name'] = this.uomName;
    data['uom_po_id'] = this.uomPoId;
    data['uom_po_name'] = this.uomPoName;
    data['loose_uom_id'] = this.looseUomId;
    data['loose_uom_name'] = this.looseUomName;
    data['box_uom_id'] = this.boxUomId;
    data['box_uom_name'] = this.boxUomName;
    data['write_date'] = this.writeDate;
    data['tracking'] = trackingType?.name;
    return data;
  }

  ProductTemplate.fromJsonDB({required Map<String, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    categId = json['categ_id'];
    categName = json['categ_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    listPrice = json['list_price'];
    defaultCode = json['default_code'];
    detailedType = json['detailed_type'];
    saleOk = json['sale_ok'];
    purchaseOk = json['purchase_ok'];
    canBeExpensed = json['can_be_expensed'];
    barcode = json['barcode'];
    active = json['active'];
    uomCategoryId = json['uom_category_id'];
    uomCategoryName = json['uom_category_name'];
    uomId = json['uom_id'];
    uomName = json['uom_name'];
    uomPoId = json['uom_po_id'];
    uomPoName = json['uom_po_name'];
    looseUomId = json['loose_uom_id'];
    looseUomName = json['loose_uom_name'];
    boxUomId = json['box_uom_id'];
    boxUomName = json['box_uom_name'];
    if (json['uom_lines'] != null) {
      uomLines = <UomLine>[];
      json['uom_lines'].forEach((v) {
        uomLines!.add(UomLine.fromJson(v));
      });
    }
    writeDate = json['write_date'];
    TrackingType.values.forEach(
      (element) {
        if (element.name == json['tracking']) {
          trackingType = element;
        }
      },
    );
  }
}
