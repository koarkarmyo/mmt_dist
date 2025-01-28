import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/db_repo/dashboard_db_repo.dart';

import '../../../model/dashboard.dart';
import '../../../sync/repo/api_repo/sync_api_repo.dart';
import '../../../sync/sync_utils/sync_utils.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
      : super(DashboardState(
            state: BlocCRUDProcessState.initial, dashboardList: []));

  Future<void> getDashboard() async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<Dashboard> dashboardList =
          await DashboardDBRepo.instance.getAllDashboard();

      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          dashboardList: dashboardList));
    } on Exception {
      emit(state
          .copyWith(state: BlocCRUDProcessState.fetchFail, dashboardList: []));
    }
  }

  Future<void> fetchDashboardFromApi() async {
    try {
      emit(state.copyWith(state: BlocCRUDProcessState.fetching));
      Response response =
          await SyncApiRepo().sendAction('get_dashboard', limit: 100);
      SyncProcess syncProcess = await SyncUtils.insertToDatabase(
          actionName: 'get_dashboard', response: response);
      List<Dashboard> dashboards =
          await DashboardDBRepo.instance.getAllDashboard();
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess, dashboardList: dashboards));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }
}
