import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class FocItemPage extends StatefulWidget {
  const FocItemPage({super.key});

  @override
  State<FocItemPage> createState() => _FocItemPageState();
}

class _FocItemPageState extends State<FocItemPage> {
  late CartCubit _cartCubit;
  late ProductCubit _productCubit;
  List<SaleOrderLine> focList = [];

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
        children: [_tableHeaderWidget(), _focItemListWidget()],
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

  Widget _tableHeaderWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        print("FOC item check : ${state.itemList.length} | ${state.focItemList.length}");
        if (state.focItemList.isEmpty) {
          return const Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.hourglass_empty), Text(ConstString.noItem)],
          ));
        }
        return Table(
          border: TableBorder.all(),
          children: [
            TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: (MMTApplication.currentUser?.useLooseBox ?? false)
                    ? [
                        _tableItem(ConstString.product,
                            align: Alignment.centerLeft),
                        _tableItem(ConstString.pk),
                        _tableItem(ConstString.pc)
                      ]
                    : [
                        _tableItem(ConstString.product,
                            align: Alignment.centerLeft),
                        _tableItem(ConstString.uom),
                        _tableItem(ConstString.qty)
                      ])
          ],
          columnWidths: (MMTApplication.currentUser?.useLooseBox ?? false)
              ? const {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2)
                }
              : const {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2)
                },
        );
      },
    );
  }

  Widget _tableItem(String text, {Alignment align = Alignment.centerRight}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _productItem({required Product product}) {
    TextEditingController _qtyController = TextEditingController();
    TextEditingController _pkController = TextEditingController();
    TextEditingController _pcController = TextEditingController();

    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
    //     _qtyController.selection =
    //         TextSelection(baseOffset: 0, extentOffset: _qtyController.text.length);
    //     print("selection works");
    //   }
    // });

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        focList = state.focItemList;
        int index = state.focItemList.indexWhere(
          (element) => element.productId == product.id,
        );
        if (index == -1) {
          return Container();
        } else {
          SaleOrderLine? deliveryItem = state.focItemList[index];
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
          return Column(
            children: [
              Slidable(
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                        backgroundColor: AppColors.dangerColor,
                        onPressed: (context) {
                          _cartCubit.removeFocItem(productId: product.id ?? 0);
                        },
                        label: "Delete",
                        icon: Icons.delete)
                  ]),
                  child: ListTile(
                    contentPadding: 10.horizontalPadding,
                    title: Text(product.name ?? '').boldSize(16),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("K 10000 / K 300"),
                        Text("23 PK / 6 PC"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      // Minimize column height
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // Aligns widgets to the right
                      children: MMTApplication.currentUser?.useLooseBox ?? false
                          ? [
                              SizedBox(
                                width:
                                    80, // Set a fixed width for the TextField
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onTap: () {
                                    _pkController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _pkController.text.length);
                                  },
                                  onTapOutside: (event) {
                                    // Unfocus when tapping anywhere outside the TextField
                                    FocusScope.of(context).unfocus();
                                  },
                                  autofocus: false,
                                  controller: _pkController,
                                  onChanged: (value) {
                                    _cartCubit.addCartFocItem(
                                        looseBoxType: LooseBoxType.pk,
                                        focItem: deliveryItem.copyWith(
                                          pcUomLine: UomLine(
                                              uomId: product.looseUomId,
                                              uomName: product.looseUomName),
                                          pkUomLine: UomLine(
                                              uomId: product.boxUomId,
                                              uomName: product.boxUomName),
                                          pkQty: (_pkController.text != '')
                                              ? double.tryParse(
                                                  _pkController.text)
                                              : 0,
                                        ));
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
                                width:
                                    80, // Set a fixed width for the TextField
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onTap: () {
                                    _pcController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _pcController.text.length);
                                  },
                                  onTapOutside: (event) {
                                    // Unfocus when tapping anywhere outside the TextField
                                    FocusScope.of(context).unfocus();
                                  },
                                  autofocus: false,
                                  controller: _pcController,
                                  onChanged: (value) {
                                    _cartCubit.addCartFocItem(
                                        looseBoxType: LooseBoxType.pc,
                                        focItem: deliveryItem.copyWith(
                                          pkUomLine: UomLine(
                                              uomId: product.boxUomId,
                                              uomName: product.boxUomName),
                                          pcUomLine: UomLine(
                                              uomId: product.looseUomId,
                                              uomName: product.looseUomName),
                                          pcQty: (_pcController.text != '')
                                              ? double.tryParse(
                                                  _pcController.text)
                                              : 0,
                                        ));
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
                              // Spacing between TextField and Dropdown
                              Container(
                                padding: 7.allPadding,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: 4.borderRadius),
                                child: DropdownButton<UomLine>(
                                  value: deliveryItem.uomLine ??
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
                                    _cartCubit.addCartFocItem(
                                        focItem: SaleOrderLine(
                                            productId: product.id,
                                            productName: product.name,
                                            productUomQty:
                                                (_qtyController.text != '')
                                                    ? double.tryParse(
                                                        _qtyController.text)
                                                    : 0,
                                            uomLine: newValue));
                                  },
                                  hint: const Text('uom'),
                                  isDense: true,
                                ),
                              ),
                              const SizedBox(width: 8),

                              SizedBox(
                                width:
                                    80, // Set a fixed width for the TextField
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onTap: () {
                                    _qtyController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _qtyController.text.length);
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
                                            productUomQty:
                                                (_qtyController.text != '')
                                                    ? double.tryParse(
                                                        _qtyController.text)
                                                    : 0,
                                            uomLine: product.uomLines?.first));
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
                            ],
                    ),
                  ).padding(padding: 8.verticalPadding)),
              Divider()
            ],
          );
        }
      },
    );
  }
}
