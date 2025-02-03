import 'package:bloc/bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/data_object.dart';
import 'package:mmt_mobile/model/stock_location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
      : super(LocationState(
            state: BlocCRUDProcessState.initial, locationList: []));

  getAllStockLocation() async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));

    try {
      List<StockLocation> locationList =
          await DataObject.instance.getStockLocationList();

      locationList = [
        StockLocation(
          name: "Warehouse"
        ),
        StockLocation(
          name: "9R/28482"
        ),
        StockLocation(
          name: "Location 1"
        )
      ];
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          locationList: locationList));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }
}
