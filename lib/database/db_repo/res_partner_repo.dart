import 'package:mmt_mobile/database/database_helper.dart';
import 'package:mmt_mobile/src/extension/nullable_extension.dart';

import '../../model/res_partner.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

class ResPartnerRepo extends BaseDBRepo {
  static final ResPartnerRepo instance = ResPartnerRepo._();

  ResPartnerRepo._();

  Future<List<ResPartner>> getResPartner({String? name}) async {
    List<ResPartner> partnerList = [];
    List<Map<String, dynamic>> partnerJsonList = [];
    String query = '';
    List args = [];
    if (name.isNotNull) {
      query += '${addAnd(query)} name LIKE ?';
      args.add("%$name%");
      partnerJsonList = await DatabaseHelper.instance.readDataByWhereArgs(
        tableName: DBConstant.resPartnerTable,
        where: query,
        whereArgs: args,
        orderBy: DBConstant.name,
      );
    } else {
      partnerJsonList = await DatabaseHelper.instance.readAllData(
        tableName: DBConstant.resPartnerTable,
        orderBy: DBConstant.name,
      );
    }

    partnerJsonList.forEach(
      (element) {
        partnerList.add(ResPartner.fromJson(element));
      },
    );

    return partnerList;
  }
}
