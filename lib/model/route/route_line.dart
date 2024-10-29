import 'dart:convert';

/// id : 1
/// route_plan_id : 7
/// number : 1
/// sequence : 0
/// partner_id : 5814
/// route_plan_name : "KYET SAR PYIN - CO1"
/// partner_name : "MA MU SWAM "

RouteLine lineIdsFromJson(String str) => RouteLine.fromJson(json.decode(str));

String lineIdsToJson(RouteLine data) => json.encode(data.toJson());

class RouteLine {
  RouteLine({
    this.id,
    this.routePlanId,
    this.number,
    this.sequence,
    this.partnerId,
    this.routePlanName,
    this.partnerName,
  });

  RouteLine.fromJson(dynamic json) {
    id = json['id'];
    routePlanId = json['route_plan_id'];
    number = json['number'];
    sequence = json['sequence'];
    partnerId = json['partner_id'];
    routePlanName = json['route_plan_name'];
    partnerName = json['partner_name'];
  }

  int? id;
  int? routePlanId;
  int? number;
  int? sequence;
  int? partnerId;
  String? routePlanName;
  String? partnerName;

  RouteLine copyWith({
    int? id,
    int? routePlanId,
    int? number,
    int? sequence,
    int? partnerId,
    String? routePlanName,
    String? partnerName,
  }) =>
      RouteLine(
        id: id ?? this.id,
        routePlanId: routePlanId ?? this.routePlanId,
        number: number ?? this.number,
        sequence: sequence ?? this.sequence,
        partnerId: partnerId ?? this.partnerId,
        routePlanName: routePlanName ?? this.routePlanName,
        partnerName: partnerName ?? this.partnerName,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['route_plan_id'] = routePlanId;
    map['number'] = number;
    map['sequence'] = sequence;
    map['partner_id'] = partnerId;
    map['route_plan_name'] = routePlanName;
    map['partner_name'] = partnerName;
    return map;
  }
}
