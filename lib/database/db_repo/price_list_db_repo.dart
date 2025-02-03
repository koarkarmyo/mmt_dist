import 'package:mmt_mobile/database/base_db_repo.dart';

import '../../model/price_list/price_list_item.dart';
import '../db_constant.dart';

class PriceListDbRepo extends BaseDBRepo {
  static final PriceListDbRepo instance = PriceListDbRepo._();

  PriceListDbRepo._();

  Future<List<PriceListItem>> getAllPriceList() async {
    print("get price list");
    List<Map<String, dynamic>> priceListJsonList =
        await helper.readAllData(tableName: DBConstant.priceListItemTable);
    List<PriceListItem> priceList = [];
    for (Map<String, dynamic> element in priceListJsonList) {
      print("Price List : $element");
      priceList.add(PriceListItem.fromJson(element));
    }

    return priceList;
  }
}
