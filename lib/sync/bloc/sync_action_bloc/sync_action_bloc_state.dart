part of 'sync_action_bloc_cubit.dart';

class SyncActionState {
  final BlocCRUDProcessState state;
  final List<SyncActionGroup> actionGroupList;
  final List<SyncResponse> actionList;
  final List<SyncResponse> selectedActionList;
  String? error;

  SyncActionState({
    required this.state,
    required this.actionGroupList,
    List<SyncResponse>? actionList,
    List<SyncResponse>? selectedActionList,
    this.error,
  })  : selectedActionList = selectedActionList ?? [],
        actionList = actionList ?? [];

  SyncActionState copyWith({
    final BlocCRUDProcessState? state,
    List<SyncActionGroup>? actionGroupList,
    final List<SyncResponse>? actionList,
    final List<SyncResponse>? selectedActionList,
    String? error,
  }) {
    return SyncActionState(
      state: state ?? this.state,
      actionGroupList: actionGroupList ?? this.actionGroupList,
      actionList: actionList ?? this.actionList,
      selectedActionList: selectedActionList ?? this.selectedActionList,
      error: error ?? this.error,
    );
  }
}
