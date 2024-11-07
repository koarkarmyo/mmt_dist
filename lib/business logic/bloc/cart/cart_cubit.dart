import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/database/db_repo/price_list_db_repo.dart';
import 'package:mmt_mobile/src/enum.dart';
import '../../../model/delivery/delivery_item.dart';
import '../../../model/price_list/price_list.dart';
import '../../../model/price_list/price_list_item.dart';
import '../../../model/sale_order/sale_order_line.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(itemList: [], focItemList: [], couponList: []));
  List<PriceListItem> _priceListItems = [];

  void addCartSaleItem(
      {required SaleOrderLine saleItem, LooseBoxType? looseBoxType}) async {
    if (_priceListItems.isEmpty) {
      _priceListItems = await PriceListDbRepo.instance.getAllPriceList();
    }

    print("Cart Add : ${saleItem.toJson()}");

    int index = state.itemList.indexWhere(
      (element) => element.productId == saleItem.productId,
    );

    saleItem = _calculatePrice(orderLine: saleItem);

    if (index > -1) {
      state.itemList[index] = saleItem;
    } else {
      state.itemList.add(saleItem);
    }

    print("Add Sale Item");

    emit(state.copyWith(itemList: state.itemList));
  }

  void addCartFocItem(
      {required SaleOrderLine focItem, LooseBoxType? looseBoxType}) async {
    int index = state.focItemList.indexWhere(
      (element) => element.productId == focItem.productId,
    );

    if (_priceListItems.isEmpty) {
      _priceListItems = await PriceListDbRepo.instance.getAllPriceList();
    }

    focItem = _calculatePrice(orderLine: focItem, looseBoxType: looseBoxType);

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

  void addCartCouponItem(
      {required SaleOrderLine coupon, LooseBoxType? looseBoxType}) async {
    if (_priceListItems.isEmpty) {
      _priceListItems = await PriceListDbRepo.instance.getAllPriceList();
    }

    int index = state.couponList.indexWhere(
      (element) => element.productId == coupon.productId,
    );

    coupon = _calculatePrice(orderLine: coupon, looseBoxType: looseBoxType);

    if (index > -1) {
      state.couponList[index] = coupon;
    } else {
      state.couponList.add(coupon);
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

  SaleOrderLine _calculatePrice(
      {required SaleOrderLine orderLine, LooseBoxType? looseBoxType}) {
    if (looseBoxType == LooseBoxType.pk) {
      print("This is pk type");
      PriceListItem? price = _priceListItems
          .where(
            (element) => element.productUomId == orderLine.pkUomLine?.uomId,
          )
          .firstOrNull;

      orderLine.singlePKPrice = price?.fixedPrice ?? 10;
      orderLine.subTotal =
          (orderLine.pkQty ?? 0) * (orderLine.singlePKPrice ?? 0);
    } else if (looseBoxType == LooseBoxType.pc) {
      PriceListItem? price = _priceListItems
          .where(
            (element) => element.productUomId == orderLine.pcUomLine?.uomId,
          )
          .firstOrNull;

      orderLine.singlePCPrice = price?.fixedPrice ?? 5;
      orderLine.subTotal =
          (orderLine.pcQty ?? 0) * (orderLine.singlePCPrice ?? 0);
    } else {
      PriceListItem? price = _priceListItems
          .where(
            (element) => element.productUomId == orderLine.pcUomLine?.uomId,
          )
          .firstOrNull;
      orderLine.singleItemPrice = price?.fixedPrice ?? 5;
      orderLine.subTotal =
          (orderLine.productUomQty ?? 0) * (orderLine.singleItemPrice ?? 0);
    }

    return orderLine;
  }
}
