

import 'package:mmt_mobile/sync/models/sync_group.dart';

class SyncAction {
  int? id;
  String? name;
  int? priority;
  bool? isAutoSync;
  bool? isManualSync;
  bool? isUpload;
  String? description;
  String? solutionId;
  List<SyncActionGroup>? actionGroup;

  SyncAction({
    this.id,
    this.name,
    this.priority,
    this.isAutoSync,
    this.isManualSync,
    this.isUpload,
    this.description,
    this.solutionId,
    this.actionGroup,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'priority': this.priority,
      'is_auto_sync': this.isAutoSync == true ? 1 : 0,
      'is_manual_sync': this.isManualSync == true ? 1 : 0,
      'is_upload': this.isUpload == true ? 1 : 0,
      'description': this.description,
      'solution_id': this.solutionId,
    };
  }

  factory SyncAction.fromJson(Map<String, dynamic> map) {
    bool isAutoSync = false;
    bool isManualSync = false;
    bool isUpload = false;

    List<SyncActionGroup> actionGroups = [];

    if (map['action_group'] != null) {
      actionGroups = (map['action_group'] as List)
          .map((e) => SyncActionGroup.fromJson(e))
          .toList();
    }

    if (map['is_auto_sync'].runtimeType == int) {
      isAutoSync = map['is_auto_sync'] == 1;
    } else {
      isAutoSync = map['is_auto_sync'] ?? false;
    }

    if (map['is_manual_sync'].runtimeType == int) {
      isManualSync = map['is_manual_sync'] == 1;
    } else {
      isManualSync = map['is_manual_sync'] ?? false;
    }

    if (map['is_upload'].runtimeType == int) {
      isUpload = map['is_upload'] == 1;
    } else {
      isUpload = map['is_upload'] ?? false;
    }

    return SyncAction(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      isAutoSync: isAutoSync,
      isManualSync: isManualSync,
      isUpload: isUpload,
      description: map['description'],
      solutionId: map['solution_id'],
      actionGroup: actionGroups,
    );
  }

  SyncAction copyWith({
    int? id,
    String? name,
    int? priority,
    bool? isAutoSync,
    bool? isManualSync,
    bool? isUpload,
    String? description,
    String? solutionId,
    List<SyncActionGroup>? actionGroup,
  }) {
    return SyncAction(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      isAutoSync: isAutoSync ?? this.isAutoSync,
      isManualSync: isManualSync ?? this.isManualSync,
      isUpload: isUpload ?? this.isUpload,
      description: description ?? this.description,
      solutionId: solutionId ?? this.solutionId,
      actionGroup: actionGroup ?? this.actionGroup,
    );
  }
}
