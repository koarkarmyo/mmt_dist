import '../../../database/base_db_repo.dart';
import '../../../database/db_constant.dart';
import '../../../model/route/route_line.dart';
import '../../../model/route/route_plan.dart';

class RoutePlanDBRepo extends BaseDBRepo {
  static final RoutePlanDBRepo instance = RoutePlanDBRepo._();

  RoutePlanDBRepo._();

  Future<List<RoutePlan>> getRoutePlan({required String date}) async {
    List<RoutePlan> routePlanList = [];
    List<RouteLine> routePlanLineList = [];

    List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
        tableName: DBConstant.mscmRouteTable,
        where: '${DBConstant.dateStart} like ?',
        whereArgs: ['%$date%']);

    jsonList.forEach((element) {
      routePlanList.add(RoutePlan.fromJson(element));
    });

    // asked ko arkar comfirmed
    //  1 employee don't have multi route in same day
    if (routePlanList.isNotEmpty) {
      List<Map<String, dynamic>> jsonLineList =
          await helper.readDataByWhereArgs(
              tableName: DBConstant.mscmRouteLineTable,
              where: '${DBConstant.routePlanId} = ?',
              whereArgs: [routePlanList.first.id],
              orderBy: DBConstant.number);
      jsonLineList.forEach((element) {
        routePlanLineList.add(RouteLine.fromJson(element));
      });
      routePlanList.first.lineIds = routePlanLineList;
    }

    return routePlanList;
  }
}
