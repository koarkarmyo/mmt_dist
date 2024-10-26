import 'dart:convert';

import 'package:equatable/equatable.dart';

/// id : 1
/// name : "EAC WH"

Warehouse warehouseIdFromJson(String str) =>
    Warehouse.fromJson(json.decode(str));

String warehouseIdToJson(Warehouse data) => json.encode(data.toJson());

class Warehouse extends Equatable {
  Warehouse({
    this.id,
    this.name,
  });

  Warehouse.fromJson(dynamic json) {
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
