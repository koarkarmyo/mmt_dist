import 'package:dio/dio.dart';

import '../base_api_repo.dart';

class SyncApiRepo extends BaseApiRepo {
  static final SyncApiRepo _loginApiRepo = SyncApiRepo._();

  SyncApiRepo._();

  factory SyncApiRepo() {
    return _loginApiRepo;
  }

  Future<bool> syncApiRequest(
      {required String requestName, required String date}) async {
    try {
      Response response = await postApiMethodCall(
          additionalPath: "post/api", params: {'sync_action': requestName});
      // save in database
      return true;
    } on Exception {
      return false;
    }
  }
}
