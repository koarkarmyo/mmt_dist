part of 'secondary_sale_order_history_cubit.dart';

@immutable
final class SecondarySaleOrderHistoryState {
  final List<SecondarySaleOrder> saleOrderList;
  final BlocCRUDProcessState state;
  final String? error;

  const SecondarySaleOrderHistoryState({
    required this.saleOrderList,
    required this.state,
    this.error,
  });

  SecondarySaleOrderHistoryState copyWith({
    List<SecondarySaleOrder>? saleOrderList,
    BlocCRUDProcessState? state,
    String? error,
  }) {
    return SecondarySaleOrderHistoryState(
      saleOrderList: saleOrderList ?? this.saleOrderList,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }
}
