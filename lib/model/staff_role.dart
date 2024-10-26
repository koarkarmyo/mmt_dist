import 'dart:convert';

import 'package:equatable/equatable.dart';

/// id : 1
/// name : "User"

StaffRole staffRoleFromJson(String str) => StaffRole.fromJson(json.decode(str));

String staffRoleToJson(StaffRole data) => json.encode(data.toJson());

class StaffRole extends Equatable {
  StaffRole({
    this.id,
    this.name,
  });

  StaffRole.fromJson(dynamic json) {
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
