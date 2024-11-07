import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import '../../../model/delivery/delivery_item.dart';
import '../../../model/sale_order/sale_order_line.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(itemList: [], focItemList: [], couponList: []));

  void addCartSaleItem({required SaleOrderLine saleItem}) {
    print("Cart Add : ${saleItem.toJson()}");

    int index = state.itemList.indexWhere(
      (element) => element.productId == saleItem.productId,
    );

    if (index > -1) {
      state.itemList[index] = saleItem;
    } else {
      state.itemList.add(saleItem);
    }

    print("Add Sale Item");

    emit(state.copyWith(itemList: state.itemList));
  }

  void addCartFocItem({required SaleOrderLine focItem}) {
    int index = state.focItemList.indexWhere(
      (element) => element.productId == focItem.productId,
    );

    if (index > -1) {
      state.focItemList[index] = focItem;
    } else {
      state.focItemList.add(focItem);
    }

    print("Add Foc Item");


    emit(state.copyWith(focItemList: state.focItemList));
  }

  void removeFocItem({required int productId}) {
    int index = state.focItemList.indexWhere(
      (element) => element.productId == productId,
    );

    if (index >= 0) {
      state.focItemList.removeAt(index);
    }

    emit(state.copyWith(focItemList: state.focItemList));
  }

  void addCartCouponItem({required SaleOrderLine focItem}) {
    int index = state.couponList.indexWhere(
          (element) => element.productId == focItem.productId,
    );

    if (index > -1) {
      state.couponList[index] = focItem;
    } else {
      state.couponList.add(focItem);
    }

    emit(state.copyWith(couponList: state.couponList));
  }

  void removeCouponItem({required int productId}) {
    int index = state.couponList.indexWhere(
          (element) => element.productId == productId,
    );

    if (index >= 0) {
      state.couponList.removeAt(index);
    }

    emit(state.copyWith(couponList: state.couponList));
  }
}
