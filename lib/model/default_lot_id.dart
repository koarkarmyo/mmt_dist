
import 'dart:convert';

/// id : 8
/// name : "WH/Stock"

DefaultLocId defaultLocIdFromJson(String str) => DefaultLocId.fromJson(json.decode(str));
String defaultLocIdToJson(DefaultLocId data) => json.encode(data.toJson());
class DefaultLocId {
  DefaultLocId({
    int? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  DefaultLocId.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  DefaultLocId copyWith({  int? id,
    String? name,
  }) => DefaultLocId(  id: id ?? _id,
    name: name ?? _name,
  );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}
