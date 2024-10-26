import 'dart:convert';

import 'package:equatable/equatable.dart';

/// id : 1
/// name : "V01 Thursday Route"

DailyRoute routeIdFromJson(String str) => DailyRoute.fromJson(json.decode(str));

String routeIdToJson(DailyRoute data) => json.encode(data.toJson());

class DailyRoute extends Equatable {
  DailyRoute({
    this.id,
    this.name,
  });

  DailyRoute.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [this.id, this.name];
}
