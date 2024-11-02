import 'package:mmt_mobile/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/currency.dart';
import '../../model/res_partner.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

class CurrencyDbRepo extends BaseDBRepo {
  static final CurrencyDbRepo instance = CurrencyDbRepo._();

  CurrencyDbRepo._();

  Future<List<Currency>> getCurrencies() async {
    List<Currency> currencyList = [];

    List<Map<String, dynamic>> currencyJsonList = await DatabaseHelper.instance
        .readAllData(tableName: DBConstant.currencyTable);

    currencyJsonList.forEach(
      (element) {
        currencyList.add(Currency.fromJson(element));
      },
    );

    currencyList.forEach(
      (element) => print(element.toJson()),
    );

    return currencyList;
  }
}
