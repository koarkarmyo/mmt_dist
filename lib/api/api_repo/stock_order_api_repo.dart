import '../base_api_repo.dart';


class StockOrderApiRepo extends BaseApiRepo {
  static final StockOrderApiRepo _instance = StockOrderApiRepo._();

  StockOrderApiRepo._();

  factory StockOrderApiRepo() {
    return _instance;
  }
}
