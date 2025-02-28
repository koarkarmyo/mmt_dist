import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../business logic/bloc/cart/cart_cubit.dart';
import '../../business logic/bloc/product/product_cubit.dart';
import '../../common_widget/text_widget.dart';
import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';
import '../../src/enum.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class DeliveryCouponPage extends StatefulWidget {
  const DeliveryCouponPage({super.key});

  @override
  State<DeliveryCouponPage> createState() => _DeliveryCouponPageState();
}

class _DeliveryCouponPageState extends State<DeliveryCouponPage> {
  // late CartCubit _cartCubit;
  late ProductCubit _productCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _cartCubit = context.read<CartCubit>();
    _productCubit = context.read<ProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(ConstString.coupon),
      ),
      body: Column(
        children: [_focItemListWidget()],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _focItemListWidget() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.productList.length,
          itemBuilder: (context, index) {
            Product product = state.productList[index];
            return _productItem(
              product: product,
            );
          },
        );
      },
    ).expanded();
  }

  Widget _productItem({required Product product}) {
    TextEditingController _qtyController = TextEditingController();
    TextEditingController _pkController = TextEditingController();
    TextEditingController _pcController = TextEditingController();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int index = state.couponList.indexWhere(
          (element) => element.productId == product.id,
        );
        if (index == -1) {
          return Container();
        } else {
          SaleOrderLine? deliveryItem = state.couponList[index];
          double number = deliveryItem.productUomQty ?? 0;
          double pkNumber = deliveryItem.pkQty ?? 0;
          double pcNumber = deliveryItem.pcQty ?? 0;
          _qtyController.text =
              (number % 1 == 0) ? number.toInt().toString() : number.toString();
          _pkController.text = (pkNumber % 1 == 0)
              ? pkNumber.toInt().toString()
              : pkNumber.toString();
          _pcController.text = (pcNumber % 1 == 0)
              ? pcNumber.toInt().toString()
              : pcNumber.toString();
          return Slidable(
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                    backgroundColor: AppColors.dangerColor,
                    onPressed: (context) {
                      // _cartCubit.removeCouponItem(productId: product.id ?? 0);
                    },
                    label: "Delete",
                    icon: Icons.delete)
              ]),
              child: ListTile(
                contentPadding: 10.horizontalPadding,
                // Adjust padding here

                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),

                title: Text(product.name ?? '').boldSize(16),
                subtitle: Text("K 10000, 23 Kg"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  // Minimize column height
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // Aligns widgets to the right
                  children: MMTApplication.currentUser?.useLooseBox ?? false
                      ? [
                          SizedBox(
                            width: 80, // Set a fixed width for the TextField
                            child: TextField(
                              enabled: false,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                _pkController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _pkController.text.length);
                              },
                              onTapOutside: (event) {
                                // Unfocus when tapping anywhere outside the TextField
                                FocusScope.of(context).unfocus();
                              },
                              autofocus: false,
                              controller: _pkController,
                              onChanged: (value) {
                                // _cartCubit.addCartCouponItem(
                                //     looseBoxType: LooseBoxType.pk,
                                //     coupon: deliveryItem.copyWith(
                                //       pkUomLine: UomLine(
                                //           uomId: product.boxUomId,
                                //           uomName: product.boxUomName),
                                //       pcUomLine: UomLine(
                                //           uomId: product.looseUomId,
                                //           uomName: product.looseUomName),
                                //       pkQty: (_pkController.text != '')
                                //           ? double.tryParse(_pkController.text)
                                //           : 0,
                                //     ));
                              },
                              decoration: const InputDecoration(
                                  isDense: true,
                                  // Reduces height of the TextField
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  border: OutlineInputBorder(),
                                  hintText: 'PK',
                                  label: Text("PK")),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 80, // Set a fixed width for the TextField
                            child: TextField(
                              enabled: false,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                _pcController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _pcController.text.length);
                              },
                              onTapOutside: (event) {
                                // Unfocus when tapping anywhere outside the TextField
                                FocusScope.of(context).unfocus();
                              },
                              autofocus: false,
                              controller: _pcController,
                              onChanged: (value) {
                                // _cartCubit.addCartCouponItem(
                                //     looseBoxType: LooseBoxType.pc,
                                //     coupon: deliveryItem.copyWith(
                                //       pkUomLine: UomLine(
                                //           uomId: product.boxUomId,
                                //           uomName: product.boxUomName),
                                //       pcUomLine: UomLine(
                                //           uomId: product.looseUomId,
                                //           uomName: product.looseUomName),
                                //       pcQty: (_pcController.text != '')
                                //           ? double.tryParse(_pcController.text)
                                //           : 0,
                                //     ));
                              },
                              decoration: const InputDecoration(
                                  isDense: true,
                                  // Reduces height of the TextField
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  border: OutlineInputBorder(),
                                  hintText: 'PC',
                                  label: Text("PC")),
                            ),
                          ),
                        ]
                      : [
                          SizedBox(
                            width: 80, // Set a fixed width for the TextField
                            child: TextField(
                              enabled: false,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                _qtyController.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _qtyController.text.length);
                              },
                              onTapOutside: (event) {
                                // Unfocus when tapping anywhere outside the TextField
                                FocusScope.of(context).unfocus();
                              },
                              autofocus: false,
                              controller: _qtyController,
                              onChanged: (value) {
                                // _cartCubit.addCartFocItem(
                                //     focItem: SaleOrderLine(
                                //         productId: product.id,
                                //         productName: product.name,
                                //         productUomQty:
                                //             (_qtyController.text != '')
                                //                 ? double.tryParse(
                                //                     _qtyController.text)
                                //                 : 0,
                                //         uomLine: product.uomLines?.first));
                              },
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                isDense:
                                    true, // Reduces height of the TextField
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                border: OutlineInputBorder(),
                                hintText: 'Qty',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Spacing between TextField and Dropdown
                          Container(
                            padding: 7.allPadding,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: 4.borderRadius),
                            child: DropdownButton<UomLine>(
                              value: deliveryItem?.uomLine ??
                                  product.uomLines?.first,
                              items: product.uomLines
                                  ?.map((UomLine value) =>
                                      DropdownMenuItem<UomLine>(
                                        value: value,
                                        child: Text(value.uomName ?? ''),
                                      ))
                                  .toList(),
                              onChanged: (UomLine? newValue) {
                                // Handle selection change
                                // _cartCubit.addCartFocItem(
                                //     focItem: SaleOrderLine(
                                //         productId: product.id,
                                //         productName: product.name,
                                //         productUomQty:
                                //             (_qtyController.text != '')
                                //                 ? double.tryParse(
                                //                     _qtyController.text)
                                //                 : 0,
                                //         uomLine: product.uomLines?.first));
                              },
                              hint: const Text('uom'),
                              isDense: true,
                            ),
                          ),
                        ],
                ),
              ).padding(padding: 8.verticalPadding));
        }
      },
    );
  }
}
