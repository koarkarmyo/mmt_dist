import 'package:dio/dio.dart';
import 'package:mmt_mobile/model/base_api_response.dart';

import '../../model/stock_move.dart';
import '../base_api_repo.dart';

class BatchApiRepo extends BaseApiRepo {
  static final BatchApiRepo instance = BatchApiRepo._();

  BatchApiRepo._();

  Future<List<StockMove>> fetchBatchFromApi({required String name}) async {
    Response response = await postMethodCall(
        additionalPath: '/api/sync/', bodyData: {"name": name});

    BaseApiResponse<StockMove> baseApiResponse =
        BaseApiResponse<StockMove>.fromJson(response.data,
            fromJson: StockMove.fromJson);

    return baseApiResponse.data ?? [];
  }
}
