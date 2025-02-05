part of 'sale_order_history_cubit.dart';

@immutable
final class SaleOrderHistoryState {
  final List<SaleOrder> saleOrderList;
  final BlocCRUDProcessState state;
  final String? error;

  const SaleOrderHistoryState({
    required this.saleOrderList,
    required this.state,
    this.error,
  });

  SaleOrderHistoryState copyWith({
    List<SaleOrder>? saleOrderList,
    BlocCRUDProcessState? state,
    String? error,
  }) {
    return SaleOrderHistoryState(
      saleOrderList: saleOrderList ?? this.saleOrderList,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }
}
