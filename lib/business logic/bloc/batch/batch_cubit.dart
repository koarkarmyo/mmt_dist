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

part 'batch_state.dart';

class BatchCubit extends Cubit<BatchState> {
  BatchCubit()
      : super(
            BatchState(state: BlocCRUDProcessState.initial, stockMoveList: []));

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

      stockMoveWithTotalQty.forEachIndexed(
        (index, stockMove) {
          Product? product = productList
              .firstWhereOrNull((element) => element.id == stockMove.productId);
          if (product != null) {
            stockMoveWithTotalQty[index].data = [];
            MMTApplication.uomLongFormChanger(
                    refTotal: stockMove.productUomQty ?? 0,
                    uomList: product.uomLines ?? [])
                .forEach((qtyUom) => stockMoveWithTotalQty[index].data?.add(
                      StockMoveData(
                          qty: qtyUom['qty'],
                          productUomId: qtyUom['product_uom_id'],
                          productUomName: qtyUom['product_uom_name']),
                    ));
          }
        },
      );

      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          stockMoveList: stockMoveList,
          stockMoveWithTotalList: stockMoveWithTotalQty));
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
            stockMove.qtyDone = stockMove.productUomQty;
            stockMoveList.add(stockMove);
          } else {
            productLotList.forEach(
              (element) {
                StockMoveLine stockMoveLine = stockMove.copyWith();
                UomLine? uomLine = uomList.firstWhereOrNull(
                  (uom) => uom.uomId == element.productUomId,
                );
                if (element.id != productLotList.first.id) {
                  stockMoveLine.moveId = null;
                  print("not first item : assign null");
                }
                stockMoveLine.lotId = element.id;
                stockMoveLine.lotName = element.name;
                double qty = 0;
                if (uomLine?.uomType == UomType.bigger.name) {
                  qty = (element.productQty ?? 0) * (uomLine?.ratio ?? 0);
                } else {
                  qty = (element.productQty ?? 0) / (uomLine?.ratio ?? 0);
                }

                stockMoveLine.qtyDone = qty;
                stockMoveList.add(stockMoveLine);
                stockMoveList.forEach(
                  (element) {
                    print(
                        "stock move list ${stockMoveList.length} : ${element.toJson()}");
                  },
                );
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
