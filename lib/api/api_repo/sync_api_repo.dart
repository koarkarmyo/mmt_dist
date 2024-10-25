import 'package:dio/dio.dart';

import '../api_request.dart';
import '../base_api_repo.dart';


class SyncApiRepo extends BaseApiRepo {
  Future<BaseApiResponse<SyncResponse>> getSyncBloc() async {
    final Map<String, dynamic> data =
        ApiRequest.createSyncAction(actionName: 'get_sync');
    // Response response = await ApiCall(ApiUtils.buildDio())
    //     .postMethodCall(path: '/post/', data: data);
    Response response =
        await apiCall.postMethodCall(path: '/post/', data: data);
    return BaseApiResponse.fromJson(response.data);
  }

  Future<Response> sendAction(String actionName) async {
    final data = await ApiRequest.createActionRequest(actionName);
    // print(data);
    // final response = await ApiCall(ApiUtils.buildDio())
    //     .postMethodCall(path: '/post/', data: data);
    Response response =
        await apiCall.postMethodCall(path: '/post/', data: data);
    // print(response);
    return response;
  }
}
