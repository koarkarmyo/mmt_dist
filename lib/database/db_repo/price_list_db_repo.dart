import 'package:mmt_mobile/database/base_db_repo.dart';

import '../../model/price_list/price_list.dart';
import '../../model/price_list/price_list_item.dart';
import '../db_constant.dart';

class PriceListDbRepo extends BaseDBRepo {
  static final PriceListDbRepo instance = PriceListDbRepo._();

  PriceListDbRepo._();

  Future<List<PriceListItem>> getAllPriceList() async {
    List<Map<String, dynamic>> priceListJsonList =
        await helper.readAllData(tableName: DBConstant.dashboardTable);
    List<PriceListItem> priceList = [];
    for (Map<String, dynamic> element in priceListJsonList) {
      priceList.add(PriceListItem.fromJson(element));
    }

    return priceList;
  }
}
