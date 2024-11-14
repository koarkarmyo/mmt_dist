part of 'product_cubit.dart';

class ProductState {
  BlocCRUDProcessState state;
  List<Product> productList;
  List<Product> filterProductList;
  Product? product;

  ProductState(
      {required this.state,
      required this.productList,
      required this.filterProductList,
      this.product});

  ProductState copyWith(
      {BlocCRUDProcessState? state,
      List<Product>? productList,
      List<Product>? filterProductList,
      Product? product}) {
    return ProductState(
        state: state ?? this.state,
        productList: productList ?? this.productList,
        filterProductList: filterProductList ?? this.filterProductList,
        product: product ?? this.product);
  }
}
