class ReadableApiError {
  final String _message;
  final int _errorCode;

  const ReadableApiError({
    required String message,
    required int errorCode,
  })  : _message = message,
        _errorCode = errorCode;

  Map<String, dynamic> toMap() {
    return {
      'message': _message,
      'error_code': _errorCode,
    };
  }

  factory ReadableApiError.fromMap(Map<String, dynamic> map) {
    return ReadableApiError(
      message: map['message'],
      errorCode: map['error_code'],
    );
  }

  int get errorCode => _errorCode;

  String get message => _message;
}
