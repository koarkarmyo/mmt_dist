import 'dart:convert';

import 'package:equatable/equatable.dart';

// / id : 1
// / dashboard_id : 1
// / icon : "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"
// / is_folder : true
// / action_url : "/inventory"
// / parent_id : null
// / priority : 1
// / solution_id : "sale"
// / parent_url : null
// / dashboard_name : "Inventory"
// / staff_role_id : 2
// / staff_role_name : "Super User"

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard extends Equatable {
  int? id;
  int? dashboardId;
  String? icon;
  bool? isFolder;
  String? actionUrl;
  int? parentId;
  int? priority;
  String? solutionId;
  String? parentUrl;
  String? dashboardName;
  int? staffRoleId;
  String? staffRoleName;
  String? writeDate;
  String? description;
  int? groupId;
  String? groupName;

  Dashboard({
    this.id,
    this.dashboardId,
    this.icon,
    this.isFolder,
    this.actionUrl,
    this.parentId,
    this.priority,
    this.solutionId,
    this.parentUrl,
    this.dashboardName,
    this.staffRoleId,
    this.staffRoleName,
    this.description,
    this.groupId,
    this.groupName,
    // this.writeDate,
  });

  Dashboard.fromJson(dynamic json) {
    id = json['id'];
    dashboardId = json['dashboard_id'];
    icon = json['icon'];
    isFolder = json['is_folder'];
    actionUrl = json['action_url'];
    parentId = json['parent_id'];
    priority = json['priority'];
    solutionId = json['solution_id'];
    parentUrl = json['parent_url'];
    dashboardName = json['dashboard_name'];
    staffRoleId = json['staff_role_id'];
    staffRoleName = json['staff_role_name'];
    writeDate = json['write_date'];
    description = json['description'];
    groupId = json['dashboard_group_id'];
    groupName = json['dashboard_group_name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['dashboard_id'] = dashboardId;
    map['icon'] = icon;
    map['is_folder'] = isFolder;
    map['action_url'] = actionUrl;
    map['parent_id'] = parentId;
    map['priority'] = priority;
    map['solution_id'] = solutionId;
    map['parent_url'] = parentUrl;
    map['dashboard_name'] = dashboardName;
    map['staff_role_id'] = staffRoleId;
    map['staff_role_name'] = staffRoleName;
    map['write_date'] = writeDate;
    map['description'] = description;
    map['dashboard_group_id'] = groupId;
    map['dashboard_group_name'] = groupName;
    return map;
  }

  Map<String, dynamic> toJsonDB() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['dashboard_id'] = dashboardId;
    map['icon'] = icon;
    map['is_folder'] = isFolder! ? 1 : 0;
    map['action_url'] = actionUrl;
    map['parent_id'] = parentId;
    map['priority'] = priority;
    map['solution_id'] = solutionId;
    map['parent_url'] = parentUrl;
    map['dashboard_name'] = dashboardName;
    map['staff_role_id'] = staffRoleId;
    map['staff_role_name'] = staffRoleName;
    map['write_date'] = writeDate;
    map['description'] = description;
    map['dashboard_group_id'] = groupId;
    map['dashboard_group_name'] = groupName;
    return map;
  }

  Dashboard.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    dashboardId = json['dashboard_id'];
    icon = json['icon'];
    isFolder = json['is_folder'] == 1 ? true : false;
    actionUrl = json['action_url'];
    parentId = json['parent_id'];
    priority = json['priority'];
    solutionId = json['solution_id'];
    parentUrl = json['parent_url'];
    dashboardName = json['dashboard_name'];
    staffRoleId = json['staff_role_id'];
    staffRoleName = json['staff_role_name'];
    writeDate = json['write_date'];
    description = json['description'];
    groupId = json['dashboard_group_id'];
    groupName = json['dashboard_group_name'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.id,
        this.dashboardId,
        this.icon,
        this.isFolder,
        this.actionUrl,
        this.parentId,
        this.priority,
        this.solutionId,
        this.parentUrl,
        this.dashboardName,
        this.staffRoleId,
        this.staffRoleName,
        this.writeDate,
        this.description,
        this.groupId,
        this.groupName
      ];

  @override
  String toString() {
    return 'Dashboard{id: $id, dashboardId: $dashboardId, icon: $icon, isFolder: $isFolder, actionUrl: $actionUrl, parentId: $parentId, priority: $priority, solutionId: $solutionId, parentUrl: $parentUrl, dashboardName: $dashboardName, description: $description, staffRoleId: $staffRoleId, staffRoleName: $staffRoleName, writeDate: $writeDate}';
  }
}
