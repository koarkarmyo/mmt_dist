import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api/api_error_handler.dart';
import '../../../api/api_repo/qty_balance_api_repo.dart';
import '../../../api/api_repo/stock_order_api_repo.dart';
import '../../../database/db_repo/stock_order_product_db_repo.dart';
import '../../../exception/require_obj_missing_exception.dart';
import '../../../model/qty_check_response.dart';
import '../../../model/stock_location.dart';
import '../../../model/stock_order.dart';
import '../../../utils/sale_order_utils.dart';
import '../bloc_crud_process_state.dart';

part 'stock_order_event.dart';
part 'stock_order_state.dart';

class StockOrderBloc extends Bloc<StockOrderEvent, StockOrderState> {
  final StockOrderDBRepo _orderDBRepo;
  final StockOrderApiRepo _orderApiRepo;

  StockOrderBloc()
      : _orderDBRepo = StockOrderDBRepo(),
        _orderApiRepo = StockOrderApiRepo(),
        super(StockOrderState(
            state: BlocCRUDProcessState.initial, stockOrderLineList: [])) {
    on<StockOrderLineAddEvent>(_orderProductAddProcess);
    on<StockOrderLineUpdateEvent>(_orderProductUpdateProcess);
    // on<StockOrderSendEvent>(_orderSendProcess);
    on<StockOrderResetEvent>(_orderResetProcess);
    on<StockOrderAddBalanceQty>(_addOrderCartBalanceQty);
    on<StockOrderLocationUpdateEvent>(_changeLocationProcess);
  }

  _orderProductAddProcess(
      StockOrderLineAddEvent event, Emitter<StockOrderState> emit) async {
    // emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    List<StockOrderLine> stockOrderLines = state.stockOrderLineList;

    try {
      int index = -1;
      index = stockOrderLines.indexWhere((element) {
        print('xxxxxxxxx or ${event.stockOrderLine.index}');
        print('xxxxxxxxx el ${element.index}');
        return element.productId == event.stockOrderLine.productId;
      });
      if (index > -1) {
        stockOrderLines.removeAt(index);
      } else {
        if (event.stockOrderLine.product == null)
          throw RequireObjMissingException(message: 'Missing product object');
        if (event.stockOrderLine.product!.getRefUom() == null) {
          throw RequireObjMissingException(message: 'Missing RefUomLine');
        }

        // state.stockOrderLineList.add(event.stockOrderLine);
        StockOrderLine stockOrderLine = event.stockOrderLine.copyWith(
            productName: event.stockOrderLine.productName,
            boxUomId: event.stockOrderLine.product!.getRefUom()!.uomId!,
            productUomName:
                event.stockOrderLine.product!.getRefUom()?.uomName ?? '',
            productUom: event.stockOrderLine.product!.getRefUom()!.uomId!);
        stockOrderLines.add(stockOrderLine);
      }
      // bool isSuccess = await _orderDBRepo.addStockLine(event.stockOrderLine);

      // List<StockOrderLine> orderLines = await _orderDBRepo.getStockOrderLines();

      print("Stock Order Line : ${stockOrderLines.length}");

      emit(state.copyWith(
          state: BlocCRUDProcessState.initial,
          stockOrderLineList: stockOrderLines));
    } catch (e) {
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchFail,
          error: 'Something was wrong!'));
    }
  }

  _changeLocationProcess(StockOrderLocationUpdateEvent event, Emitter<StockOrderState> emit){
  emit(state.copyWith(location: event.location ));
  }

  _orderProductUpdateProcess(
      StockOrderLineUpdateEvent event, Emitter<StockOrderState> emit) async {
    try {
      int index = -1;

      index = state.stockOrderLineList.indexWhere(
          (element) => element.productId == event.stockOrderLine.productId);

      state.stockOrderLineList[index] = event.stockOrderLine;

      emit(state.copyWith(
          state: BlocCRUDProcessState.initial,
          stockOrderLineList: state.stockOrderLineList));
    } catch (e) {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }

  _addOrderCartBalanceQty(
      StockOrderAddBalanceQty event, Emitter<StockOrderState> emit) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<int> productIds = [];
      List<QtyCheckResponse> qtyBalanceList = [];

      event.stockOrderLineList
          .forEach((orderCart) => productIds.add(orderCart.productId ?? 0));

      qtyBalanceList = await QtyBalanceApiRepo().getBalanceQty(productIds);

      List<StockOrderLine> cartOrderDetailList = [];
      await Future.forEach<StockOrderLine>(event.stockOrderLineList,
          (orderCart) async {
        QtyCheckResponse? qtyCheckResponse = qtyBalanceList
            .firstWhereOrNull((element) => element.id == orderCart.productId);

        //TODO: add qtyAvailable
        StockOrderLine? detail = event.editCardDetailList?.firstWhereOrNull(
            (element) => element.productId == orderCart.productId);
        double qty = (qtyCheckResponse?.qtyAvailable ?? 0.0) +
            (detail?.totalRefQty ?? 0);
        //, product: orderCart.product?.copyWith(refQty: qty)
        StockOrderLine _cardOrderAfterCheck =
            orderCart.copyWith(balanceQty: qty);

        _cardOrderAfterCheck.balanceQtyRefString =
            await SaleOrderUtils.refQtyToLBString(
                _cardOrderAfterCheck.productId ?? 0,
                _cardOrderAfterCheck.balanceQty ?? 0);

        //ချိန်းပြီးသားစျေးတွေ reset မဖြစ်စေဖို့

        cartOrderDetailList.add(_cardOrderAfterCheck);
      });

      emit(state.copyWith(
          stockOrderLineList: cartOrderDetailList,
          state: BlocCRUDProcessState.createSuccess));
    } on DioError catch (error) {
      Map<String, String> responseError = ApiErrorHandler.createError(error);
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchFail,
          error: responseError.values.first));
    } catch (e) {
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchFail, error: e.toString()));
    }
  }

  // _orderSendProcess(
  //     StockOrderSendEvent event, Emitter<StockOrderState> emit) async {
  //   emit(state.copyWith(state: BlocCRUDProcessState.fetching));
  //   List<StockOrderLine> stockOrderLines = [];
  //   String orderNo = '';
  //
  //   try {
  //     String docNo = await NoSeriesGenerator.generateNoSeries(
  //         docType: NoSeriesDocType.stock_order);
  //     orderNo = docNo;
  //
  //     StockOrder stockOrder = StockOrder(
  //       employeeId: MMTApplication.loginResponse!.id,
  //       name: orderNo,
  //       employeeName: MMTApplication.loginResponse?.name ?? '',
  //       requestLocationId: MMTApplication.loginResponse?.currentLocationId ?? 0,
  //       requestLocationName:
  //           MMTApplication.loginResponse?.currentLocationName ?? '',
  //       writeDate: DateTime.now().toString(),
  //       date: DateTimeUtils.yMmDdHMS.format(DateTime.now()),
  //       remark: event.remark,
  //     );
  //
  //     await Future.forEach<StockOrderLine>(state.stockOrderLineList,
  //         (stockOrderLine) async {
  //       // int uomId;
  //       // if (!MMTApplication.loginResponse!.deviceId!.useLooseUom!) {
  //       // uomId = stockOrderLine.productUom!;
  //       // }
  //
  //       StockOrderLine forApiStockOrderLine;
  //       if (MMTApplication.isLooseBoxUom) {
  //         double totalRefQty = 0;
  //
  //         if (stockOrderLine.product == null)
  //           throw RequireObjMissingException(
  //               message:
  //                   '${stockOrderLine.productName} missing product object');
  //
  //         UomLine? boxUomLine =
  //             MMTApplication.getBoxUomLine(stockOrderLine.product!);
  //
  //         if (boxUomLine != null)
  //           totalRefQty += MMTApplication.uomQtyToRefTotal(
  //               boxUomLine, stockOrderLine.bQty ?? 0);
  //         UomLine? lUomLine =
  //             MMTApplication.getLUomLine(stockOrderLine.product!);
  //         if (lUomLine != null)
  //           totalRefQty += MMTApplication.uomQtyToRefTotal(
  //               lUomLine, stockOrderLine.lQty ?? 0);
  //
  //         forApiStockOrderLine = StockOrderLine(
  //           productId: stockOrderLine.productId,
  //           totalRefQty: totalRefQty,
  //           productName: stockOrderLine.productName,
  //           productUom: stockOrderLine.productUom,
  //           product: stockOrderLine.product,
  //           balanceQty: stockOrderLine.balanceQty,
  //           totalUom: stockOrderLine.totalUom,
  //           productUomName: stockOrderLine.productUomName,
  //         );
  //       } else {
  //         UomLine? looseUomLine = stockOrderLine.product?.uomLines
  //             ?.firstWhereOrNull(
  //                 (element) => element.uomId == stockOrderLine.boxUomId);
  //         double totalRefQty = MMTApplication.uomQtyToRefTotal(
  //             looseUomLine!, stockOrderLine.bQty ?? 0);
  //
  //         UomLine? uomLine = MMTApplication.getReferenceUomLine(
  //             stockOrderLine.product?.uomLines ?? []);
  //
  //         forApiStockOrderLine = StockOrderLine(
  //           productId: stockOrderLine.productId,
  //           totalRefQty: totalRefQty,
  //           productName: stockOrderLine.productName,
  //           productUom: uomLine?.uomId,
  //           product: stockOrderLine.product,
  //           balanceQty: stockOrderLine.balanceQty,
  //           totalUom: uomLine?.uomName,
  //           productUomName: uomLine?.uomName,
  //         );
  //       }
  //       // double qty = await totalRefQty(
  //       //     stockOrderLine.productId!,
  //       //     stockOrderLine.bQty!,
  //       //     stockOrderLine.lQty!,
  //       //     stockOrderLine.looseUomId ?? stockOrderLine.boxUomId,
  //       //     stockOrderLine.boxUomId!);
  //
  //       stockOrderLines.add(forApiStockOrderLine);
  //     });
  //
  //     stockOrder.stockOrderLine = stockOrderLines;
  //     int orderId =
  //         await _orderApiRepo.sendOrderToApi(stockOrder, event.locationId);
  //     stockOrder.id = orderId;
  //     stockOrderLines.forEach((element) {
  //       element.orderId = orderId;
  //       element.id = orderId;
  //     });
  //
  //     await NoSeriesGenerator.updateNoSeries(NoSeriesDocType.stock_order);
  //
  //     await _orderDBRepo.insertStockOrder(stockOrder);
  //     await _orderDBRepo.insertStockOrderLines(stockOrderLines);
  //
  //     emit(state.copyWith(
  //         state: BlocCRUDProcessState.fetchSuccess, stockOrderLineList: []));
  //   } on DioError catch (e) {
  //     emit(state.copyWith(
  //         state: BlocCRUDProcessState.fetchFail,
  //         error: ApiErrorHandler.createError(e).values.first));
  //   } on Exception catch (e) {
  //     if (e is RequireObjMissingException) {
  //       emit(state.copyWith(
  //           state: BlocCRUDProcessState.fetchFail, error: e.message));
  //     } else
  //       emit(state.copyWith(
  //           state: BlocCRUDProcessState.fetchFail, error: e.toString()));
  //   }
  // }

  _orderResetProcess(
      StockOrderResetEvent event, Emitter<StockOrderState> emit) async {
    emit(state
        .copyWith(state: BlocCRUDProcessState.initial, stockOrderLineList: []));
  }
}
