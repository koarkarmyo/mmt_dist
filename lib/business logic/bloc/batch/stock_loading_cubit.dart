import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/api/api_repo/batch_api_repo.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:collection/collection.dart';
import 'package:mmt_mobile/database/product_repo/product_db_repo.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../../model/lot.dart';
import '../../../model/product/product.dart';
import '../../../model/product/uom_lines.dart';
import '../../../model/stock_move.dart';
import '../../../src/enum.dart';

part 'stock_loading_state.dart';

class StockLoadingCubit extends Cubit<StockLoadingState> {
  StockLoadingCubit()
      : super(StockLoadingState(
            state: BlocCRUDProcessState.initial,
            stockMoveList: [],
            stockMoveWithTotalList: []));

  editStockMoveLineList(
      {required List<StockMoveLine> stockMoveLineList}) async {
    emit(state.copyWith(stockMoveWithTotalList: stockMoveLineList));
  }

  fetchBatchByBarcode({required String barcode}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<StockMoveLine> stockMoveList =
          await BatchApiRepo.instance.fetchBatchFromApi(name: barcode);

      List<StockMoveLine> stockMoveWithTotalQty = [];
      List<Product> productList = await ProductDBRepo.instance.getProductList();

      stockMoveList.forEach(
        (element) {
          if (!stockMoveWithTotalQty
              .map(
                (e) => e.productId,
              )
              .contains(element.productId)) {
            stockMoveWithTotalQty.add(element);
          } else {
            int index = stockMoveWithTotalQty.indexWhere(
              (newStockMove) => newStockMove.productId == element.productId,
            );
            if (index != -1) {
              stockMoveWithTotalQty[index].productUomQty =
                  (stockMoveWithTotalQty[index].productUomQty ?? 0) +
                      (element.productUomQty ?? 0);
            }
          }
        },
      );

      List<StockMoveLine> stockMoveWithEachUomQty = [];

      stockMoveWithTotalQty.forEachIndexed(
        (index, stockMove) {
          Product? product = productList
              .firstWhereOrNull((element) => element.id == stockMove.productId);
          if (product != null) {
            MMTApplication.uomLongFormChanger(
                    refTotal: stockMove.productUomQty ?? 0,
                    uomList: product.uomLines ?? [])
                .forEach(
              (element) {
                stockMoveWithEachUomQty.add(stockMove.copyWith(
                    productUomId: element['product_uom_id'],
                    productUomName: element['product_uom_name'],
                    productUomQty: element['qty']));
              },
            );

            // stockMoveWithTotalQty[index].data = [];
            // MMTApplication.uomLongFormChanger(
            //         refTotal: stockMove.productUomQty ?? 0,
            //         uomList: product.uomLines ?? [])
            //     .forEach((qtyUom) =>
            //
            //     stockMoveWithTotalQty[index].data?.add(
            //           StockMoveData(
            //               qty: qtyUom['qty'],
            //               productUomId: qtyUom['product_uom_id'],
            //               productUomName: qtyUom['product_uom_name']),
            //         ));
          }
        },
      );

      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          stockMoveList: stockMoveList,
          stockMoveWithTotalList: stockMoveWithEachUomQty));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    } on Error {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }

  uploadDoneQty(
      {required List<StockMoveLine> stockMoveList,
      required List<Lot> lotList,
      required List<Product> productList}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.updating));
    // stockMoveList.forEach((element) => print("Cubit Stock Move : ${element.toJson()}"),);
    try {
      List<StockMoveLine> stockMoveList = [];

      state.stockMoveList.forEach(
        (stockMove) {
          // print("stock move : ${stockMove.toJson()}");
          List<UomLine> uomList = productList
                  .firstWhereOrNull(
                    (element) => element.id == stockMove.productId,
                  )
                  ?.uomLines ??
              [];
          List<Lot> productLotList = lotList
              .where(
                (e) => e.productId == stockMove.productId,
              )
              .toList();
          if (productLotList.isEmpty) {
            // // stockMove.qtyDone = stockMove.qtyDone;
            // int index = stockMoveList.indexWhere(
            //   (element) => element.id == stockMove.id,
            // );
            // if (index != -1) {
            //   stockMoveList[index].qtyDone =
            //       (stockMoveList[index].qtyDone ?? 0) +
            //           (stockMove.qtyDone ?? 0);
            // } else {
            //   stockMoveList.add(stockMove);
            // }
            Product? product = productList.firstWhereOrNull(
              (element) => element.id == stockMove.productId,
            );
            List<StockMoveLine> stockMoveLineListWithDifUom =
                state.stockMoveWithTotalList
                    .where(
                      (element) => element.moveId == stockMove.moveId && element.productId == stockMove.productId,
                    )
                    .toList();
            stockMoveLineListWithDifUom.forEach(
              (element) {
                print("stock move with");
                UomLine? uomLine = product?.uomLines?.firstWhereOrNull(
                  (uom) => uom.uomId == element.productUomId,
                );
                if (uomLine != null) {
                  stockMove.qtyDone = (stockMove.qtyDone ?? 0) +  MMTApplication.uomQtyToRefTotal(
                      uomLine, element.qtyDone ?? 0);
                }
              },
            );
            stockMoveList.add(stockMove);

            print("Without Lot : ${stockMove.toJson()}");
          } else {
            int index = 0;
            productLotList.forEach(
              (element) {
                int lotIndex = stockMoveList.indexWhere(
                  (stockMove) =>
                      stockMove.lotId == element.id &&
                      stockMove.productId == element.productId,
                );
                UomLine? uomLine = uomList.firstWhereOrNull(
                  (uom) => uom.uomId == element.productUomId,
                );
                if (lotIndex != -1 && uomLine != null) {
                  double doneQty = MMTApplication.uomQtyToRefTotal(
                      uomLine, element.productQty ?? 0);
                  stockMoveList[lotIndex].productUomQty =
                      (stockMoveList[lotIndex].productUomQty ?? 0) + doneQty;
                  stockMoveList[lotIndex].qtyDone =
                      (stockMoveList[lotIndex].qtyDone ?? 0) + doneQty;
                } else {
                  StockMoveLine stockMoveLine = stockMove.copyWith();

                  if (index != 0) {
                    stockMoveLine.id = null;
                    print("not first item : assign null");
                  } else {
                    print("first item !!!");
                  }
                  stockMoveLine.lotId = element.id;
                  stockMoveLine.lotName = element.name;

                  double qty = 0;
                  if (uomLine != null) {
                    qty = MMTApplication.uomQtyToRefTotal(
                        uomLine, element.productQty ?? 0);
                  }

                  stockMoveLine.productUomQty = qty;
                  stockMoveLine.qtyDone = qty;
                  stockMoveList.add(stockMoveLine);
                }
                index = index + 1;
              },
            );
          }
        },
      );

      bool success = await BatchApiRepo.instance
          .loadBatch(stockMoveLineList: stockMoveList);

      emit(state.copyWith(state: BlocCRUDProcessState.updateSuccess));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.updateFail));
    }
  }
}
