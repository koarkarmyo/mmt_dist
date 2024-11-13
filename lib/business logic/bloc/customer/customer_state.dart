part of 'customer_cubit.dart';

class CustomerState {
  List<ResPartner> customerList;

  BlocCRUDProcessState state;

  CustomerState({required this.customerList, required this.state});

  CustomerState copyWith(
      {List<ResPartner>? customerList, BlocCRUDProcessState? state}) {
    return CustomerState(
        customerList: customerList ?? this.customerList,
        state: state ?? this.state);
  }
}
