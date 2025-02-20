part of 'stock_loading_cubit.dart';

class StockLoadingState {
  BlocCRUDProcessState state;
  List<StockMoveLine> stockMoveList;
  List<StockMoveLine> stockMoveWithTotalList;

  StockLoadingState(
      {required this.state,
      required this.stockMoveList,
     required this.stockMoveWithTotalList});

  StockLoadingState copyWith(
      {BlocCRUDProcessState? state,
      List<StockMoveLine>? stockMoveList,
      List<StockMoveLine>? stockMoveWithTotalList}) {
    return StockLoadingState(
        state: state ?? this.state,
        stockMoveList: stockMoveList ?? this.stockMoveList,
        stockMoveWithTotalList:
            stockMoveWithTotalList ?? this.stockMoveWithTotalList);
  }

  @override
  String toString() {
    return 'StockLoadingState{state: ${state.name}, stockMoveList: $stockMoveList, stockMoveWithTotalList: $stockMoveWithTotalList}';
  }
}
