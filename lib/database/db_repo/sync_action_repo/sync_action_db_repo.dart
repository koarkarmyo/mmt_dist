

import '../../../model/sync_group.dart';
import '../../../model/sync_response.dart';
import '../../base_db_repo.dart';
import '../../db_constant.dart';

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

  Future<List<SyncResponse>> getActionListByGroup(int gpId,
      {bool? isManualSync}) async {
    List<SyncResponse> actionList = [];

    // date1.subtract(Duration(days: 7, hours: 3, minutes: 43, seconds: 56));

    List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
        tableName: DBConstant.syncActionWithGroupTable,
        where: '${DBConstant.actionGroupID}=?',
        whereArgs: [gpId]);

    List<int> actionIds = [];

    for (final json in jsonList) {
      actionIds.add(json['action_id']);
    }

    await Future.forEach<int>(actionIds, (actionId) async {
      List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.mscmSyncActionTable,
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
