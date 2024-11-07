import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/customer/customer_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:collection/collection.dart';

import '../../model/delivery/delivery_item.dart';
import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../route/route_list.dart';

class FocItemPage extends StatefulWidget {
  const FocItemPage({super.key});

  @override
  State<FocItemPage> createState() => _FocItemPageState();
}

class _FocItemPageState extends State<FocItemPage> {
  late CartCubit _cartCubit;
  late ProductCubit _productCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartCubit = context.read<CartCubit>();
    _productCubit = context.read<ProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOC Items"),
        actions: [
          IconButton(
              onPressed: () {
                context.pushTo(
                    route: RouteList.saleOrderAddExtraPage,
                    args: {'extra_type': 'foc'});
              },
              icon: const Icon(Icons.add))
        ],
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

    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
    //     _qtyController.selection =
    //         TextSelection(baseOffset: 0, extentOffset: _qtyController.text.length);
    //     print("selection works");
    //   }
    // });

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int index = state.focItemList.indexWhere(
          (element) => element.productId == product.id,
        );
        if (index == -1) {
          return Container();
        } else {
          SaleOrderLine? deliveryItem = state.focItemList[index];
          double number = deliveryItem.productUomQty ?? 0;
          _qtyController.text =
              (number % 1 == 0) ? number.toInt().toString() : number.toString();
          return ListTile(
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
              children: [
                SizedBox(
                  width: 80, // Set a fixed width for the TextField
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onTap: () {
                      _qtyController.selection =
                          TextSelection(baseOffset: 0, extentOffset: _qtyController.text.length);
                    },
                    onTapOutside: (event) {
                      // Unfocus when tapping anywhere outside the TextField
                      FocusScope.of(context).unfocus();
                    },
                    autofocus: false,
                    controller: _qtyController,
                    onChanged: (value) {
                      _cartCubit.addCartFocItem(
                          focItem: SaleOrderLine(
                              productId: product.id,
                              productName: product.name,
                              productUomQty: (_qtyController.text != '')
                                  ? double.tryParse(_qtyController.text)
                                  : 0,
                              uomLine: product.uomLines?.first));
                    },
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      isDense: true, // Reduces height of the TextField
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                      border: Border.all(), borderRadius: 4.borderRadius),
                  child: DropdownButton<UomLine>(
                    value: deliveryItem?.uomLine ?? product.uomLines?.first,
                    items: product.uomLines
                        ?.map((UomLine value) => DropdownMenuItem<UomLine>(
                              value: value,
                              child: Text(value.uomName ?? ''),
                            ))
                        .toList(),
                    onChanged: (UomLine? newValue) {
                      // Handle selection change
                      _cartCubit.addCartFocItem(
                          focItem: SaleOrderLine(
                              productId: product.id,
                              productName: product.name,
                              productUomQty: (_qtyController.text != '')
                                  ? double.tryParse(_qtyController.text)
                                  : 0,
                              uomLine: newValue));
                    },
                    hint: const Text('uom'),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ).padding(padding: 8.verticalPadding);
        }
      },
    );
  }
}
