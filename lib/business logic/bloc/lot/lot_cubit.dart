import 'package:bloc/bloc.dart';
import 'package:mmt_mobile/api/api_repo/lot_api_repo.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';

import '../../../model/lot.dart';

part 'lot_state.dart';

class LotCubit extends Cubit<LotState> {
  LotCubit()
      : super(LotState(lotList: [], state: BlocCRUDProcessState.initial));

  fetchLot() async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<Lot> lotList = await LotApiRepo.instance.fetchLotList();
      emit(state.copyWith(
          lotList: lotList, state: BlocCRUDProcessState.fetchSuccess));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }
}
