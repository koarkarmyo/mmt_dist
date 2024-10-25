class AutoSyncResponse {
  final bool isAutoSync;
  final String name;
  final bool isFinished;
  final String message;
  final String error;
  final double progress;

  const AutoSyncResponse({
    required this.isAutoSync,
    required this.name,
    required this.isFinished,
    required this.message,
    required this.error,
    required this.progress,
  });

  Map<String, dynamic> toJson() {
    return {
      'isAutoSync': isAutoSync,
      'name': name,
      'isFinished': isFinished,
      'message': message,
      'error': error,
      'progress': progress,
    };
  }

  factory AutoSyncResponse.fromJson(Map<String, dynamic> map) {
    return AutoSyncResponse(
      isAutoSync: map['isAutoSync'] as bool,
      name: map['name'] as String,
      isFinished: map['isFinished'] as bool,
      message: map['message'] as String,
      error: map['error'] as String,
      progress: map['progress'] as double,
    );
  }
}