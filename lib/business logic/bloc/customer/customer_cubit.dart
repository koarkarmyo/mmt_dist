import 'package:bloc/bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/db_repo/res_partner_repo.dart';

import '../../../model/res_partner.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit()
      : super(CustomerState(
            customerList: [], state: BlocCRUDProcessState.initial));

  fetchCustomers({String? name}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<ResPartner> customerList =
          await ResPartnerRepo.instance.getResPartner(name: name);
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          customerList: customerList));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }

  updateCustomerProfile() async {
    emit(state.copyWith(state: BlocCRUDProcessState.updating));
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(state: BlocCRUDProcessState.updateSuccess));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.updateFail));
    }
  }
}
