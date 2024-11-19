import 'package:dio/dio.dart';
import 'package:mmt_mobile/model/base_api_response.dart';

import '../../model/stock_move.dart';
import '../base_api_repo.dart';

class BatchApiRepo extends BaseApiRepo {
  static final BatchApiRepo instance = BatchApiRepo._();

  BatchApiRepo._();

  Future<List<StockMoveLine>> fetchBatchFromApi({required String name}) async {
    Response response = await postMethodCall(
        additionalPath: '/batch/', bodyData: {"name": name});

    BaseApiResponse<StockMoveLine> baseApiResponse =
        BaseApiResponse<StockMoveLine>.fromJson(response.data,
            fromJson: StockMoveLine.fromJson);

    return baseApiResponse.data ?? [];
  }

  Future<bool> loadBatch(
      {required List<StockMoveLine> stockMoveLineList}) async {
    List<Map<String, dynamic>> data = [];

    stockMoveLineList.forEach(
      (element) {
        // print("Stock Move : ${element.toJson()}");
        data.add(element.toJson());
      },
    );

    Response response = await postApiMethodCall(
        additionalPath: '/save_loading/',
        params: {"name": "move_line_ids", "args": data});

    return response.statusCode == 200;
  }
}
