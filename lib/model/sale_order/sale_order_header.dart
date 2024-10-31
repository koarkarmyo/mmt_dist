import 'package:collection/collection.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';

import '../../src/enum.dart';
import '../partner.dart';

class SaleOrderHeader {
  int? id;
  String? name;
  String? origin;
  int? salePersonId;
  int? vehicleId;
  String? clientOrderRef;
  String? reference;

  // String? state;
  String? dateOrder;
  String? validityDate;
  bool? isExpired;
  bool? requireSignature;
  bool? requirePayment;
  int? partnerId;
  List<SaleOrderLine>? orderLine;
  String? invoiceStatus;
  String? note;
  String? remark;
  double? amountTax;
  double? amountTotal;
  String? signature;
  String? signedBy;
  String? signedOn;
  String? writeDate;
  String? pickingNo;
  int? batchNo;
  String? batchName;
  DeliveryStatus? pickingState;
  String? partnerName;
  int? isUpload;
  Partner? customer;
  String? commitmentDate;
  DeliveryStates? deliveryStatus;
  OrderStates? state;
  bool? fromDirectSale;
  int? saleOrderTypeId;
  String? saleOrderTypeName;

  SaleOrderHeader({
    this.id,
    this.name,
    this.salePersonId,
    this.origin,
    this.vehicleId,
    this.clientOrderRef,
    this.reference,
    this.state,
    this.commitmentDate,
    this.dateOrder,
    this.validityDate,
    this.batchNo,
    this.batchName,
    this.isExpired,
    this.requireSignature,
    this.requirePayment,
    this.isUpload = 0,
    this.partnerId,
    this.orderLine,
    this.invoiceStatus,
    this.note,
    this.amountTax,
    this.amountTotal,
    this.signature,
    this.signedBy,
    this.signedOn,
    this.writeDate,
    this.pickingNo,
    this.pickingState,
    this.partnerName,
    this.deliveryStatus,
    this.fromDirectSale,
    this.remark,
    this.saleOrderTypeId,
    this.saleOrderTypeName,
  });

  SaleOrderHeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    origin = json['origin'];
    isUpload = json['is_upload'] ?? 0;
    clientOrderRef = json['client_order_ref'];
    reference = json['reference'];
    state = OrderStates.values
        .firstWhereOrNull((element) => element.name == json['state']);
    dateOrder = json['date_order'];
    validityDate = json['validity_date'];
    isExpired = json['is_expired'] == 1 ? true : false;
    requireSignature = json['require_signature'] == 1 ? true : false;
    requirePayment = json['require_payment'] == 0;
    commitmentDate = json['commitment_date'];
    partnerId = json['partner_id'];
    if (json['order_line'] != null) {
      orderLine = <SaleOrderLine>[];
      json['order_line'].forEach((v) {
        orderLine!.add(SaleOrderLine.fromJson(v));
      });
    }
    salePersonId = json['sale_person'];
    invoiceStatus = json['invoice_status'];
    note = json['note'];
    remark = json['remark'];
    // amountTax = json['amount_tax'];
    amountTotal = json['amount_total'];
    signature = json['signature'];
    signedBy = json['signed_by'];
    signedOn = json['signed_on'];
    vehicleId = json['vehicle_id'];
    writeDate = json['write_date'];
    batchNo = json['batch_no'];
    batchName = json['batch_name'];
    fromDirectSale = json['from_direct_sale'] == 1;
    pickingNo = json['picking_no'];
    pickingState = DeliveryStatus.values.firstWhereOrNull((e) =>
        e.name.toLowerCase() == json['picking_state'].toString().toLowerCase());
    deliveryStatus = DeliveryStates.values.firstWhereOrNull((e) =>
        e.name.toLowerCase() ==
        json['delivery_status'].toString().toLowerCase());
    // json['picking_state'];
    fromDirectSale = json['from_direct_sale'] == 1;
    partnerName = json['partner_name'];
    saleOrderTypeId = json['sale_order_type_id'];
    saleOrderTypeName = json['sale_order_type_name'];
  }

  Map<String, dynamic> toJsonForSaleOrderApi() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['partner_id'] = partnerId;
    map['partner_name'] = partnerName;
    map['amount_total'] = amountTotal;
    map['partner_id'] = partnerId;
    map['note'] = note;
    map['sale_person'] = salePersonId;
    map['vehicle_id'] = vehicleId;
    map['state'] = state?.name;
    map['date_order'] = dateOrder;
    map['is_upload'] = isUpload;
    map['remark'] = remark;
    map['sale_order_type_id'] = saleOrderTypeId;
    map['sale_order_type_name'] = saleOrderTypeName;
    map['commitment_date'] = commitmentDate;
    return map;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['origin'] = this.origin;
    data['sale_person'] = this.salePersonId;
    data['client_order_ref'] = this.clientOrderRef;
    data['reference'] = this.reference;
    data['state'] = this.state?.name;
    data['date_order'] = this.dateOrder;
    data['validity_date'] = this.validityDate;
    data['is_expired'] = this.isExpired;
    data['require_signature'] = this.requireSignature;
    data['require_payment'] = this.requirePayment;
    data['partner_id'] = this.partnerId;
    data['commitment_date'] = commitmentDate;

    // if (this.orderLine != null) {
    //   data['order_line'] = this.orderLine!.map((v) => v.toJson()).toList();
    // }
    data['invoice_status'] = this.invoiceStatus;
    data['note'] = this.note;
    data['remark'] = this.remark;
    data['amount_tax'] = this.amountTax;
    data['amount_total'] = this.amountTotal;
    data['signature'] = this.signature;
    data['signed_by'] = this.signedBy;
    data['signed_on'] = this.signedOn;
    data['write_date'] = this.writeDate;
    data['picking_no'] = this.pickingNo;
    data['picking_state'] = this.pickingState?.name;
    data['delivery_status'] = this.deliveryStatus?.name;
    data['partner_name'] = this.partnerName;
    data['sale_order_type_id'] = this.saleOrderTypeId;
    data['sale_order_type_name'] = this.saleOrderTypeName;
    return data;
  }

  Map<String, dynamic> toJsonDB() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['partner_id'] = partnerId;
    data['partner_name'] = partnerName;
    data['amount_total'] = amountTotal;
    data['partner_id'] = partnerId;
    data['sale_person'] = salePersonId;
    data['vehicle_id'] = vehicleId;
    data['date_order'] = dateOrder;
    data['is_upload'] = isUpload;
    data['id'] = this.id;
    data['name'] = this.name;
    data['origin'] = this.origin;
    data['batch_no'] = this.batchNo;
    data['batch_name'] = this.batchName;
    data['client_order_ref'] = this.clientOrderRef;
    data['reference'] = this.reference;
    data['state'] = this.state?.name;
    data['date_order'] = this.dateOrder;
    data['validity_date'] = this.validityDate;
    data['is_expired'] = this.isExpired;
    data['require_signature'] = this.requireSignature;
    data['require_payment'] = this.requirePayment;
    data['partner_id'] = this.partnerId;
    data['commitment_date'] = this.commitmentDate;
    // if (this.orderLine != null) {
    //   data['order_line'] = this.orderLine!.map((v) => v.toJson()).toList();
    // }
    data['invoice_status'] = this.invoiceStatus;
    data['note'] = this.note;
    data['remark'] = this.remark;
    data['amount_tax'] = this.amountTax;
    data['amount_total'] = this.amountTotal;
    data['signature'] = this.signature;
    data['signed_by'] = this.signedBy;
    data['signed_on'] = this.signedOn;
    data['write_date'] = this.writeDate;
    data['picking_no'] = this.pickingNo;
    data['from_direct_sale'] = this.fromDirectSale;
    data['picking_state'] = this.pickingState?.name;
    data['delivery_status'] = this.deliveryStatus?.name;
    data['partner_name'] = this.partnerName;
    data['from_direct_sale'] = this.fromDirectSale;
    data['sale_order_type_id'] = this.saleOrderTypeId;
    data['sale_order_type_name'] = this.saleOrderTypeName;
    return data;
  }

  SaleOrderHeader copyWith(
      {int? id,
      String? name,
      int? salePerson,
      String? origin,
      int? vehicleId,
      String? clientOrderRef,
      String? reference,
      OrderStates? state,
      String? dateOrder,
      String? validityDate,
      bool? isExpired,
      bool? requireSignature,
      bool? requirePayment,
      int? isUpload,
      int? partnerId,
      int? batchNo,
      String? batchName,
      List<SaleOrderLine>? orderLine,
      String? invoiceStatus,
      String? note,
      String? commitmentDate,
      double? amountTax,
      double? amountTotal,
      String? signature,
      String? signedBy,
      String? remark,
      String? signedOn,
      String? writeDate,
      String? pickingNo,
      DeliveryStatus? pickingState,
      DeliveryStates? deliveryStatus,
      bool? fromDirectSale,
      String? partnerName,
      int? saleOrderTypeId,
      String? saleOrderTypeName}) {
    return SaleOrderHeader(
      id: id ?? this.id,
      name: name ?? this.name,
      salePersonId: salePerson ?? this.salePersonId,
      origin: origin ?? this.origin,
      vehicleId: vehicleId ?? this.vehicleId,
      clientOrderRef: clientOrderRef ?? this.clientOrderRef,
      reference: reference ?? this.reference,
      state: state ?? this.state,
      dateOrder: dateOrder ?? this.dateOrder,
      validityDate: validityDate ?? this.validityDate,
      isExpired: isExpired ?? this.isExpired,
      requireSignature: requireSignature ?? this.requireSignature,
      requirePayment: requirePayment ?? this.requirePayment,
      isUpload: isUpload ?? this.isUpload,
      partnerId: partnerId ?? this.partnerId,
      orderLine: orderLine ?? this.orderLine,
      invoiceStatus: invoiceStatus ?? this.invoiceStatus,
      note: note ?? this.note,
      commitmentDate: commitmentDate ?? this.commitmentDate,
      amountTax: amountTax ?? this.amountTax,
      amountTotal: amountTotal ?? this.amountTotal,
      signature: signature ?? this.signature,
      signedBy: signedBy ?? this.signedBy,
      signedOn: signedOn ?? this.signedOn,
      writeDate: writeDate ?? this.writeDate,
      batchNo: batchNo ?? this.batchNo,
      batchName: batchName ?? this.batchName,
      remark: remark ?? this.remark,
      pickingNo: pickingNo ?? this.pickingNo,
      pickingState: pickingState ?? this.pickingState,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      fromDirectSale: fromDirectSale ?? this.fromDirectSale,
      partnerName: partnerName ?? this.partnerName,
      saleOrderTypeId: saleOrderTypeId ?? this.saleOrderTypeId,
      saleOrderTypeName: saleOrderTypeName ?? this.saleOrderTypeName,
    );
  }
}

// {
// "id": 35176,
// "product_id": 83,
// "sale_type": "sale",
// "product_uom_qty": 1.0,
// "product_uom": 32,
// "price_unit": 7000.0,
// "discount": 0.0,
// "price_subtotal": 7000.0,
// "write_date": "2022-11-11 08:44:21",
// "product_name": "[500C] COKE 500ML NEW",
// "product_uom_name": "PK"
// },


// import 'package:equatable/equatable.dart';
// import 'package:mscm_odoo/models/sale_order/sale_order_line.dart';
//
// class SaleOrderHeader extends Equatable {
//   late String name;
//   late int partnerId;
//   late int salePerson;
//   late String partnerName;
//   late double amountTotal;
//   late int vehicleId;
//   late String dateOrder;
//   late int isUpload;
//   late List<SaleOrderLine> saleOrderLines;
//
//   SaleOrderHeader(
//       {required this.name,
//       required this.partnerId,
//       required this.salePerson,
//       required this.vehicleId,
//       required this.amountTotal,
//       required this.partnerName,
//       required this.isUpload,
//       required this.dateOrder,
//       required this.saleOrderLines});
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = name;
//     map['partner_id'] = partnerId;
//     map['partner_name'] = partnerName;
//     map['amount_total'] = amountTotal;
//     map['partner_id'] = partnerId;
//     map['sale_person'] = salePerson;
//     map['vehicle_id'] = vehicleId;
//     map['date_order'] = dateOrder;
//     map['is_upload'] = isUpload;
//     return map;
//   }
//
//   SaleOrderHeader.fromJson(dynamic map) {
//     name = map['name'];
//     partnerId = map['partner_id'];
//     partnerName = map['partner_name'];
//     salePerson = map['sale_person'];
//     vehicleId = map['vehicle_id'];
//     dateOrder = map['date_order'];
//     saleOrderLines = [];
//     amountTotal = map['amount_total'];
//     isUpload = map['is_upload'];
//   }
//
//   @override
//   List<Object?> get props => [
//         this.name,
//         this.partnerId,
//         this.partnerName,
//         this.amountTotal,
//         this.salePerson,
//         this.vehicleId,
//         this.dateOrder,
//         this.saleOrderLines,
//         this.isUpload,
//       ];
//
//   SaleOrderHeader copyWith(
//       {String? name,
//       int? cartHdrId,
//       int? partnerId,
//       String? partnerName,
//       int? salePerson,
//       int? vehicleId,
//       int? isUpload,
//       double? amountTotal,
//       String? dateOrder,
//       List<SaleOrderLine>? saleOrderLines}) {
//     return SaleOrderHeader(
//         name: name ?? this.name,
//         partnerId: partnerId ?? this.partnerId,
//         partnerName: partnerName ?? this.partnerName,
//         salePerson: salePerson ?? this.salePerson,
//         vehicleId: vehicleId ?? this.vehicleId,
//         isUpload: isUpload ?? this.isUpload,
//         dateOrder: dateOrder ?? this.dateOrder,
//         amountTotal: amountTotal ?? this.amountTotal,
//         saleOrderLines: saleOrderLines ?? this.saleOrderLines);
//   }
// }
