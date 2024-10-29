part of 'customer_create_update_bloc.dart';

@immutable
abstract class CustomerCreateUpdateState {}

class CustomerCreateUpdateInitial extends CustomerCreateUpdateState {}

class CustomerCreatingUpdatingState extends CustomerCreateUpdateState {}

class CustomerCreateUpdateSuccess extends CustomerCreateUpdateState {
  final Partner customer;

  CustomerCreateUpdateSuccess(this.customer);
}

class CustomerCreateUpdateFail extends CustomerCreateUpdateState {
  final Map<String, String> errors;

  CustomerCreateUpdateFail(this.errors);
}
