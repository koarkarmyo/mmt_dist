import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/db_repo/sale_order_db_repo.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_6/sale_order.dart';

import '../../../../model/secondary_sale/secondary_sale_order.dart';

part 'secondary_sale_order_history_state.dart';

class SaleOrderHistoryCubit extends Cubit<SecondarySaleOrderHistoryState> {
  final SaleOrderDBRepo _orderDBRepo = SaleOrderDBRepo();

  SaleOrderHistoryCubit()
      : super(const SecondarySaleOrderHistoryState(
          saleOrderList: [],
          state: BlocCRUDProcessState.initial,
        ));

  fetch({String? so, String? customer, List<String>? fromToDate}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    // List<SaleOrder> list = await _orderDBRepo.fetchSaleOrder(
    //     so: so, customer: customer, fromToDate: fromToDate);
    emit(state.copyWith(
      state: BlocCRUDProcessState.fetching,
      saleOrderList: [],
    ));
  }
}
