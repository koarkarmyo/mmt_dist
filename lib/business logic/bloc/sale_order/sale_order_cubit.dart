import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';

part 'sale_order_state.dart';

class SaleOrderCubit extends Cubit<SaleOrderState> {
  SaleOrderCubit() : super(SaleOrderState(
    saleOrderLineList: []
  ));
}
