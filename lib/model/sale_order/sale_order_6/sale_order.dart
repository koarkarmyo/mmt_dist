import 'package:collection/collection.dart';
import 'package:mmt_mobile/database/db_repo/res_partner_repo.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';

import '../../../src/enum.dart';

class SaleOrder {
  int? id;
  String? name;
  String? createDate;
  int? partnerId;
  String? partnerName;
  int? warehouseId;
  String? warehouseName;
  int? employeeId;
  double? amountTotal;
  OrderStates? state;
  DeliveryStates? deliveryStatus;
  List<SaleOrderLine>? orderLines;
  bool? isUpload;
  String? writeDate;
  String? note;

  SaleOrder({
    this.id,
    this.name,
    this.createDate,
    this.partnerId,
    this.partnerName,
    this.employeeId,
    this.amountTotal,
    this.state,
    this.deliveryStatus,
    this.orderLines,
    this.isUpload,
    this.writeDate,
    this.note,
    this.warehouseId,
    this.warehouseName,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'createDate': createDate,
  //     'partnerId': partnerId,
  //     'partnerName': partnerName,
  //     'salePerson': employeeId,
  //     'amountTotal': amountTotal,
  //     'state': state,
  //     'delivery_status': deliveryStatus,
  //     'is_upload': isUpload,
  //     'write_date': writeDate,
  //     'note': note,
  //     'warehouse_id': warehouseId,
  //     'warehouse_name': warehouseName,
  //   };
  // }

  Map<String, dynamic> toJsonDB() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'partner_id': partnerId,
      'partner_name': partnerName,
      'employee_id': employeeId,
      'amount_total': amountTotal,
      'state': state?.name,
      'delivery_status': deliveryStatus,
      'is_upload': isUpload,
      'write_date': writeDate,
      'warehouse_id': warehouseId,
      'warehouse_name': warehouseName,
      'note': note
    };
  }

  SaleOrder.fromJsonDB(Map<String, dynamic> map) {
    name = map['name'];
    partnerName = map['partner_name'];
    partnerId = map['partner_id'];
    employeeId = map['employee_id'];
    state = OrderStates.values
        .firstWhereOrNull((element) => element.name == map['state']);
    deliveryStatus = DeliveryStates.values
        .firstWhereOrNull((element) => element.name == map['delivery_status']);
    isUpload = map['is_upload'] == 1;
    amountTotal = map['amount_total'];
    writeDate = map['write_date'];
    warehouseId = map['warehouse_id'];
    warehouseName = map['warehouse_name'];
    note = map['note'];
  }

  factory SaleOrder.fromJson(Map<String, dynamic> map) {
    List<SaleOrderLine> lines = [];
    if (map['order_line'] != null) {
      map['order_line'].forEach((e) {
        lines.add(SaleOrderLine.fromJson(e));
      });
    }
    return SaleOrder(
        id: map['id'],
        name: map['name'],
        createDate: map['create_date'],
        partnerId: map['partner_id'],
        partnerName: map['partner_name'],
        employeeId: map['employee_id'],
        amountTotal: map['amount_total'],
        warehouseId: map['warehouse_id'],
        warehouseName: map['warehouse_name'],
        orderLines: lines,
        writeDate: map['write_date'],
        state: OrderStates.values
            .firstWhereOrNull((element) => element.name == map['state']),
        deliveryStatus: DeliveryStates.values.firstWhereOrNull(
            (element) => element.name == map['delivery_status']),
        note: map['note']);
  }

  SaleOrder copyWith({
    int? id,
    String? name,
    String? createDate,
    int? partnerId,
    String? partnerName,
    int? warehouseId,
    String? warehouseName,
    int? salePerson,
    double? amountTotal,
    OrderStates? state,
    DeliveryStates? deliveryStatus,
    List<SaleOrderLine>? orderLines,
    bool? isUpload,
    String? writeDate,
    String? note,
  }) {
    return SaleOrder(
      id: id ?? this.id,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      warehouseId: warehouseId ?? this.warehouseId,
      warehouseName: warehouseName ?? this.warehouseName,
      employeeId: salePerson ?? this.employeeId,
      amountTotal: amountTotal ?? this.amountTotal,
      state: state ?? this.state,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      orderLines: orderLines ?? this.orderLines,
      isUpload: isUpload ?? this.isUpload,
      writeDate: writeDate ?? this.writeDate,
      note: note ?? this.note,
    );
  }
}
