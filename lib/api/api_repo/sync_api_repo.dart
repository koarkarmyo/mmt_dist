import 'package:dio/dio.dart';

import '../../model/base_api_response.dart';
import '../../model/sync_response.dart';
import '../api_request.dart';
import '../base_api_repo.dart';


class SyncApiRepo extends BaseApiRepo {
  Future<BaseApiResponse<SyncResponse>> getSyncBloc() async {
    final Map<String, dynamic> data =
        ApiRequest.createSyncAction(actionName: 'get_sync');
    // Response response = await ApiCall(ApiUtils.buildDio())
    //     .postMethodCall(path: '/post/', data: data);
    Response response =
    await postMethodCall(additionalPath: '/post/', params: data);
    return BaseApiResponse.fromJson(response.data, fromJson: SyncResponse.fromJson);
  }

  Future<Response> sendAction(String actionName) async {
    final data = await ApiRequest.createActionRequest(actionName);
    // print(data);
    // final response = await ApiCall(ApiUtils.buildDio())
    //     .postMethodCall(path: '/post/', data: data);
    Response response =
    await postMethodCall(additionalPath: '/post/', params: data);
    // print(response);
    return response;
  }
}
