import 'package:mmt_mobile/database/base_db_repo.dart';

import '../../model/cust_visit.dart';
import '../db_constant.dart';

class CustVisitDBRepo extends BaseDBRepo {
  static CustVisitDBRepo instance = CustVisitDBRepo._();

  CustVisitDBRepo._();

  Future<bool> saveCustVisit({required CustVisit custVisit}) async {
    int? id = await helper.insertData(
        table: DBConstant.custVisitTable, values: custVisit.toJsonDB());
    return id != null;
  }
}
