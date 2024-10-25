class Employee {
  Employee({
    this.name,
    this.id,
    this.phone,
    this.defaultLocationId,
    this.defaultLocationName,
  });

  Employee.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    defaultLocationId = json['default_location_id'];
    defaultLocationName = json['default_location_name'];
  }

  String? name;
  int? id;
  String? phone;
  int? defaultLocationId;
  String? defaultLocationName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['phone'] = phone;
    map['default_location_id'] = defaultLocationId;
    map['default_location_name'] = defaultLocationName;
    return map;
  }
}
