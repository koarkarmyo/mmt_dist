part of 'customer_create_update_bloc.dart';

@immutable
abstract class CustomerCreateUpdateEvent {}

class CustomerCreateEvent extends CustomerCreateUpdateEvent {
  final Partner customer;

  CustomerCreateEvent(this.customer);
}

class CustomerUpdateEvent extends CustomerCreateUpdateEvent {
  final Partner customer;

  CustomerUpdateEvent(this.customer);
}
