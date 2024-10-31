
import 'package:collection/collection.dart';

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
  DeliveryStates? delivery_status;

  SaleOrder({
    this.id,
    this.name,
    this.createDate,
    this.partnerId,
    this.partnerName,
    this.salePerson,
    this.amountTotal,
    this.state,
    this.delivery_status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'createDate': this.createDate,
      'partnerId': this.partnerId,
      'partnerName': this.partnerName,
      'salePerson': this.salePerson,
      'amountTotal': this.amountTotal,
      'state': this.state,
      'delivery_status': this.delivery_status,
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
      delivery_status: DeliveryStates.values.firstWhereOrNull(
          (element) => element.name == map['delivery_status']),
    );
  }
}
