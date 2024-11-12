part of 'batch_cubit.dart';

class BatchState {
  BlocCRUDProcessState state;
  List<StockMove> stockMoveList;

  BatchState({required this.state, required this.stockMoveList});

  BatchState copyWith(
      {BlocCRUDProcessState? state, List<StockMove>? stockMoveList}) {
    return BatchState(
        state: state ?? this.state,
        stockMoveList: stockMoveList ?? this.stockMoveList);
  }
}
