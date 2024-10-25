import 'package:dio/dio.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../src/mmt_application.dart';
import 'dio_interceptor.dart';

class BaseApiRepo {
  // late OdooClient _client;
  late Dio _dio;
  late Stream<OdooSession> _listenSessionChange;
  final String jsonRpc = '/jsonrpc';
  final String createMethod = 'create';
  final String searchRead = 'search_r ead';
  final String executeMethod = 'execute';

  BaseApiRepo() {
    // _client = OdooClient(MMTApplication.serverUrl, MMTApplication.session);
    _dio = Dio(
      BaseOptions(
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
        baseUrl: MMTApplication.serverUrl,
        connectTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));
    dio.interceptors.add(DioInterceptor());
    // _listenSessionChange = client.sessionStream;
  }

  Dio get dio => _dio;

  // OdooClient get client => _client;

  Stream<OdooSession> get listenSessionChange => _listenSessionChange;

  Future<Response> createApiRequest(
      {String? additionalPath, Map<String, dynamic>? params}) {
    return dio.post(MMTApplication.serverUrl + (additionalPath ?? ''), data: params);
  }

  Future<Response> postMethodCall(
      {String? additionalPath, Map<String, dynamic>? params}) {
    return dio.post(MMTApplication.serverUrl + (additionalPath ?? ''),
        data: {'jsonrpc': '2.0', 'method': 'call', 'params': params});
  }

  Future<Response> postApiMethodCall(
      {String? additionalPath, Map<String, dynamic>? params}) async {
    return await dio.post(MMTApplication.serverUrl + (additionalPath ?? ''),
        data: params);
  }

  Future<Response> getApiMethodCall({String? additionalPath}) async {
    return await _dio.get(MMTApplication.serverUrl + (additionalPath ?? ''));
  }

  Map<String, dynamic> createOneToManyApiRequest({List? args, dynamic kwargs}) {
    return {
      "service": "object",
      "method": "execute",
      'args': args ?? [],
      'kwargs': kwargs ?? {},
    };
  }

  Map<String, dynamic> createKwArgs(
      {List<List<String>>? domain,
      List<String>? fields,
      int? limit,
      Map<String, dynamic>? context}) {
    return {
      'context': context,
      "domain": domain,
      'fields': fields,
      'limit': limit
    };
  }

  Future<Response<dynamic>> retryApiRequest(RequestOptions requestOptions) {
    // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    // Retry the request with the new `RequestOptions` object.
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
