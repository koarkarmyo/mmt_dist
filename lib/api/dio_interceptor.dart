import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../share_preference/sh_keys.dart';
import '../share_preference/sh_utils.dart';
import '../src/mmt_application.dart';
import 'api_repo/login_api_repo.dart';
import 'base_api_repo.dart';

class DioInterceptor extends Interceptor {
  final SharePrefUtils sharePrefUtils = SharePrefUtils();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Cookie'] =
        'session_id=${MMTApplication.session?.sessionId}';
    debugPrint('headers:::::${options.headers.toString()}');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    super.onError(err, handler);
    if (err.response?.statusCode == 100) {
      await _refreshToken();
      try {
        handler
            .resolve(await BaseApiRepo().retryApiRequest(err.requestOptions));
      } on DioException catch (e) {
        // If the request fails again, pass the error to the next interceptor in the chain.
        handler.next(e);
      }
      // Return to prevent the next interceptor in the chain from being executed.
      return;
    }
  }

  Future<void> _refreshToken() async {
    String? name = await sharePrefUtils.getString(ShKeys.username);
    String? password = await sharePrefUtils.getString(ShKeys.password);
    String? database = await sharePrefUtils.getString(ShKeys.loginDatabase);

    if (name != null && password != null && database != null) {
      throw Exception;
    } else {
      await LoginApiRepo()
          .loginProcess(name: name!, password: password!, db: database!);
    }
  }
}
