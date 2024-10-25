import 'package:dio/dio.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../exception/admin_login_require_exception.dart';
import '../exception/login_fail_exception.dart';
import '../model/readable_api_error.dart';


class ApiErrorHandler {
  static const String internetError = 'internet connection error';
  static const int errorCode = 0;

  static ReadableApiError createReadableErrorMessage(Exception exception) {
    String message = 'Json error!';
    int errorCode = 500;
    try {
      if (exception is OdooException) {
        // OdooErrorResponse errorResponse = _getErrorResponse(exception.message);
        message = exception.message.substring(0, 100);
        errorCode = 400;
      } else if (exception is OdooSessionExpiredException) {
        message = exception.message.substring(0, 100);
        errorCode = 201;
      } else if (exception is AdminLoginRequireException) {
        message = exception.message.substring(0, 100);
        errorCode = 401;
      } else if (exception is LoginFailException) {
        message = exception.message;
        errorCode = 404;
      } else if (exception is LoginFailException) {
        message = exception.message;
        errorCode = 404;
      } else if (exception is DioException) {
        errorCode = exception.response?.statusCode ?? 0;
        if (exception.response?.statusCode == 422) {
          message = exception.response?.data['error'] ?? 'Field required!';
          errorCode = errorCode;
        } else if (exception.response?.statusCode == 404) {
          message = exception.response?.data['error'] ?? 'Not found';
          errorCode = errorCode;
        } else if (exception.response?.statusCode == 400) {
          message =
              exception.response?.data['error'] ?? 'Backend error $errorCode';
          errorCode = errorCode;
        } else if (exception.response?.statusCode == 500) {
          message = 'Backend error';
          errorCode = errorCode;
        }
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.receiveTimeout ||
            exception.type == DioExceptionType.connectionTimeout) {
          message = 'Check internet connection';
          errorCode = 0;
        }
      }
    } catch (e) {
      message = 'Something was wrong';
      errorCode = 0;
    }

    return ReadableApiError(message: message, errorCode: errorCode);
  }

// static OdooErrorResponse _getErrorResponse(String jsonString) {
//   // final something = json.decode(jsonString);
//   OdooErrorResponse odooErrorResponse =
//       OdooErrorResponse.fromJson(jsonString);
//   return odooErrorResponse;
// }
}

// class ApiErrorHandler {
//   static const String _message = 'message';
//
//   static Map<String, String> createError(Object e) {
//     if (e is DioException) {
//       if (e.type == DioExceptionType.badResponse) {
//         if (e.response?.statusCode == 400) {
//           try {
//             Map<String, dynamic> error = e.response?.data['error'];
//             dynamic type = error.values.first;
//             if (type.runtimeType == String) {
//               return {_message: type};
//             }
//           } catch (e) {
//             debugPrint(e.toString());
//           }
//           return {_message: 'bad request'};
//         }
//         if (e.response?.statusCode == 422) {
//           Map<String, String> entryError = {};
//           Map<String, dynamic> errors = e.response?.data['error'];
//           for (MapEntry mapEntry in errors.entries) {
//             var valueList = mapEntry.value.toList();
//             entryError.putIfAbsent(mapEntry.key, () => valueList[0]);
//           }
//           return entryError;
//         }
//         if (e.response?.statusCode == 404) {
//           return {_message: ConstantStrings.notFound.showPreferLanguage};
//         }
//         if (e.response?.statusCode == 403) {
//           return {_message: ConstantStrings.forbidden.showPreferLanguage};
//         }
//         if (e.response?.statusCode == 500) {
//           return {_message: ConstantStrings.serverError.showPreferLanguage};
//         }
//       } else if (e.type == DioExceptionType.connectionError ||
//           e.type == DioExceptionType.sendTimeout) {
//         return {_message: ConstantStrings.connectTimeOut};
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         return {_message: ConstantStrings.receiveTimeOut.showPreferLanguage};
//       }
//
//       if (e.type == DioExceptionType.unknown) {
//         if (e.error is SocketException) {
//           return {_message: ConstantStrings.connectionError.showPreferLanguage};
//         }
//       }
//
//       return {_message: 'Backend Error!'};
//     } else {
//       return {_message: e.toString()};
//     }
//   }
// }
