import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business logic/bloc/bloc_crud_process_state.dart';
import '../../../sync/models/sync_group.dart';
import '../../../sync/models/sync_response.dart';
import '../../repo/db_repo/sync_action_repo/sync_action_db_repo.dart';

part 'sync_action_bloc_state.dart';

class SyncActionCubit extends Cubit<SyncActionState> {
  final SyncActionDBRepo _actionDBRepo;

  SyncActionCubit()
      : _actionDBRepo = SyncActionDBRepo(),
        super(SyncActionState(
            state: BlocCRUDProcessState.initial, actionGroupList: []));

  getSyncActionGroup() async {
    List<SyncActionGroup> groupList = await _actionDBRepo.getSyncActionGroups();
    emit(state.copyWith(actionGroupList: groupList));
  }

  getSyncAction({required bool isManualSync, String? groupName}) async {
    try {
      final startTime = DateTime.now();

      List<SyncResponse> actionList = await _actionDBRepo.getActionList(
          isManualSync: isManualSync, groupName: groupName);
      List<SyncActionGroup> syncActionGroupList =
          await _actionDBRepo.getSyncActionGroups();

      final endTime = DateTime.now();
      final elapsedTime = endTime.difference(startTime).inMilliseconds;
      print('Execution took $elapsedTime milliseconds');

      emit(state.copyWith(
        actionGroupList: syncActionGroupList,
        actionList: actionList,
        state: BlocCRUDProcessState.fetchSuccess,
      ));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }

  getActionListByGroupId(int gpId) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    List<SyncResponse> actionList =
        await _actionDBRepo.getActionListByGroup(gpId: gpId);

    List<SyncResponse> selectedList = [...actionList];
    emit(state.copyWith(
        state: BlocCRUDProcessState.fetchSuccess,
        actionList: actionList,
        selectedActionList: selectedList));
  }

  getActionListByGroupName({required String groupName}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    List<SyncResponse> actionList =
        await _actionDBRepo.getActionListByGroup(groupName: groupName);
    List<SyncResponse> selectedList = [...actionList];
    emit(state.copyWith(
        state: BlocCRUDProcessState.fetchSuccess,
        actionList: actionList,
        selectedActionList: selectedList));
  }

  selectAction(SyncResponse action) async {
    List<SyncResponse> selectedList = state.selectedActionList;
    int index = selectedList.indexWhere((element) => element.id == action.id);

    if (index > -1) {
      selectedList.removeAt(index);
    } else {
      selectedList.add(action);
    }
    emit(state.copyWith(selectedActionList: selectedList));
  }
}
