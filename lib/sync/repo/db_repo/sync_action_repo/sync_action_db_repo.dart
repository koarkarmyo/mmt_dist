import '../../../../database/base_db_repo.dart';
import '../../../../database/db_constant.dart';
import '../../../models/sync_group.dart';
import '../../../models/sync_response.dart';

class SyncActionDBRepo extends BaseDBRepo {
  static final SyncActionDBRepo _instance = SyncActionDBRepo._();

  SyncActionDBRepo._();

  factory SyncActionDBRepo() {
    return _instance;
  }

  Future<List<SyncActionGroup>> getSyncActionGroups() async {
    List<Map<String, dynamic>> groupsJsonList =
        await helper.readAllData(tableName: DBConstant.syncActionGroupTable);
    List<SyncActionGroup> groupList = [];
    for (final json in groupsJsonList) {
      groupList.add(SyncActionGroup.fromJson(json));
    }

    return groupList;
  }

  Future<List<SyncResponse>> getActionList(
      {required bool isManualSync, String? groupName}) async {
    List<SyncResponse> actionList = [];
    List<Map<String, dynamic>> actionJsonList = [];

    if (groupName != null) {
      // "and ${DBConstant.actionGroupName} =? ;" : ';'
      actionJsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.syncActionWithGroupTable,
          where: ' ${DBConstant.actionGroupName} =? ',
          whereArgs: [groupName]);
      actionJsonList.forEach(
        (element) {
          actionList.add(SyncResponse(name: element['action_name']));
        },
      );
    } else {
      actionJsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.syncActionTable,
          where: '${DBConstant.iSManualSync}=? ',
          whereArgs: [isManualSync == true ? 1 : 0]);

      List<Map<String, dynamic>> actionGroupList = await helper.readAllData(
          tableName: DBConstant.syncActionWithGroupTable);

      actionJsonList.forEach(
        (element) {
         SyncResponse syncResponse = SyncResponse.fromJsonDB(element);
         syncResponse.syncActionGroup = [];
         actionGroupList.where((syncGroup)=> syncGroup['action_id'] == syncResponse.id).toList().forEach((element) {
           syncResponse.syncActionGroup?.add(SyncActionGroup(
             id: element[DBConstant.actionGroupID],
             name: element[DBConstant.actionGroupName]
           ));
         },);
         actionList.add(syncResponse);
        },
      );
    }
    return actionList;
  }

  Future<List<SyncResponse>> getActionListByGroup(
      {int? gpId, String? groupName, bool? isManualSync}) async {
    List<SyncResponse> actionList = [];

    List<Map<String, dynamic>> jsonList = [];

    if (gpId != null) {
      jsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.syncActionWithGroupTable,
          where: '${DBConstant.actionGroupID}=?',
          whereArgs: [gpId]);
    } else if (groupName != null) {
      await helper.readDataByWhereArgs(
          tableName: DBConstant.syncActionWithGroupTable,
          where: '${DBConstant.actionGroupName}=?',
          whereArgs: [groupName]);
    }

    List<int> actionIds = [];

    for (final json in jsonList) {
      actionIds.add(json['action_id']);
    }

    await Future.forEach<int>(actionIds, (actionId) async {
      List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.syncActionTable,
          where:
              '${DBConstant.id}=?  AND ${(isManualSync ?? true) ? DBConstant.iSManualSync : DBConstant.isAutoSync} =?',
          whereArgs: [
            actionId,
            1,
          ],
          orderBy: DBConstant.priority);

      if (jsonList.isNotEmpty) {
        actionList.add(SyncResponse.fromJsonDB(jsonList.first));
      }
    });

    return actionList;
  }
}
