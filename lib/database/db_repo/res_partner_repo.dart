import 'package:mmt_mobile/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/res_partner.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

class ResPartnerRepo extends BaseDBRepo {
  static final ResPartnerRepo instance = ResPartnerRepo._();

  ResPartnerRepo._();

  Future<List<ResPartner>> getResPartner() async {
    List<ResPartner> partnerList = [];

    List<Map<String, dynamic>> partnerJsonList = await DatabaseHelper.instance
        .readAllData(tableName: DBConstant.resPartnerTable);

    partnerJsonList.forEach(
      (element) {
        partnerList.add(ResPartner.fromJson(element));
      },
    );

    partnerList.forEach(
      (element) => print(element.toJson()),
    );

    return partnerList;
  }
}
