part of 'product_category_cubit.dart';

class ProductCategoryState {
  BlocCRUDProcessState state;
  List<Category> productCategoryList;

  ProductCategoryState(
      {required this.state, required this.productCategoryList});

  ProductCategoryState copyWith(
      {BlocCRUDProcessState? state, List<Category>? productCategoryList}) {
    return ProductCategoryState(
        state: state ?? this.state,
        productCategoryList: productCategoryList ?? this.productCategoryList);
  }
}
