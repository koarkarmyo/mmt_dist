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
    };
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
      state: OrderStates.values
          .firstWhereOrNull((element) => element.name == map['state']),
      deliveryStatus: DeliveryStates.values.firstWhereOrNull(
          (element) => element.name == map['delivery_status']),
    );
  }
}
