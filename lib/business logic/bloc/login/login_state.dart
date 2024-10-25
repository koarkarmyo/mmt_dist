part of 'login_bloc.dart';

enum LoginStatus { initial, loading, fail, success }

class LoginState {
  LoginStatus status;
  String? error;

  LoginState({required this.status, this.error});

  LoginState copyWith({LoginStatus? status, String? error}) {
    return LoginState(
        status: status ?? this.status, error: error ?? this.error);
  }
}
