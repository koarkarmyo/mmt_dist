import 'package:mmt_mobile/model/price_list/price_list_item.dart';
import 'package:mmt_mobile/model/product/uom_lines.dart';

import '../../src/enum.dart';
import '../../src/mmt_application.dart';

class ProductProduct {
  int? id;
  String? name;
  int? categId;
  String? categName;
  int? companyId;
  String? companyName;
  double? listPrice;
  String? defaultCode;
  String? type;
  bool? saleOk;
  bool? purchaseOk;
  bool? canBeExpensed;
  String? barcode;
  bool? active;
  int? uomCategoryId;
  String? uomCategoryName;
  int? productTmplId;
  String? productTmplName;
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
  List<PriceListItem>? priceListItems;
  TrackingType? trackingType;
  bool? isStorable;
  bool? availableInMobile;

  ProductProduct({
    this.id,
    this.name,
    this.categId,
    this.categName,
    this.companyId,
    this.companyName,
    this.listPrice,
    this.defaultCode,
    this.type,
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
    this.isStorable,
    this.priceListItems,
    this.productTmplId,
    this.productTmplName,
    this.trackingType,
    this.writeDate,
    this.availableInMobile,
  });

  ProductProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categId = json['categ_id'];
    categName = json['categ_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    listPrice = json['list_price'];
    defaultCode = json['default_code'];
    type = json['type'];
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
    productTmplId = json['product_tmpl_id'];
    productTmplName = json['product_tmpl_name'];
    looseUomId = json['loose_uom_id'];
    looseUomName = json['loose_uom_name'];
    boxUomId = json['box_uom_id'];
    boxUomName = json['box_uom_name'];
    availableInMobile = json['available_in_mobile'];
    if (json['uom_lines'] != null) {
      uomLines = <UomLine>[];
      json['uom_lines'].forEach((v) {
        uomLines!.add(UomLine.fromJson(v));
      });
    }
    TrackingType.values.forEach(
      (element) {
        if (element.name == json['tracking']) {
          trackingType = element;
        }
      },
    );
    writeDate = json['write_date'];
    isStorable = json['is_storable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['categ_id'] = categId;
    data['categ_name'] = categName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['list_price'] = listPrice;
    data['default_code'] = defaultCode;
    data['type'] = type;
    data['sale_ok'] = saleOk;
    data['purchase_ok'] = purchaseOk;
    data['can_be_expensed'] = canBeExpensed;
    data['barcode'] = barcode;
    data['active'] = active;
    data['uom_category_id'] = uomCategoryId;
    data['uom_category_name'] = uomCategoryName;
    data['uom_id'] = uomId;
    data['uom_name'] = uomName;
    data['uom_po_id'] = uomPoId;
    data['uom_po_name'] = uomPoName;
    data['loose_uom_id'] = looseUomId;
    data['loose_uom_name'] = looseUomName;
    data['box_uom_id'] = boxUomId;
    data['box_uom_name'] = boxUomName;
    data['product_tmpl_id'] = productTmplId;
    data['product_tmpl_name'] = productTmplName;
    data['tracking'] = trackingType?.name;
    if (uomLines != null) {
      data['uom_lines'] = uomLines!.map((v) => v.toJson()).toList();
    }
    data['write_date'] = writeDate;
    data['is_storable'] = writeDate;
    return data;
  }

  ProductProduct.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categId = json['categ_id'];
    categName = json['categ_name'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    listPrice = json['list_price'];
    defaultCode = json['default_code'];
    type = json['type'];
    saleOk = json['sale_ok'] == 1;
    purchaseOk = json['purchase_ok'] == 1;
    canBeExpensed = json['can_be_expensed'] == 1;
    barcode = json['barcode'];
    active = json['active'] == 1;
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
    productTmplId = json['product_tmpl_id'];
    productTmplName = json['product_tmpl_name'];
    if (json['uom_lines'] != null) {
      uomLines = <UomLine>[];
      json['uom_lines'].forEach((v) {
        uomLines!.add(UomLine.fromJson(v));
      });
    }
    TrackingType.values.forEach(
      (element) {
        if (element.name == json['tracking']) {
          trackingType = element;
        }
      },
    );
    writeDate = json['write_date'];
    isStorable = json['is_storable'] == 1;
  }

  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['categ_id'] = categId;
    data['categ_name'] = categName;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['list_price'] = listPrice;
    data['default_code'] = defaultCode;
    data['type'] = type;
    data['sale_ok'] = saleOk ?? false ? 1 : 0;
    data['purchase_ok'] = purchaseOk ?? false ? 1 : 0;
    data['can_be_expensed'] = canBeExpensed ?? false ? 1 : 0;
    data['barcode'] = barcode;
    data['active'] = active ?? false ? 1 : 0;
    data['uom_category_id'] = uomCategoryId;
    data['uom_category_name'] = uomCategoryName;
    data['uom_id'] = uomId;
    data['uom_name'] = uomName;
    data['product_tmpl_name'] = productTmplName;
    data['product_tmpl_id'] = productTmplId;
    data['uom_po_id'] = uomPoId;
    data['uom_po_name'] = uomPoName;
    data['loose_uom_id'] = looseUomId;
    data['loose_uom_name'] = looseUomName;
    data['box_uom_id'] = boxUomId;
    data['box_uom_name'] = boxUomName;
    data['write_date'] = writeDate;
    data['tracking'] = trackingType?.name;
    data['is_storable'] = isStorable ?? false ? 1 : 0;
    return data;
  }

  UomLine? getRefUom() => MMTApplication.getReferenceUomLine(uomLines!);
}
