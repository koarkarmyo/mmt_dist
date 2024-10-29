part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {}

class CustomerFetchEvent extends CustomerEvent {
  final Map<String, dynamic> queries;

  CustomerFetchEvent(this.queries);
}

class CustomerFetchAllEvent extends CustomerEvent {}

//
class CustomerFilterByTeleSale extends CustomerEvent {
  final CustomerFilterType customerFilterType;

  CustomerFilterByTeleSale({
    required this.customerFilterType,
  });
}

class CustomerCreateEvent extends CustomerEvent {
  final Partner customer;

  CustomerCreateEvent(this.customer);
}

class CustomerUpdateEvent extends CustomerEvent {
  final Partner customer;

  CustomerUpdateEvent(this.customer);
}

class CustomerDeleteEvent extends CustomerEvent {
  final Partner customer;

  CustomerDeleteEvent(this.customer);
}

class CustomerFilterByNameEvent extends CustomerEvent {
  final String name;

  CustomerFilterByNameEvent({
    required this.name,
  });
}

class CustomerFilterEvent extends CustomerEvent {
  final String searchName;
  final CustomerFilterType customerTypeId;
  final int routeId;

  CustomerFilterEvent(
      {required this.searchName,
      required this.customerTypeId,
      required this.routeId});
}

class CustomerFilterByRouteEvent extends CustomerEvent {
  final String searchName;
  final CustomerFilterType customerTypeId;
  final String date;

  CustomerFilterByRouteEvent(
      {required this.searchName,
      required this.customerTypeId,
      required this.date});
}
