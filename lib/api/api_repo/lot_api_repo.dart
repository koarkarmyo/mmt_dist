import 'package:dio/dio.dart';
import 'package:mmt_mobile/api/base_api_repo.dart';
import 'package:mmt_mobile/model/base_api_response.dart';

import '../../model/lot.dart';

class LotApiRepo extends BaseApiRepo {
  static final LotApiRepo instance = LotApiRepo._();

  LotApiRepo._();

  Future<List<Lot>> fetchLotList() async {
    Response response = await getApiMethodCall(additionalPath: '/lot_list');
    BaseApiResponse<Lot> baseApiResponse =
        BaseApiResponse.fromJson(response.data, fromJson: Lot.fromJson);

    return baseApiResponse.data ?? [];
  }
}
