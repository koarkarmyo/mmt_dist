part of 'cart_cubit.dart';

class CartState {
  List<SaleOrderLine> itemList;
  List<SaleOrderLine> focItemList;
  List<SaleOrderLine> couponList;

  CartState(
      {required this.itemList,
      required this.focItemList,
      required this.couponList});

  CartState copyWith({
    List<SaleOrderLine>? itemList,
    List<SaleOrderLine>? focItemList,
    List<SaleOrderLine>? couponList,
  }) {
    return CartState(
        itemList: itemList ?? this.itemList,
        focItemList: focItemList ?? this.focItemList,
        couponList: couponList ?? this.couponList);
  }
}
