import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/api/api_repo/batch_api_repo.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';

import '../../../model/stock_move.dart';

part 'batch_state.dart';

class BatchCubit extends Cubit<BatchState> {
  BatchCubit()
      : super(
            BatchState(state: BlocCRUDProcessState.initial, stockMoveList: []));

  fetchBatchByBarcode({required String barcode}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<StockMove> stockMoveList =
          await BatchApiRepo.instance.fetchBatchFromApi(name: barcode);
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          stockMoveList: stockMoveList));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }
}
