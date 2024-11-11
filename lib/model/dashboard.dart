import 'package:mmt_mobile/model/staff_role.dart';

class Dashboard {
  int? id;
  int? dashboardGroupId;
  String? dashboardGroupName;
  int? dashboardId;
  String? dashboardName;
  bool? isFolder;
  int? companyId;
  String? companyName;
  String? solutionId;
  String? actionUrl;
  int? parentId;
  String? parentDescription;
  int? priority;
  String? description;
  String? writeDate;

  Dashboard(
      {this.id,
      this.dashboardGroupId,
      this.dashboardGroupName,
      this.dashboardId,
      this.dashboardName,
      this.isFolder,
      this.companyId,
      this.companyName,
      this.solutionId,
      this.actionUrl,
      this.parentId,
      this.parentDescription,
      this.priority,
      this.description,
      this.writeDate});

  Dashboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dashboardGroupId = json['dashboard_group_id'];
    dashboardGroupName = json['dashboard_group_name'];
    dashboardId = json['dashboard_id'];
    dashboardName = json['dashboard_name'];
    isFolder = json['is_folder'];
    solutionId = json['solution_id'];
    actionUrl = json['action_url'];
    parentId = json['parent_id'];
    parentDescription = json['parent_description'];
    priority = json['priority'];
    description = json['description'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dashboard_group_id'] = this.dashboardGroupId;
    data['dashboard_group_name'] = this.dashboardGroupName;
    data['dashboard_id'] = this.dashboardId;
    data['dashboard_name'] = this.dashboardName;
    data['is_folder'] = this.isFolder;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['solution_id'] = this.solutionId;
    data['action_url'] = this.actionUrl;
    data['parent_id'] = this.parentId;
    data['parent_description'] = this.parentDescription;
    data['priority'] = this.priority;
    data['description'] = this.description;
    data['write_date'] = this.writeDate;
    return data;
  }

  Dashboard.fromJsonDB(Map<String, dynamic> json) {
    id = json['id'];
    dashboardGroupId = json['dashboard_group_id'];
    dashboardGroupName = json['dashboard_group_name'];
    dashboardId = json['dashboard_id'];
    dashboardName = json['dashboard_name'];
    isFolder = json['is_folder'] == 1;
    companyId = json['company_id'];
    companyName = json['company_name'];
    solutionId = json['solution_id'];
    actionUrl = json['action_url'];
    parentId = json['parent_id'];
    parentDescription = json['parent_description'];
    priority = json['priority'];
    description = json['description'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dashboard_group_id'] = this.dashboardGroupId;
    data['dashboard_group_name'] = this.dashboardGroupName;
    data['dashboard_id'] = this.dashboardId;
    data['dashboard_name'] = this.dashboardName;
    data['is_folder'] = (isFolder ?? false) ? 1 : 0;
    data['solution_id'] = this.solutionId;
    data['action_url'] = this.actionUrl;
    data['parent_id'] = this.parentId;
    data['parent_description'] = this.parentDescription;
    data['priority'] = this.priority;
    data['description'] = this.description;
    data['write_date'] = this.writeDate;
    return data;
  }
}
