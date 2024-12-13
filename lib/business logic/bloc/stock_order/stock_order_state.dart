part of 'stock_order_bloc.dart';

class StockOrderState {
  final BlocCRUDProcessState state;
  final List<StockOrderLine> stockOrderLineList;
  StockLocation? location;
  String? error;

  StockOrderState({
    required this.state,
    required this.stockOrderLineList,
    this.location,
    this.error,
  });

  StockOrderState copyWith({
    BlocCRUDProcessState? state,
    List<StockOrderLine>? stockOrderLineList,
    String? error,
    StockLocation? location
  }) {
    return StockOrderState(
      state: state ?? this.state,
      stockOrderLineList:
      stockOrderLineList ?? this.stockOrderLineList,
      error: error ?? this.error,
      location: location ?? this.location
    );
  }
}
