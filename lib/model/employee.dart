import 'package:mmt_mobile/sync/models/sync_action.dart';

class Employee {
  Employee({
    this.name,
    this.id,
    this.phone,
    this.email,
    this.defaultLocationId,
    this.defaultLocationName,
    this.companyId,
    this.syncActionList
  });

  Employee.fromJson(Map<String,dynamic> json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    phone = json['email'];
    defaultLocationId = json['default_location_id'];
    defaultLocationName = json['default_location_name'];
    companyId = json['company_id'];
    if(json['sync_action'] != null){
      syncActionList = [];
      for (var element in (json['sync_action'] as List<dynamic>)) {
        syncActionList?.add(SyncAction.fromJson(element as Map<String,dynamic>));
      }
    }
  }

  String? name;
  int? id;
  String? phone;
  String? email;
  int? defaultLocationId;
  String? defaultLocationName;
  int? companyId;
  List<SyncAction>? syncActionList ;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['phone'] = phone;
    map['email'] = email;
    map['default_location_id'] = defaultLocationId;
    map['default_location_name'] = defaultLocationName;
    map['company_id'] = companyId;
    map['sync_action'] = syncActionList;
    return map;
  }
}
