import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/product_repo/product_db_repo.dart';

import '../../../model/product/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit()
      : super(ProductState(
            state: BlocCRUDProcessState.initial,
            productList: [],
            filterProductList: []));

  Future<void> getAllProduct() async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching, productList: []));

    try {
      List<Product> productList = await ProductDBRepo.instance.getProductList();
      productList.forEach((element) => print("Product fetch : ${element.toJson()}"),);
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          productList: productList,
          filterProductList: productList));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }

  Future<void> searchProduct(
      {String? text, String? categoryName, String? barcode}) async {
    if (text != null) {
      List<Product> filterProductList = state.productList
          .where((element) =>
              (element.categName == (categoryName ?? element.categName)))
          .toList();

      print("Categ : $categoryName : ${filterProductList.length}");

      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          filterProductList: filterProductList
              .where((element) =>
                  (element.name?.toLowerCase().contains(text.toLowerCase()) ??
                      true))
              .toList()));
    } else {
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          filterProductList: state.productList
              .where((element) =>
                  (element.categName == (categoryName ?? element.categName)) &&
                  (element.barcode == (barcode ?? element.barcode)))
              .toList()));
    }
  }
}
