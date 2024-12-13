import 'package:dio/dio.dart';

import '../../model/base_api_response.dart';
import '../../model/qty_check_response.dart';
import '../../src/mmt_application.dart';
import '../base_api_repo.dart';


class QtyBalanceApiRepo extends BaseApiRepo {
  Future<List<QtyCheckResponse>> getBalanceQty(List<int> productIds) async {
    Response qtyCheckResponse =
        await postMethodCall( params: {
      "name": "get_qty_available",
      "token": '${DateTime.now().millisecondsSinceEpoch}',
      "args": [
        {
          "name": "location_id",
          "value": MMTApplication.loginResponse?.warehouseStockLocationId
        },
        {"name": "ids", "value": productIds},
      ]
    });
    BaseApiResponse<QtyCheckResponse> baseApiResponse =
        BaseApiResponse.fromJson(qtyCheckResponse.data, fromJson: QtyCheckResponse.fromJson);
    return baseApiResponse.data ?? [];
  }
}
