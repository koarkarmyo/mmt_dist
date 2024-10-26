import 'dart:convert';

/// id : 1
/// name : "San Francisco"

DefaultWhId defaultWhIdFromJson(String str) => DefaultWhId.fromJson(json.decode(str));
String defaultWhIdToJson(DefaultWhId data) => json.encode(data.toJson());
class DefaultWhId {
  DefaultWhId({
    int? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  DefaultWhId.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  DefaultWhId copyWith({  int? id,
    String? name,
  }) => DefaultWhId(  id: id ?? _id,
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