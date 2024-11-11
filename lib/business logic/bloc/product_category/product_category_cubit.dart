import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/database/db_repo/product_category_db_repo.dart';

import '../../../model/category.dart';

part 'product_category_state.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  ProductCategoryCubit()
      : super(ProductCategoryState(
            state: BlocCRUDProcessState.initial, productCategoryList: []));

  getProductCategory() async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    try {
      List<Category> productCategoryList =
          await ProductCategoryDBRepo.instance.getProductCategory();
      emit(state.copyWith(
          state: BlocCRUDProcessState.fetchSuccess,
          productCategoryList: productCategoryList));
    } on Exception {
      emit(state.copyWith(state: BlocCRUDProcessState.fetchFail));
    }
  }
}
