part of 'batch_cubit.dart';

class BatchState {
  BlocCRUDProcessState state;
  List<StockMoveLine> stockMoveList;

  BatchState({required this.state, required this.stockMoveList});

  BatchState copyWith(
      {BlocCRUDProcessState? state, List<StockMoveLine>? stockMoveList}) {
    return BatchState(
        state: state ?? this.state,
        stockMoveList: stockMoveList ?? this.stockMoveList);
  }
}
