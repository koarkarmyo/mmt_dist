import 'package:mmt_mobile/database/base_db_repo.dart';

import '../../model/dashboard.dart';
import '../db_constant.dart';

class DashboardDBRepo extends BaseDBRepo {
  static final DashboardDBRepo instance = DashboardDBRepo._();

  DashboardDBRepo._();

  Future<List<Dashboard>> getAllDashboard() async {

      List<Map<String, dynamic>> dashboardJsonList =
          await helper.readAllData(tableName: DBConstant.dashboardTable);
      List<Dashboard> dashboardList = [];
      for (Map<String, dynamic> element in dashboardJsonList) {
        dashboardList.add(Dashboard.fromJson(element));
      }

      return dashboardList;

  }

  Future<List<Dashboard>> getCustomerDashboard() async {

      List<Map<String, dynamic>> dashboardJsonList = await helper.readAllData(
          tableName: DBConstant.customerDashboardTable);
      List<Dashboard> dashboardList = [];
      for (Map<String, dynamic> element in dashboardJsonList) {
        dashboardList.add(Dashboard.fromJson(element));
      }
      return dashboardList;

  }
}
