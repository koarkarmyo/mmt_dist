part of 'location_cubit.dart';

class LocationState {
  BlocCRUDProcessState state;
  List<StockLocation> locationList;

  LocationState({required this.state, required this.locationList});

  LocationState copyWith(
      {BlocCRUDProcessState? state, List<StockLocation>? locationList}) {
    return LocationState(
        state: state ?? this.state,
        locationList: locationList ?? this.locationList);
  }
}
