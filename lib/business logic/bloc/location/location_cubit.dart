import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/model/stock_location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
      : super(LocationState(
            state: BlocCRUDProcessState.initial, locationList: []));


}
