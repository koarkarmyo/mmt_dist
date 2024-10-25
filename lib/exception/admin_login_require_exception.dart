class AdminLoginRequireException implements Exception {
  String message;

  AdminLoginRequireException(this.message);

  @override
  String toString() => 'Admin login required : $message';
}
