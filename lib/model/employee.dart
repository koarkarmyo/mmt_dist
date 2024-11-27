import 'package:collection/collection.dart';
import 'package:mmt_mobile/sync/models/sync_action.dart';

import '../src/mmt_application.dart';
import 'company_id.dart';

class Employee {
  Employee(
      {this.name,
      this.id,
      this.phone,
      this.email,
      this.defaultLocationId,
      this.defaultLocationName,
      this.companyId,
      this.syncActionList,
      this.useLooseBox,
      this.companyList});

  Employee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    phone = json['email'];
    defaultLocationId = json['default_location_id'];
    defaultLocationName = json['default_location_name'];
    companyId = json['company_id'];
    useLooseBox = json['use_loose_box'];
    if (json['sync_action'] != null) {
      syncActionList = [];
      for (var element in (json['sync_action'] as List<dynamic>)) {
        syncActionList
            ?.add(SyncAction.fromJson(element as Map<String, dynamic>));
      }
    }
    if (json['company_list'] != null) {
      companyList = [];
      for (var companyJson in (json['company_list'] as List<dynamic>)) {
        companyList?.add(CompanyId.fromJson(companyJson));
      }
    }

    MMTApplication.selectedCompany = (companyList ?? [])
        .firstWhereOrNull((element) => element.id == companyId);
  }

  String? name;
  int? id;
  String? phone;
  String? email;
  int? defaultLocationId;
  String? defaultLocationName;
  int? companyId;
  List<SyncAction>? syncActionList;
  bool? useLooseBox;
  List<CompanyId>? companyList;

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
    map['use_loose_box'] = useLooseBox;
    List<Map<String, dynamic>> companyJsonList = [];

    companyList?.forEach(
      (element) {
        companyJsonList.add(element.toJson());
      },
    );
    map['company_list'] = companyJsonList;

    return map;
  }
}
