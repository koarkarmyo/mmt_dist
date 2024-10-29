import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mmt_mobile/model/tag.dart';
import '../src/enum.dart';

/// id : 3
/// name : "Administrator"
/// customer_rank : 1
/// street : null
/// street2 : null
/// city : null
/// state_id : null
/// zip : null
/// phone : null
/// mobile : null
/// email : "nyeinkoko@padetha.com"
/// image_512 : null
/// partner_latitude : 0.0
/// partner_longitude : 0.0
/// write_date : "2022-02-27 08:42:57"
/// state_name : null
/// pricelist_name : "Public Pricelist (MMK)"
/// pricelist_id : 1

Partner customerFromJson(String str) => Partner.fromJson(json.decode(str));

String customerToJson(Partner data) => json.encode(data.toJson());

class Partner extends Equatable {
  int? id;
  String? name;
  String? name2;
  int? customerRank;
  String? street;
  String? street2;
  String? city;
  int? stateId;
  dynamic zip;
  String? phone;
  String? mobile;
  String? email;
  String? image512;
  double? partnerLatitude;
  double? partnerLongitude;
  String? writeDate;
  dynamic stateName;
  String? pricelistName;
  int? pricelistId;
  int? wardId;
  String? wardName;
  int? townshipId;
  String? townshipName;
  int? partnerGradeId;
  int? outletTypeId;
  PartnerState? partnerState;
  List<Tag>? categoryIds;
  int? supplierRank;
  bool? isVisited;
  int? number;
  String? reasonCode;
  int? lastSaleOrder;
  String? lastSaleOrderName;
  double? lastSaleAmount;
  String? lastSaleOrderDate;
  int? lastSaleCurrencyId;
  String? lastSaleCurrencyName;
  double? totalOrdered;
  double? totalDue;
  double? totalInvoiced;
  int? saleOrderCount;
  int? invoiceCount;

  Partner({
    this.id,
    this.name,
    this.name2,
    this.customerRank,
    this.street,
    this.street2,
    this.city,
    this.stateId,
    this.zip,
    this.phone,
    this.mobile,
    this.email,
    this.image512,
    this.partnerLatitude,
    this.partnerLongitude,
    this.writeDate,
    this.stateName,
    this.pricelistName,
    this.pricelistId,
    this.wardId,
    this.wardName,
    this.townshipId,
    this.townshipName,
    this.partnerGradeId,
    this.outletTypeId,
    this.partnerState,
    this.categoryIds,
    this.supplierRank,
    this.isVisited,
    this.number,
    this.reasonCode,
    this.lastSaleOrder,
    this.lastSaleOrderName,
    this.lastSaleAmount,
    this.lastSaleOrderDate,
    this.lastSaleCurrencyId,
    this.lastSaleCurrencyName,
    this.totalOrdered,
    this.totalDue,
    this.totalInvoiced,
    this.saleOrderCount,
    this.invoiceCount,
  });

  Partner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name2 = json['name2'];
    customerRank = json['customer_rank'];
    street = json['street'];
    street2 = json['street2'];
    city = json['city'];
    stateId = json['state_id'];
    zip = json['zip'];
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    image512 = json['image_512'];
    partnerLatitude = json['partner_latitude'];
    partnerLongitude = json['partner_longitude'];
    writeDate = json['write_date'];
    stateName = json['state_name'];
    pricelistName = json['pricelist_name'];
    pricelistId = json['pricelist_id'];
    wardId = json['ward_id'];
    wardName = json['ward_name'];
    townshipId = json['township_id'];
    townshipName = json['township_name'];
    partnerGradeId = json['partner_grade_id'];
    outletTypeId = json['outlet_type_id'];
    supplierRank = json['supplier_rank'];
    if (json['category_id'] != null) {
      categoryIds = <Tag>[];
      json['category_id'].forEach((v) {
        categoryIds?.add(Tag.fromJson(v));
      });
    }
    partnerState = PartnerState.values.firstWhere((e) =>
        e.name.toLowerCase() == json['partner_state'].toString().toLowerCase());
    lastSaleOrder = json['last_sale_order'];
    lastSaleOrderName = json['last_sale_order_name'];
    lastSaleAmount = json['last_sale_amount'];
    lastSaleOrderDate = json['last_sale_order_date'];
    lastSaleCurrencyId = json['last_sale_currency_id'];
    lastSaleCurrencyName = json['last_sale_currency_name'];
    totalOrdered = json['total_ordered'];
    totalDue = json['total_due'];
    totalInvoiced = json['total_invoiced'];
    saleOrderCount = json['sale_order_count'];
    invoiceCount = json['invoice_count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['name2'] = name2;
    map['customer_rank'] = customerRank;
    map['supplier_rank'] = supplierRank;
    map['street'] = street;
    map['street2'] = street2;
    map['city'] = city;
    map['state_id'] = stateId;
    map['zip'] = zip;
    map['phone'] = phone;
    map['mobile'] = mobile;
    map['email'] = email;
    map['image_512'] = image512;
    map['partner_latitude'] = partnerLatitude;
    map['partner_longitude'] = partnerLongitude;
    map['write_date'] = writeDate;
    map['state_name'] = stateName;
    map['pricelist_name'] = pricelistName;
    map['pricelist_id'] = pricelistId;
    map['ward_id'] = wardId;
    map['ward_name'] = wardName;
    map['township_id'] = townshipId;
    map['township_name'] = townshipName;
    map['partner_grade_id'] = partnerGradeId;
    map['outlet_type_id'] = outletTypeId;
    map['partner_state'] = partnerState?.name;
    map['last_sale_order'] = lastSaleOrder;
    map['last_sale_order_name'] = lastSaleOrderName;
    map['last_sale_amount'] = lastSaleAmount;
    map['last_sale_order_date'] = lastSaleOrderDate;
    map['last_sale_currency_id'] = lastSaleCurrencyId;
    map['last_sale_currency_name'] = lastSaleCurrencyName;
    map['total_ordered'] = totalOrdered;
    map['total_due'] = totalDue;
    map['total_invoiced'] = totalInvoiced;
    map['sale_order_count'] = saleOrderCount;
    map['invoice_count'] = invoiceCount;
    return map;
  }

  Partner copyWith({
    int? id,
    String? name,
    String? name2,
    int? customerRank,
    dynamic street,
    dynamic street2,
    dynamic city,
    dynamic stateId,
    dynamic zip,
    dynamic phone,
    dynamic mobile,
    String? email,
    String? image512,
    double? partnerLatitude,
    double? partnerLongitude,
    String? writeDate,
    dynamic stateName,
    String? pricelistName,
    int? pricelistId,
    int? wardId,
    String? wardName,
    int? townshipId,
    String? townshipName,
    int? partnerGradeId,
    int? outletTypeId,
    PartnerState? partnerState,
    List<Tag>? categoryIds,
    int? supplierRank,
    bool? isVisited,
    int? number,
    String? reasonCode,
    int? lastSaleOrder,
    String? lastSaleOrderName,
    double? lastSaleAmount,
    String? lastSaleOrderDate,
    int? lastSaleCurrencyId,
    String? lastSaleCurrencyName,
    double? totalOrdered,
    int? saleOrderCount,
    int? invoiceCount,
    double? totalDue,
    double? totalInvoiced,
  }) =>
      Partner(
        id: id ?? this.id,
        name: name ?? this.name,
        name2: name2 ?? this.name2,
        customerRank: customerRank ?? this.customerRank,
        street: street ?? this.street,
        street2: street2 ?? this.street2,
        city: city ?? this.city,
        stateId: stateId ?? this.stateId,
        zip: zip ?? this.zip,
        phone: phone ?? this.phone,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        categoryIds: categoryIds ?? this.categoryIds,
        image512: image512 ?? this.image512,
        partnerLatitude: partnerLatitude ?? this.partnerLatitude,
        partnerLongitude: partnerLongitude ?? this.partnerLongitude,
        writeDate: writeDate ?? this.writeDate,
        stateName: stateName ?? this.stateName,
        pricelistName: pricelistName ?? this.pricelistName,
        pricelistId: pricelistId ?? this.pricelistId,
        wardId: wardId ?? this.wardId,
        wardName: wardName ?? this.wardName,
        townshipId: townshipId ?? this.townshipId,
        townshipName: townshipName ?? this.townshipName,
        partnerGradeId: partnerGradeId ?? this.partnerGradeId,
        outletTypeId: outletTypeId ?? this.outletTypeId,
        partnerState: partnerState ?? this.partnerState,
        supplierRank: supplierRank ?? this.supplierRank,
        isVisited: isVisited ?? this.isVisited,
        number: number ?? this.number,
        reasonCode: reasonCode ?? this.reasonCode,
        lastSaleAmount: lastSaleAmount ?? this.lastSaleAmount,
        lastSaleCurrencyId: lastSaleCurrencyId ?? this.lastSaleCurrencyId,
        lastSaleCurrencyName: lastSaleCurrencyName ?? this.lastSaleCurrencyName,
        lastSaleOrder: lastSaleOrder ?? this.lastSaleOrder,
        lastSaleOrderDate: lastSaleOrderDate ?? this.lastSaleOrderDate,
        lastSaleOrderName: lastSaleOrderName ?? this.lastSaleOrderName,
        totalOrdered: totalOrdered ?? this.totalOrdered,
        saleOrderCount: saleOrderCount ?? this.saleOrderCount,
        totalDue: totalDue ?? this.totalDue,
        totalInvoiced: totalInvoiced ?? this.totalInvoiced,
        invoiceCount: invoiceCount ?? this.invoiceCount,
      );

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['name2'] = name2;
    map['customer_rank'] = customerRank;
    map['supplier_rank'] = supplierRank;
    map['street'] = street;
    map['street2'] = street2;
    map['city'] = city;
    map['state_id'] = stateId;
    map['zip'] = zip;
    map['phone'] = phone;
    map['mobile'] = mobile;
    map['email'] = email;
    map['image_512'] = image512;
    map['partner_latitude'] = partnerLatitude;
    map['partner_longitude'] = partnerLongitude;
    map['write_date'] = writeDate;
    map['state_name'] = stateName;
    map['pricelist_name'] = pricelistName;
    map['pricelist_id'] = pricelistId;
    map['ward_id'] = wardId;
    map['ward_name'] = wardName;
    map['township_id'] = townshipId;
    map['township_name'] = townshipName;
    map['partner_grade_id'] = partnerGradeId;
    map['outlet_type_id'] = outletTypeId;
    map['partner_state'] = partnerState?.name;
    map['last_sale_order'] = lastSaleOrder;
    map['last_sale_order_name'] = lastSaleOrderName;
    map['last_sale_amount'] = lastSaleAmount;
    map['last_sale_order_date'] = lastSaleOrderDate;
    map['last_sale_currency_id'] = lastSaleCurrencyId;
    map['last_sale_currency_name'] = lastSaleCurrencyName;
    map['total_ordered'] = totalOrdered;
    map['total_due'] = totalDue;
    map['total_invoiced'] = totalInvoiced;
    map['sale_order_count'] = saleOrderCount;
    map['invoice_count'] = invoiceCount;
    map['customer_rank'] = customerRank;
    map['supplier_rank'] = supplierRank;
    return map;
  }

  @override
  List<Object?> get props => [
        this.id,
        this.name,
        this.name2,
        this.customerRank,
        this.street,
        this.street2,
        this.city,
        this.stateId,
        this.zip,
        this.phone,
        this.mobile,
        this.email,
        this.image512,
        this.partnerLatitude,
        this.partnerLongitude,
        this.writeDate,
        this.stateName,
        this.pricelistName,
        this.pricelistId,
        this.wardId,
        this.wardName,
        this.townshipId,
        this.townshipName,
        this.partnerGradeId,
        this.outletTypeId,
        this.partnerState,
        this.categoryIds,
        this.supplierRank,
      ];

  String lastOrderDate() {
    if (lastSaleOrderDate == null) return 'Can\'t define';
    final oldDate =
        DateTime.parse(lastSaleOrderDate ?? DateTime.now().toString());
    final nowADay = DateTime.now();
    Duration duration = DateTime(nowADay.year, nowADay.month, nowADay.day)
        .difference(DateTime(oldDate.year, oldDate.month, oldDate.day));
    return duration.durationString;
  }

  String getCustomerAddressInfo() => "${street != null ? '${street}' : ''}"
      "${street != null && street2 != null ? ' & ' : ''}"
      "${street2 != null ? '${street2}၊ ' : ''}"
      "${wardName != null ? '${wardName}၊ ' : ''}"
      "${townshipName != null ? '${townshipName}၊ ' : ''}"
      "${city != null ? '${city}၊ ' : ''} "
      "${stateName != null ? '${stateName}။' : ''}";
}
