part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UserLoginEvent extends LoginEvent {
  final String username;
  final String password;
  final String database;

  UserLoginEvent(
      {required this.username, required this.password, required this.database});
}
class EmployeeLoginEvent extends LoginEvent {
  final String username;
  final String password;

  EmployeeLoginEvent({required this.username, required this.password});
}

class LoginSessionCheckEvent extends LoginEvent {}
