part of 'customer_bloc.dart';

class CustomerState extends Equatable {
  final List<Partner> customers;
  final BlocCRUDProcessState state;
  final Map<String, String> errors;

  CustomerState(
      {required this.customers, required this.state, required this.errors});

  CustomerState copyWith({
    BlocCRUDProcessState? state,
    List<Partner>? customers,
    String? currentRouteId,
    String? currentRouteName,
    Map<String, String>? errors,
  }) {
    return CustomerState(
      state: state ?? this.state,
      customers: customers ?? this.customers,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [this.customers, this.state];
}
