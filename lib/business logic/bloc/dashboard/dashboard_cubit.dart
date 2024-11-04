import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/database_helper.dart';
import 'package:mmt_mobile/database/db_repo/dashboard_db_repo.dart';

import '../../../model/dashboard.dart';

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
}
