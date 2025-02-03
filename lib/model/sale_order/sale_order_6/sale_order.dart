import 'package:collection/collection.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';

import '../../../src/enum.dart';

class SaleOrder {
  int? id;
  String? name;
  String? createDate;
  int? partnerId;
  String? partnerName;
  int? salePerson;
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
    this.salePerson,
    this.amountTotal,
    this.state,
    this.deliveryStatus,
    this.orderLines,
    this.isUpload,
    this.writeDate,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createDate': createDate,
      'partnerId': partnerId,
      'partnerName': partnerName,
      'salePerson': salePerson,
      'amountTotal': amountTotal,
      'state': state,
      'delivery_status': deliveryStatus,
      'is_upload': isUpload,
      'write_date': writeDate,
      'note': note,
    };
  }

  Map<String, dynamic> toJsonDB() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'partner_id': partnerId,
      'partner_name': partnerName,
      'sale_person': salePerson,
      'amount_total': amountTotal,
      'state': state,
      'delivery_status': deliveryStatus,
      'is_upload': isUpload,
      'write_date': writeDate,
      'note': note
    };
  }

  SaleOrder.fromJsonDB(Map<String, dynamic> map) {
    partnerId = map['name'];
    name = map['name'];
    partnerName = map['partner_name'];
    partnerId = map['partner_id'];
    salePerson = map['sale_person'];
    state = map['sale_person'];
    state = OrderStates.values
        .firstWhereOrNull((element) => element.name == map['state']);
    deliveryStatus = DeliveryStates.values
        .firstWhereOrNull((element) => element.name == map['delivery_status']);
    isUpload = map['is_upload'] == 1;
    amountTotal = map['amount_total'];
    writeDate = map['write_date'];
    note = map['note'];
  }

  factory SaleOrder.fromJson(Map<String, dynamic> map) {
    return SaleOrder(
      id: map['id'],
      name: map['name'],
      createDate: map['create_date'],
      partnerId: map['partner_id'],
      partnerName: map['partner_name'],
      salePerson: map['sale_person'],
      amountTotal: map['amount_total'],
      writeDate: map['write_date'],
      state: OrderStates.values
          .firstWhereOrNull((element) => element.name == map['state']),
      deliveryStatus: DeliveryStates.values.firstWhereOrNull(
          (element) => element.name == map['delivery_status']),
      note: map['note']
    );
  }

  SaleOrder copyWith({
    int? id,
    String? name,
    String? createDate,
    int? partnerId,
    String? partnerName,
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
      salePerson: salePerson ?? this.salePerson,
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
