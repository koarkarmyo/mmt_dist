part of 'batch_cubit.dart';

class BatchState {
  BlocCRUDProcessState state;
  List<StockMoveLine> stockMoveList;
  List<StockMoveLine>? stockMoveWithTotalList;

  BatchState(
      {required this.state,
      required this.stockMoveList,
      this.stockMoveWithTotalList});

  BatchState copyWith(
      {BlocCRUDProcessState? state,
      List<StockMoveLine>? stockMoveList,
      List<StockMoveLine>? stockMoveWithTotalList}) {
    return BatchState(
        state: state ?? this.state,
        stockMoveList: stockMoveList ?? this.stockMoveList,
        stockMoveWithTotalList:
            stockMoveWithTotalList ?? this.stockMoveWithTotalList);
  }
}
