import 'dart:convert';

import 'package:mmt_mobile/sync/models/sync_group.dart';

SyncResponse dataFromJson(String str) =>
    SyncResponse.fromJson(json.decode(str));

String dataToJson(SyncResponse data) => json.encode(data.toJson());

class SyncResponse {
  SyncResponse({
    this.id,
    this.name,
    this.priority,
    this.isAutoSync,
    this.isManualSync,
    this.isUpload,
    this.actionGroupId,
    this.actionGroupName,
    this.description,
    this.solutionId,
  });

  SyncResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    isAutoSync = json['is_auto_sync'];
    isManualSync = json['is_manual_sync'];
    isUpload = json['is_upload'];
    actionGroupName = json['action_group_name'];
    actionGroupId = json['action_group_id'];
    description = json['description'];
    solutionId = json['solution_id'];
  }

  int? id;
  String? name;
  int? priority;
  bool? isAutoSync;
  bool? isManualSync;
  bool? isUpload;
  String? actionGroupName;
  String? description;
  int? actionGroupId;
  String? solutionId;
  List<SyncActionGroup>? syncActionGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['priority'] = priority;
    map['is_auto_sync'] = isAutoSync;
    map['is_manual_sync'] = isManualSync;
    map['is_upload'] = isUpload;
    map['action_group_name'] = actionGroupName;
    map['action_group_id'] = actionGroupId;
    map['solution_id'] = solutionId;
    map['description'] = description;
    map['action_group'] = syncActionGroup?.map((e) => e.toJson(),).toList();
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['priority'] = priority;
    map['is_auto_sync'] = isAutoSync! ? 1 : 0;
    map['is_manual_sync'] = isManualSync! ? 1 : 0; //duty off
    map['is_upload'] = isUpload! ? 1 : 0;
    map['action_group_name'] = actionGroupName;
    map['action_group_id'] = actionGroupId;
    map['solution_id'] = solutionId;
    map['description'] = description;
    return map;
  }

  SyncResponse.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    isAutoSync = json['is_auto_sync'] != 0;
    isManualSync = json['is_manual_sync'] != 0;
    isUpload = json['is_upload'] != 0;
    actionGroupName = json['action_group_name'];
    actionGroupId = json['action_group_id'];
    solutionId = json['solution_id'];
    description = json['description'];
  }

   bool checkActionGroup({ int? groupId, String? groupName}){
    for(SyncActionGroup group in syncActionGroup ?? []){
      if(group.name == groupName || group.id == groupId){
        return true;
      }
    }
    return false;
  }
}
