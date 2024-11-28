import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import 'package:mmt_mobile/database/db_repo/price_list_db_repo.dart';
import 'package:mmt_mobile/src/enum.dart';
import '../../../database/db_repo/sale_order_db_repo.dart';
import '../../../model/delivery/delivery_item.dart';
import '../../../model/price_list/price_list.dart';
import '../../../model/price_list/price_list_item.dart';
import '../../../model/sale_order/sale_order_6/sale_order.dart';
import '../../../model/sale_order/sale_order_line.dart';
import '../../../model/stock_picking/stock_picking_model.dart';
import '../bloc_crud_process_state.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(CartState(
            state: BlocCRUDProcessState.initial,
            itemList: [],
            focItemList: [],
            couponList: []));
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

    saleItem = _calculatePrice(orderLine: saleItem, looseBoxType: looseBoxType);
    saleItem.saleType = SaleType.sale;

    if (index > -1) {
      state.itemList[index] = saleItem;
    } else {
      state.itemList.add(saleItem);
    }

    print("Add Sale Item");

    emit(state.copyWith(itemList: state.itemList));
  }

  void removeSaleItem({required int productId}) {
    int index = state.itemList.indexWhere(
      (element) => element.productId == productId,
    );

    if (index >= 0) {
      state.itemList.removeAt(index);
    }

    emit(state.copyWith(itemList: state.itemList));
  }

  void addCartFocItem(
      {required SaleOrderLine focItem, LooseBoxType? looseBoxType}) async {
    print("FOC Item : ${focItem.toJson()}");

    int index = state.focItemList.indexWhere(
      (element) => element.productId == focItem.productId,
    );

    if (_priceListItems.isEmpty) {
      _priceListItems = await PriceListDbRepo.instance.getAllPriceList();
    }

    focItem = _calculatePrice(orderLine: focItem, looseBoxType: looseBoxType);
    focItem.saleType = SaleType.foc;

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
    coupon.saleType = SaleType.coupon;

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
      PriceListItem? price = _priceListItems
          .where(
            (element) =>
                element.productUom == orderLine.pkUomLine?.uomId &&
                    element.productTmplId == orderLine.productId,
          )
          .firstOrNull;

      orderLine.singlePKPrice = price?.fixedPrice ?? 0;
      // orderLine.subTotal =
      //     (orderLine.pkQty ?? 0) * (orderLine.singlePKPrice ?? 0);
    } else if (looseBoxType == LooseBoxType.pc) {
      PriceListItem? price = _priceListItems
          .where(
            (element) =>
                element.productUom == orderLine.pcUomLine?.uomId &&
                    element.productTmplId == orderLine.productId,
          )
          .firstOrNull;

      print("Single PC Price : ${orderLine.singlePCPrice}");

      orderLine.singlePCPrice = price?.fixedPrice ?? 0;
    } else {
      PriceListItem? price = _priceListItems
          .where(
            (element) =>
                (element.productUom == orderLine.uomLine?.uomId) &&
                (element.productTmplId == orderLine.productId),
          )
          .firstOrNull;
      orderLine.singleItemPrice = price?.fixedPrice ?? 0;

      print(
          "Single Item Price : ${orderLine.singleItemPrice} : Price List : ${_priceListItems.length} ");

      // orderLine.subTotal =
      //     (orderLine.productUomQty ?? 0) * (orderLine.singleItemPrice ?? 0);
    }

    double singleItemPriceWithDisc = (orderLine.singleItemPrice ?? 0) - ((orderLine.singleItemPrice ?? 0) * ((orderLine.discountPercent ?? 0) / 100));

    orderLine.subTotal =
        (orderLine.pkQty ?? 0) * (orderLine.singlePKPrice ?? 0) +
            (orderLine.pcQty ?? 0) * (orderLine.singlePCPrice ?? 0) +
            (orderLine.productUomQty ?? 0) * (singleItemPriceWithDisc);

    // orderLine.subTotal = (orderLine.subTotal ?? 0) - ((orderLine.subTotal ?? 0) * ((orderLine.discountPercent ?? 0) / 100));

    return orderLine;
  }

  Future<void> saveSaleOrder({required SaleOrder saleOrder}) async {
    emit(state.copyWith(state: BlocCRUDProcessState.creating));
    List<SaleOrderLine> saleOrderLineList = [];
    saleOrderLineList.addAll(state.itemList);
    // saleOrderLineList.addAll(state.focItemList);
    // saleOrderLineList.addAll(state.couponList);
    state.itemList.forEach(
      (element) {
        if ((element.pcQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              productUomQty: element.pcQty, uomLine: element.pcUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
        if ((element.pkQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              productUomQty: element.pkQty, uomLine: element.pkUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
      },
    );
    state.focItemList.forEach(
      (element) {
        if ((element.pcQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              productUomQty: element.pcQty, uomLine: element.pcUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
        if ((element.pkQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              productUomQty: element.pkQty, uomLine: element.pkUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
      },
    );

    state.couponList.forEach(
      (element) {
        if ((element.pcQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              productUomQty: element.pcQty, uomLine: element.pcUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
        if ((element.pkQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              productUomQty: element.pkQty, uomLine: element.pkUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
      },
    );
    bool success = await SaleOrderDbRepo.instance.saveSaleOrder(
        saleOrder: saleOrder, saleOrderLineList: saleOrderLineList);

    if (success) {
      emit(state.copyWith(state: BlocCRUDProcessState.createSuccess));
    } else {
      emit(state.copyWith(state: BlocCRUDProcessState.createFail));
    }
  }
}
