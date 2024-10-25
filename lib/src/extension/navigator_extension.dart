import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> pushTo<T>({required String route, Map<String, dynamic>? args}) {
    return Navigator.pushNamed<T>(this, route,arguments: args);
  }

  Future<T?> push<T>({required Route<T> route}) {
    return Navigator.push(this, route);
  }

  Future<Map<String, dynamic>?> pushReplace(
      {required String route, Map<String, dynamic>? args}) {
    return Navigator.pushReplacementNamed(this, route, arguments: args);
  }

  void pop<T>([T? result]) {
    return Navigator.pop<T>(this, result);
  }

  Future<bool> mayBePop<T>([T? result]) {
    return Navigator.maybePop(this, result);
  }
}

extension SnackBarCustom on BuildContext {
  void showErrorSnackBar(String error) {
    SnackBar snackBar = SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
