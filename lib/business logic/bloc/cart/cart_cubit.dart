import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:mmt_mobile/database/data_object.dart';
import 'package:mmt_mobile/database/db_repo/price_list_db_repo.dart';
import 'package:mmt_mobile/database/product_repo/product_db_repo.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:collection/collection.dart';

import '../../../database/db_repo/sale_order_db_repo.dart';
import '../../../model/price_list/price_list_item.dart';
import '../../../model/product/product_product.dart';
import '../../../model/product/uom_lines.dart';
import '../../../model/promotion.dart';
import '../../../model/sale_order/sale_order_6/sale_order.dart';
import '../../../model/sale_order/sale_order_line.dart';
import '../../../model/stock_picking/stock_picking_model.dart';
import '../../../src/mmt_application.dart';
import '../bloc_crud_process_state.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<ProductProduct> _productList = [];

  CartCubit()
      : super(CartState(
            state: BlocCRUDProcessState.initial,
            itemList: [],
            focItemList: [],
            couponList: [])) {
    ProductDBRepo.instance.getProductList().then((value) {
      _productList = value;
    });
  }

  List<PriceListItem> _priceListItems = [];

  void addCartSaleItem(
      {required SaleOrderLine saleItem, LooseBoxType? looseBoxType}) async {
    if (_priceListItems.isEmpty) {
      _priceListItems = await PriceListDbRepo.instance.getAllPriceList();
    }

    debugPrint("Cart Add : ${saleItem.toString()}");

    int index = state.itemList.indexWhere(
      (element) =>
          (element.productId == saleItem.productId) &&
          (element.autoKey == saleItem.autoKey),
    );

    debugPrint('Cart Position $index');

    saleItem = _calculatePrice(orderLine: saleItem, looseBoxType: looseBoxType);
    saleItem.saleType = SaleType.sale;

    if (index > -1) {
      state.itemList[index] = saleItem;
    } else {
      state.itemList.add(saleItem);
    }

    debugPrint('Cart Size ${state.itemList.length}');
    List<SaleOrderLine> orderLines = state.itemList;

    emit(state.copyWith(
      itemList: orderLines,
      focItemList: _promotionAdd(orderLines),
      state: BlocCRUDProcessState.updateSuccess,
    ));
  }

  void addProductList(
      {required List<SaleOrderLine> list, LooseBoxType? looseBoxType}) async {
    if (_priceListItems.isEmpty) {
      _priceListItems = await PriceListDbRepo.instance.getAllPriceList();
    }

    list.forEach((saleItem) {
      debugPrint("Cart Add : ${saleItem.toJson()}");
      int index = state.itemList.indexWhere(
        (element) => element.productId == saleItem.productId,
      );
      saleItem =
          _calculatePrice(orderLine: saleItem, looseBoxType: looseBoxType);
      saleItem.saleType = SaleType.sale;

      if (index > -1) {
        state.itemList[index] = saleItem;
      } else {
        state.itemList.add(saleItem);
      }
    });

    emit(state.copyWith(
      itemList: state.itemList,
      focItemList: _promotionAdd(state.itemList),
      state: BlocCRUDProcessState.updateSuccess,
    ));
  }

  void removeSaleItem({required int productId, required double? autoKey}) {
    int index = state.itemList.indexWhere(
      (element) =>
          (element.productId == productId) && (element.autoKey == autoKey),
    );

    if (index >= 0) {
      state.itemList.removeAt(index);
    }

    emit(state.copyWith(
      itemList: state.itemList,
      focItemList: _promotionAdd(state.itemList),
    ));
  }

  void addCartFocItem(
      {required SaleOrderLine focItem, LooseBoxType? looseBoxType}) async {
    debugPrint("FOC Item : ${focItem.toJson()}");

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

    debugPrint("Add Foc Item");

    emit(state.copyWith(focItemList: state.focItemList));
  }

  void removeFocItem({required int productId, required double? autoKey}) {
    int index = state.focItemList.indexWhere(
      (element) => element.productId == productId && element.autoKey == autoKey,
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
      //
      orderLine.priceUnit = price?.fixedPrice ?? 0;
      //
      debugPrint(
          "Single Item Price : ${orderLine.priceUnit} : Price List : ${_priceListItems.length} ");

      // orderLine.subTotal =
      //     (orderLine.productUomQty ?? 0) * (orderLine.singleItemPrice ?? 0);
    }

    double singleItemPriceWithDisc = (orderLine.priceUnit ?? 0) -
        ((orderLine.priceUnit ?? 0) * ((orderLine.discountPercent ?? 0) / 100));
    orderLine.priceUnit = singleItemPriceWithDisc;

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
    //
    state.itemList.forEach(
      (element) {
        if ((element.pcQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
            productUomQty: element.pcQty,
            priceUnit: element.priceUnit,
            uomLine: element.pcUomLine,
          );
          saleOrderLineList.add(saleOrderLine);
        }
        if ((element.pkQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              priceUnit: element.priceUnit,
              productUomQty: element.pkQty,
              uomLine: element.pkUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
      },
    );
    state.focItemList.forEach(
      (element) {
        // if ((element.pcQty ?? 0) > 0) {
        //   SaleOrderLine saleOrderLine = element.copyWith(
        //       priceUnit: element.priceUnit,
        //       productUomQty: element.pcQty,
        //       uomLine: element.pcUomLine);
        //   saleOrderLineList.add(saleOrderLine);
        // }
        // if ((element.pkQty ?? 0) > 0) {
        SaleOrderLine saleOrderLine = element.copyWith(
            priceUnit: element.priceUnit,
            productUomQty: element.pkQty,
            uomLine: element.pkUomLine);
        saleOrderLineList.add(saleOrderLine);
        // }
      },
    );

    state.couponList.forEach(
      (element) {
        if ((element.pcQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              priceUnit: element.priceUnit,
              productUomQty: element.pcQty,
              uomLine: element.pcUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
        if ((element.pkQty ?? 0) > 0) {
          SaleOrderLine saleOrderLine = element.copyWith(
              priceUnit: element.priceUnit,
              productUomQty: element.pkQty,
              uomLine: element.pkUomLine);
          saleOrderLineList.add(saleOrderLine);
        }
      },
    );

    bool success = await SaleOrderDBRepo.instance.saveSaleOrder(
        saleOrder: saleOrder, saleOrderLineList: saleOrderLineList);

    if (success) {
      emit(state.copyWith(state: BlocCRUDProcessState.createSuccess));
    } else {
      emit(state.copyWith(state: BlocCRUDProcessState.createFail));
    }
  }

  List<SaleOrderLine> _promotionAdd(List<SaleOrderLine> lines) {
    lines.removeWhere((element) => element.saleType == SaleType.foc);

    List<SaleOrderLine> cartOrderDetailLines = [];
    // cartOrderDetailLines.addAll(lines);
    List<RewardLine> rewardLines = [];
    lines.forEach((cart) {
      List<RewardLine> rewardds = MMTApplication.checkPromotionLines(
          MMTApplication.currentPromotions, cart.product!);

      List<RewardLine> tmpRewards = rewardds
          .where((element) => cart.totalRefQty >= (element.refQty ?? 0))
          .toList();
      if (tmpRewards.isNotEmpty) {
        tmpRewards.sort((a, b) => (b.refQty ?? 0).compareTo(a.refQty ?? 0));
        List<RewardLine> targetPromo = [];
        targetPromo.add(tmpRewards.first);

        // change to
        targetPromo.forEach((rew) {
          debugPrint('promotions:::: ${rew.productName}');
          debugPrint('promotions:::: ${rew.refQty}');
          debugPrint('promotions:::: ref cart ${cart.totalRefQty}');
          debugPrint('--------------------------');
          // List<UomLine> uomLines = cart.product.uomLines ?? [];
          // double refQty = MMTApplication.uomQtyToRefTotal(
          //     uomLines.firstWhere((uom) => uom.uomId == rew.uomId),
          //     rew.qty ?? 0.0);
          // debugPrint('rwward --- min qty ::: $refQty');
          debugPrint('rwward --- total ref cart ::: ${cart.totalRefQty}');
          // rew.refQty = refQty;
          rew.product = cart.product;

          if (cart.totalRefQty >= (rew.refQty ?? 0.0)) {
            double rewardQty = 0;
            if (rew.multiply ?? false) {
              final double disc = cart.totalRefQty / (rew.refQty ?? 0.0);
              // debugPrint('rwward --- rewws ::: ${cart.totalRefQty}');
              // debugPrint('rwward --- rewws ::: ${rew.refQty}');
              // debugPrint('rwward --- rewws ::: disc $disc');
              // debugPrint(
              //     'rwward --- rewws ::: ${disc.toInt() * (rew.rewardQty ?? 0)}');
              // rew.rewardQty = disc.toInt() * (rew.rewardQty ?? 0);
              rewardQty = disc.toInt() * (rew.rewardQty ?? 0);
            }
            rewardLines.add(rew.copyWith(rewardQty: rewardQty));
          }
          print('------------------------');
        });
      }
    });

    rewardLines.forEach((element) {
      // reward product add
      ProductProduct? rewProduct =
          _productList.firstWhereOrNull((p) => p.id == element.rewardProductId);
      if (rewProduct != null) {
        UomLine? uomLine = rewProduct.uomLines
            ?.firstWhereOrNull((uom) => uom.uomId == element.rewardUomId);
        if (uomLine != null) {
          SaleOrderLine detail = SaleOrderLine(
            productId: rewProduct.id,
            product: rewProduct,
            pkQty: element.rewardQty ?? 0,
            uomLine: rewProduct.uomLines
                ?.firstWhereOrNull((element) => element.uomId == element.uomId),
            pkUomLine: rewProduct.uomLines
                ?.firstWhereOrNull((element) => element.uomId == element.uomId),
            saleType: SaleType.foc,
            priceUnit: rewProduct.rewardPrice(uomLine),
            listPrice: rewProduct.rewardPrice(uomLine),
            productName: rewProduct.name,
            singlePKPrice: rewProduct.rewardPrice(uomLine),
            autoKey: DateTime.now().microsecondsSinceEpoch.toDouble(),
          );

          cartOrderDetailLines.add(detail);

          if (element.productId != null) {
            ProductProduct? product = _productList
                .firstWhereOrNull((p) => p.id == element.expenseProductId);

            debugPrint('rwward ::: expense Product ${product?.name}');
            if (product != null) {
              UomLine? expUom = product.uomLines?.firstWhereOrNull(
                  (element) => element.uomId == element.uomId);
              SaleOrderLine expanseProduct = SaleOrderLine(
                productId: product.id,
                product: product,
                pkQty: -1 * (element.rewardQty ?? 1),
                uomLine: rewProduct.uomLines?.firstWhereOrNull(
                    (element) => element.uomId == element.uomId),
                pkUomLine: expUom,
                saleType: SaleType.foc,
                priceUnit: detail.singlePKPrice,
                listPrice: product.standardPrice ?? 0.0,
                productName: product.name,
                singlePKPrice: detail.singlePKPrice,
                autoKey: DateTime.now().microsecondsSinceEpoch.toDouble(),
              );
              cartOrderDetailLines.add(expanseProduct);
            }
          }
        }
        //
        // if (uomLine != null) {
        //   detail.lPrice = rewProduct.rewardPrice(uomLine);
        //   detail.calculateSubtotal();
        // }
        //
      }
    });

    //
    return cartOrderDetailLines;
  }
}
