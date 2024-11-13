import 'package:dio/dio.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:collection/collection.dart';

import '../../../api/api_request.dart';
import '../../../api/base_api_repo.dart';
import '../../../model/base_api_response.dart';
import '../../models/sync_response.dart';

class SyncApiRepo extends BaseApiRepo {
  Future<BaseApiResponse<SyncResponse>> getSyncBloc() async {
    final Map<String, dynamic> data =
        ApiRequest.createSyncAction(actionName: 'get_sync');
    // Response response = await ApiCall(ApiUtils.buildDio())
    //     .postMethodCall(path: '/post/', data: data);
    Response response =
        await postMethodCall(additionalPath: '/api/sync/', params: data);
    return BaseApiResponse.fromJson(response.data,
        fromJson: SyncResponse.fromJson);
  }

  Future<Response> sendAction(String actionName,
      {bool isUpload = false, int? limit}) async {
    bool isUploadedData = true;

    if (isUpload) {
      isUploadedData = false;
      UploadBeforeSync? syncAction = UploadBeforeSync.values.firstWhereOrNull(
        (element) => element.name == actionName,
      );

      if (syncAction != null) {
        isUploadedData = await syncAction.uploadRequest ;
      }
    }

    final data = await ApiRequest.createActionRequest(actionName, limit: limit);
    Response response =
        await postMethodCall(additionalPath: '/api/sync/', bodyData: data);
    // print(response);
    return response;
  }
}
