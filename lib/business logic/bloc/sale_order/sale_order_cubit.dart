import 'package:bloc/bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/db_repo/sale_order_db_repo.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';

import '../../../model/sale_order/sale_order_6/sale_order.dart';

part 'sale_order_state.dart';

class SaleOrderCubit extends Cubit<SaleOrderState> {
  SaleOrderCubit()
      : super(SaleOrderState(
            saleOrderLineList: [], state: BlocCRUDProcessState.initial));

  Future<void> saveSaleOrder(
      {required SaleOrder saleOrder,
      required List<SaleOrderLine> saleOrderLineList}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.creating));
    bool success = await SaleOrderDBRepo.instance.saveSaleOrder(
        saleOrder: saleOrder, saleOrderLineList: saleOrderLineList);

    if (success) {
      emit(state.copyWith(state: BlocCRUDProcessState.createSuccess));
    } else {
      emit(state.copyWith(state: BlocCRUDProcessState.createFail));
    }
  }
}
