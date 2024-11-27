import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/widgets/no_item_widget.dart';

import '../../business logic/bloc/cart/cart_cubit.dart';
import '../../business logic/bloc/product/product_cubit.dart';
import '../../common_widget/text_widget.dart';
import '../../model/delivery/delivery_item.dart';
import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class SaleOrderSaleItemPage extends StatefulWidget {
  const SaleOrderSaleItemPage({super.key});

  @override
  State<SaleOrderSaleItemPage> createState() => _SaleOrderSaleItemPageState();
}

class _SaleOrderSaleItemPageState extends State<SaleOrderSaleItemPage> {
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
        title: const TextWidget(ConstString.saleItem),
      ),
      body: Column(
        children: [_tableHeaderWidget(), _focItemListWidget()],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _tableHeaderWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.itemList.isEmpty) {
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
        ).expanded();
      },
    );
  }

  Widget _productItem({required Product product}) {
    TextEditingController _qtyController = TextEditingController();
    TextEditingController _pkController = TextEditingController();
    TextEditingController _pcController = TextEditingController();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int index = state.itemList.indexWhere(
          (element) => element.productId == product.id,
        );
        if (index == -1) {
          return Container();
        } else {
          SaleOrderLine? deliveryItem = state.itemList[index];
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
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  backgroundColor: AppColors.dangerColor,
                  onPressed: (context) {
                    _cartCubit.removeSaleItem(productId: product.id ?? 0);
                  },
                  label: ConstString.delete,
                  icon: Icons.delete)
            ]),
            child: Column(
              children: [
                ListTile(
                  contentPadding: 10.horizontalPadding,
                  // Adjust padding here

                  // shape: RoundedRectangleBorder(
                  //   side: const BorderSide(color: Colors.black, width: 1),
                  //   borderRadius: BorderRadius.circular(5),
                  // ),

                  title: Text(product.name ?? '').boldSize(14),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text((product.priceListItems
                                      ?.toList() // Convert to a list if it's not already
                                    ?..sort((a, b) => (a.fixedPrice ?? 0)
                                        .compareTo(b.productUom ??
                                            0)) // Sort by productUom
                                  )
                                  ?.map((e) =>
                                      '${e.productUomName} - ${e.fixedPrice} K') // Map to formatted strings
                                  .join(
                                      ', ') // Join the list into a single string
                              ??
                              '' // Provide an empty string if null
                          ),
                      const Text("23 PK / 6 PC"),
                      GestureDetector(
                        onTap: () async {
                          double? discountAmount = await showDialog(
                              context: context,
                              builder: (context) {
                                return _discountDialog(context);
                              });
                          if (discountAmount != null) {
                            _cartCubit.addCartSaleItem(
                                saleItem: deliveryItem.copyWith(
                                    discountPercent: discountAmount));
                          }
                        },
                        child: Text(
                          "Discount ${deliveryItem.discountPercent ?? 0} %",
                          style: TextStyle(color: AppColors.dangerColor),
                        ),
                      )
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
                              width: 80, // Set a fixed width for the TextField
                              child: TextField(
                                textAlign: TextAlign.right,
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
                                  _cartCubit.addCartSaleItem(
                                      saleItem: deliveryItem.copyWith(
                                    pkQty: (_pkController.text != '')
                                        ? double.tryParse(_pkController.text)
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
                              width: 80, // Set a fixed width for the TextField
                              child: TextField(
                                textAlign: TextAlign.right,
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
                                  _cartCubit.addCartSaleItem(
                                      saleItem: deliveryItem.copyWith(
                                    pcQty: (_pcController.text != '')
                                        ? double.tryParse(_pcController.text)
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
                                  _cartCubit.addCartSaleItem(
                                      saleItem: SaleOrderLine(
                                          productId: product.id,
                                          productName: product.name,
                                          productUomQty:
                                              (_qtyController.text != '')
                                                  ? double.tryParse(
                                                      _qtyController.text)
                                                  : 0,
                                          uomLine: product.uomLines?.first));
                                },
                                hint: const Text('uom'),
                                isDense: true,
                              ),
                            ),
                            const SizedBox(width: 8),

                            SizedBox(
                              width: 80, // Set a fixed width for the TextField
                              child: TextField(
                                textAlign: TextAlign.right,
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
                                  _cartCubit.addCartSaleItem(
                                      saleItem: SaleOrderLine(
                                          productId: product.id,
                                          productName: product.name,
                                          productUomQty:
                                              (_qtyController.text != '')
                                                  ? double.tryParse(
                                                      _qtyController.text)
                                                  : 0,
                                          uomLine: product.uomLines?.first));
                                },
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
                ).padding(padding: 8.verticalPadding),
                Divider()
              ],
            ),
          );
        }
      },
    );
  }

  Widget _discountDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Material(
      color: Colors.white.withOpacity(0.3),
      child: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: 16.borderRadius,
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: 8.horizontalPadding,
                decoration: BoxDecoration(
                    border: Border.all(), borderRadius: 8.borderRadius),
                child: Row(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                          isDense: true, border: InputBorder.none),
                      controller: controller,
                      keyboardType: TextInputType.number,
                    ).expanded(),
                    const Icon(Icons.percent)
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: 8.allPadding,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: 8.borderRadius,
                          border: Border.all(),
                          color: AppColors.dangerColor.withOpacity(0.5)),
                      child: const Center(child: Text(ConstString.cancel)),
                    ),
                  ).expanded(),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop(double.tryParse(controller.text));
                    },
                    child: Container(
                      // width: double.infinity,
                      padding: 8.allPadding,
                      decoration: BoxDecoration(
                          borderRadius: 8.borderRadius,
                          border: Border.all(),
                          color: AppColors.successColor.withOpacity(0.5)),
                      child: const Center(child: Text(ConstString.confirm)),
                    ),
                  ).expanded(),
                ],
              )
            ],
          ).padding(padding: 16.allPadding),
        ),
      ),
    );
  }
}
