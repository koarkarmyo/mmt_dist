import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mmt_mobile/database/db_repo/cust_visit_db_repo.dart';
import 'package:mmt_mobile/model/res_partner.dart';

import '../../../model/cust_visit.dart';
import '../../../src/mmt_application.dart';
import '../../../utils/date_time_utils.dart';
import '../bloc_crud_process_state.dart';

part 'cust_visit_state.dart';

class CustVisitCubit extends Cubit<CustVisitState> {
  CustVisitCubit() : super(CustVisitState(state: BlocCRUDProcessState.initial));

  saveCustVisit(
      {required ResPartner customer, required CustVisitTypes type}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.creating));
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ));

      debugPrint("Position : ${position.latitude} : ${position.longitude}");

      CustVisit custVisit = CustVisit(
          customerId: customer.id,
          docDate: DateTimeUtils.yMmDdHMS.format(DateTime.now()),
          docType: type,
          employeeId: MMTApplication.currentUser?.id ?? 0,
          vehicleId: MMTApplication.currentUser?.defaultLocationId ?? 0,
          remarks: '',
          fromDelivery: false,
          isUpload: 0,
          deviceId: 0,
          latitude: position.latitude,
          longitude: position.longitude);

      bool value =
          await CustVisitDBRepo.instance.saveCustVisit(custVisit: custVisit);
      if (value == true) {
        emit(state.copyWith(state: BlocCRUDProcessState.createSuccess));
      } else {
        emit(state.copyWith(state: BlocCRUDProcessState.createFail));
      }
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.createFail));
    }
  }
}
