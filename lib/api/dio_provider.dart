// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import '../../../src/mmt_application.dart';
//
// class DioProvider {
//   // Singleton pattern to provide a single Dio instance
//   static final DioProvider _singleton = DioProvider._internal();
//
//   factory DioProvider() {
//     return _singleton;
//   }
//
//   DioProvider._internal() {
//     _dio = Dio(
//       BaseOptions(
//         headers: {
//           'Cookie' : 'session_id=${MMTApplication.session?.sessionId}'
//         },
//         responseType: ResponseType.json,
//         contentType: Headers.jsonContentType,
//         baseUrl: MMTApplication.serverUrl,
//         connectTimeout: const Duration(minutes: 2),
//         sendTimeout: const Duration(minutes: 2),
//         receiveTimeout: const Duration(minutes: 2),
//       ),
//     );
//     dio.interceptors.add(PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: true,
//       compact: false,
//     ));
//     // Optionally configure Dio here
//   }
//
//   late Dio _dio;
//
//   Dio get dio => _dio;
//
//   void updateDioOptions(BaseOptions options) {
//     _dio.options = options;
//   }
//
//   void addInterceptor(Interceptor interceptor) {
//     _dio.interceptors.add(interceptor);
//   }
// }