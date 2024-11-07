part of 'product_cubit.dart';

class ProductState {
  BlocCRUDProcessState state;
  List<Product> productList;
  List<Product> filterProductList;

  ProductState(
      {required this.state,
      required this.productList,
      required this.filterProductList});

  ProductState copyWith(
      {BlocCRUDProcessState? state,
      List<Product>? productList,
      List<Product>? filterProductList}) {
    return ProductState(
        state: state ?? this.state,
        productList: productList ?? this.productList,
        filterProductList: filterProductList ?? this.filterProductList);
  }
}
