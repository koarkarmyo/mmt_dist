part of 'dashboard_cubit.dart';

class DashboardState {
  BlocCRUDProcessState state;
  List<Dashboard> dashboardList;

  DashboardState({required this.state, required this.dashboardList});

  DashboardState copyWith(
      {BlocCRUDProcessState? state, List<Dashboard>? dashboardList}) {
    return DashboardState(
        state: state ?? this.state,
        dashboardList: dashboardList ?? this.dashboardList);
  }
}
