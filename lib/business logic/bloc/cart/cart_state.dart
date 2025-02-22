part of 'cart_cubit.dart';

class CartState {
  List<SaleOrderLine> itemList;
  List<SaleOrderLine> focItemList;
  List<SaleOrderLine> couponList;
  List<SaleOrderLine> discItemList;
  BlocCRUDProcessState state;

  CartState(
      {required this.state,
      required this.itemList,
      required this.focItemList,
      required this.discItemList,
      required this.couponList});

  CartState copyWith(
      {List<SaleOrderLine>? itemList,
      List<SaleOrderLine>? focItemList,
      List<SaleOrderLine>? couponList,
      List<SaleOrderLine>? discItemList,
      BlocCRUDProcessState? state}) {
    return CartState(
        state: state ?? this.state,
        itemList: itemList ?? this.itemList,
        focItemList: focItemList ?? this.focItemList,
        discItemList: discItemList ?? this.discItemList,
        couponList: couponList ?? this.couponList);
  }

  @override
  String toString() {
    return 'CartState{itemList: $itemList, focItemList: $focItemList, couponList: $couponList, state: $state}';
  }
}
