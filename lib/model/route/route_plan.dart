import 'route_line.dart';
import 'dart:convert';

/// id : 7
/// route_id : 9
/// date_start : "2023-04-22 00:30:00"
/// saleman_id : 2
/// line_ids : [{"id":1,"route_plan_id":7,"number":1,"sequence":0,"partner_id":5814,"route_plan_name":"KYET SAR PYIN - CO1","partner_name":"MA MU SWAM "}]
/// route_name : "SR1 - MONDAY"
/// saleman_name : "SR1- THEIN ZAW"

RoutePlan routePlanFromJson(String str) => RoutePlan.fromJson(json.decode(str));

String routePlanToJson(RoutePlan data) => json.encode(data.toJson());

class RoutePlan {
  RoutePlan({
    this.id,
    this.routeId,
    this.dateStart,
    this.salemanId,
    this.lineIds,
    this.routeName,
    this.salemanName,
    this.writeDate,
  });

  RoutePlan.fromJson(dynamic json) {
    id = json['id'];
    routeId = json['route_id'];
    dateStart = json['date_start'];
    salemanId = json['saleman_id'];
    if (json['line_ids'] != null) {
      lineIds = [];
      json['line_ids'].forEach((v) {
        lineIds?.add(RouteLine.fromJson(v));
      });
    }
    routeName = json['route_name'];
    salemanName = json['saleman_name'];
    writeDate = json['write_date'];
  }

  int? id;
  int? routeId;
  String? dateStart;
  int? salemanId;
  List<RouteLine>? lineIds;
  String? routeName;
  String? salemanName;
  String? writeDate;

  RoutePlan copyWith({
    int? id,
    int? routeId,
    String? dateStart,
    int? salemanId,
    List<RouteLine>? lineIds,
    String? routeName,
    String? salemanName,
    String? writeDate,
  }) =>
      RoutePlan(
        id: id ?? this.id,
        routeId: routeId ?? this.routeId,
        dateStart: dateStart ?? this.dateStart,
        salemanId: salemanId ?? this.salemanId,
        lineIds: lineIds ?? this.lineIds,
        routeName: routeName ?? this.routeName,
        salemanName: salemanName ?? this.salemanName,
        writeDate: writeDate ?? this.writeDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['route_id'] = routeId;
    map['date_start'] = dateStart;
    map['saleman_id'] = salemanId;
    if (lineIds != null) {
      map['line_ids'] = lineIds?.map((v) => v.toJson()).toList();
    }
    map['route_name'] = routeName;
    map['saleman_name'] = salemanName;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['route_id'] = routeId;
    map['date_start'] = dateStart;
    map['saleman_id'] = salemanId;
    map['route_name'] = routeName;
    map['saleman_name'] = salemanName;
    map['write_date'] = writeDate;
    return map;
  }
}
