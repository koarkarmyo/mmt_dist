class LoginFailException implements Exception {
  String message;

  LoginFailException(this.message);

  @override
  String toString() => 'Login fail : $message';
}
