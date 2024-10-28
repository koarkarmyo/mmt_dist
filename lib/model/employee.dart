import 'package:mmt_mobile/sync/models/sync_action.dart';

class Employee {
  Employee({
    this.name,
    this.id,
    this.phone,
    this.defaultLocationId,
    this.defaultLocationName,
    this.companyId,
    this.syncActionList
  });

  Employee.fromJson(Map<String,dynamic> json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    defaultLocationId = json['default_location_id'];
    defaultLocationName = json['default_location_name'];
    companyId = json['company_id'];
    if(json['sync_action'] != null){
      syncActionList = [];
      for (Map<String,dynamic> element in (json['sync_action'] as List<Map<String,dynamic>>)) {
        syncActionList?.add(SyncAction.fromJson(element));
      }
    }
  }

  String? name;
  int? id;
  String? phone;
  int? defaultLocationId;
  String? defaultLocationName;
  int? companyId;
  List<SyncAction>? syncActionList ;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['phone'] = phone;
    map['default_location_id'] = defaultLocationId;
    map['default_location_name'] = defaultLocationName;
    map['company_id'] = companyId;
    map['sync_action'] = syncActionList;
    return map;
  }
}
