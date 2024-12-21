part of 'cust_visit_cubit.dart';

class CustVisitState {
  BlocCRUDProcessState state;

  CustVisitState({required this.state});

  CustVisitState copyWith({BlocCRUDProcessState? state}) {
    return CustVisitState(state: state ?? this.state);
  }
}
