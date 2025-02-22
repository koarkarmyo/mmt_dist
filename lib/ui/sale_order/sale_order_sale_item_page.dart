import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmt_mobile/api/api_request.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../business logic/bloc/cart/cart_cubit.dart';
import '../../business logic/bloc/product/product_cubit.dart';
import '../../common_widget/text_widget.dart';
import '../../model/product/product_product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../src/const_string.dart';
import 'package:mmt_mobile/src/enum.dart';
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
        leading: BackButton(onPressed: () async {
          // context.rootPop();
          bool? isOk = await context.showConfirmDialog(
              confirmQuestion: ConstString.areYouSureToExit, context: context);
          if (isOk ?? false) {
            context.rootPop();
          }
        }),
      ),
      persistentFooterButtons: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Subtotal : ${calculateSubtotal(state.itemList)}",
                style: const TextStyle(fontSize: 20),
              ),
            );
          },
        )
      ],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _tableHeaderWidget(),
          _focItemListWidget(),
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  double calculateSubtotal(List<SaleOrderLine> saleOrderLineList) {
    double subtotal = 0;
    double singleItemPrice = 0;
    double discountPercent = 0;
    double productUomQty = 0;
    saleOrderLineList.forEach(
      (element) {
        singleItemPrice = element.priceUnit ?? 0;
        discountPercent = element.discountPercent ?? 0;
        productUomQty = element.pkQty ?? 0;
        subtotal +=
            (singleItemPrice - (singleItemPrice * (discountPercent / 100))) *
                productUomQty;
      },
    );

    return subtotal;
  }

  Widget _tableHeaderWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.itemList.isEmpty) {
          return const Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.hourglass_empty),
              Text(ConstString.noItem),
            ],
          ));
        }
        return Table(
          border: TableBorder.all(),
          children: [
            TableRow(
                decoration: const BoxDecoration(color: AppColors.primaryColor),
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
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _focItemListWidget() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return ListView.builder(
              itemCount: cartState.itemList.length,
              itemBuilder: (context, index) {
                SaleOrderLine line = cartState.itemList[index];
                ProductProduct product = state.productList
                    .firstWhere((element) => element.id == line.productId);
                return _productItem(product: product, orderLine: line);
              },
            );
          },
        ).expanded();
      },
    );
  }

  Widget _productItem(
      {required ProductProduct product, required SaleOrderLine orderLine}) {
    // TextEditingController qtyController = TextEditingController();
    TextEditingController pkController = TextEditingController();
    TextEditingController pcController = TextEditingController();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int index = 10;
        // int index = state.itemList
        //     .indexWhere((element) => element.productId == product.id );
        if (index == -1) {
          return Container();
        } else {
          SaleOrderLine? deliveryItem = orderLine;
          // double number = deliveryItem.productUomQty ?? 0;
          // double pkNumber = deliveryItem.pkQty ?? 0;
          // double pcNumber = deliveryItem.pcQty ?? 0;
          // qtyController.text =
          //     (number % 1 == 0) ? number.toInt().toString() : number.toString();
          // pkController.text = (pkNumber % 1 == 0)
          //     ? pkNumber.toInt().toString()
          //     : pkNumber.toString();
          // pcController.text = (pcNumber % 1 == 0)
          //     ? pcNumber.toInt().toString()
          //     : pcNumber.toString();
          // debugPrint('xxxxxxxx:::${deliveryItem.pkQty}');
          //
          pkController.text = (deliveryItem.pkQty ?? 0).toQty();
          pcController.text = (deliveryItem.pcQty ?? 0).toQty();

          pkController.selection = TextSelection.fromPosition(TextPosition(offset: pkController.text.length));
          return Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  backgroundColor: AppColors.infoColor,
                  onPressed: (context) {
                    double dd = MMTApplication.genAutoKey(deliveryItem.autoKey);
                    debugPrint('xxxxxx$dd');
                    _cartCubit.addCartSaleItem(
                      saleItem: deliveryItem.copyWith(
                        autoKey: dd,
                        pkQty: 0,
                      ),
                    );
                  },
                  label: ConstString.add,
                  icon: Icons.add),
              // SlidableAction(
              //     backgroundColor: AppColors.successColor,
              //     onPressed: (context) {
              //       _cartCubit.addCartSaleItem(
              //         saleItem: deliveryItem.copyWith(
              //           autoKey:
              //               MMTApplication.genAutoKey(deliveryItem.autoKey),
              //           pkQty: 0,
              //         ),
              //       );
              //     },
              //     label: ConstString.delete,
              //     icon: Icons.delete),
            ]),
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  backgroundColor: AppColors.dangerColor,
                  onPressed: (context) {
                    _cartCubit.removeSaleItem(
                        productId: product.id ?? 0,
                        autoKey: deliveryItem.autoKey);
                  },
                  label: ConstString.delete,
                  icon: Icons.delete)
            ]),
            child: Column(
              children: [
                ListTile(
                  contentPadding: 10.horizontalPadding,
                  title: Text(product.name ?? '').boldSize(14),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${(product.priceListItems?.firstWhereOrNull(
                            (element) =>
                                element.productUom ==
                                (deliveryItem.uomLine?.uomId ??
                                    product.uomLines?.firstOrNull?.uomId),
                          )?.fixedPrice ?? 0).roundTo(position: 1).toString()} K "),
                      Text((MMTApplication.currentUser?.useLooseBox ?? false)
                          ? "23 PK / 6 PC"
                          : "300 Units"),
                      GestureDetector(
                        onTap: () async {
                          double? discountAmount = await showDialog(
                              context: context,
                              builder: (context) {
                                return _discountDialog(context,
                                    discountAmount:
                                        deliveryItem.discountPercent);
                              });
                          if (discountAmount != null) {
                            deliveryItem.discountPercent = discountAmount;
                            double subtotal = calculateSubtotal([deliveryItem]);
                            // print("Subtotal : $subtotal");

                            _cartCubit.addCartSaleItem(
                              saleItem: deliveryItem.copyWith(
                                  autoKey: MMTApplication.genAutoKey(
                                      deliveryItem.autoKey),
                                  discountPercent: discountAmount,
                                  subTotal: subtotal),
                            );
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
                        ? []
                        // ? [
                        //     SizedBox(
                        //       width: 80, // Set a fixed width for the TextField
                        //       child: TextField(
                        //         textAlign: TextAlign.right,
                        //         keyboardType: TextInputType.number,
                        //         onTap: () {
                        //           pkController.selection = TextSelection(
                        //               baseOffset: 0,
                        //               extentOffset: pkController.text.length);
                        //         },
                        //         onTapOutside: (event) {
                        //           // Unfocus when tapping anywhere outside the TextField
                        //           FocusScope.of(context).unfocus();
                        //         },
                        //         autofocus: false,
                        //         controller: pkController,
                        //         onChanged: (value) {
                        //           _cartCubit.addCartSaleItem(
                        //               saleItem: deliveryItem.copyWith(
                        //             pkQty: (pkController.text != '')
                        //                 ? double.tryParse(pkController.text)
                        //                 : 0,
                        //           ));
                        //         },
                        //         decoration: const InputDecoration(
                        //             isDense: true,
                        //             // Reduces height of the TextField
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: 8, horizontal: 8),
                        //             border: OutlineInputBorder(),
                        //             hintText: 'PK',
                        //             label: Text("PK")),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 8),
                        //     SizedBox(
                        //       width: 80, // Set a fixed width for the TextField
                        //       child: TextField(
                        //         textAlign: TextAlign.right,
                        //         keyboardType: TextInputType.number,
                        //         onTap: () {
                        //           pcController.selection = TextSelection(
                        //               baseOffset: 0,
                        //               extentOffset: pcController.text.length);
                        //         },
                        //         onTapOutside: (event) {
                        //           // Unfocus when tapping anywhere outside the TextField
                        //           FocusScope.of(context).unfocus();
                        //         },
                        //         autofocus: false,
                        //         controller: pcController,
                        //         onChanged: (value) {
                        //           _cartCubit.addCartSaleItem(
                        //               saleItem: deliveryItem.copyWith(
                        //             pcQty: (pcController.text != '')
                        //                 ? double.tryParse(pcController.text)
                        //                 : 0,
                        //           ));
                        //         },
                        //         decoration: const InputDecoration(
                        //             isDense: true,
                        //             // Reduces height of the TextField
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: 8, horizontal: 8),
                        //             border: OutlineInputBorder(),
                        //             hintText: 'PC',
                        //             label: Text("PC")),
                        //       ),
                        //     ),
                        //   ]
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
                                          product: product,
                                          autoKey: deliveryItem.autoKey,
                                          productName: product.name,
                                          pkQty: (pkController.text != '')
                                              ? double.tryParse(
                                                  pkController.text)
                                              : 0,
                                          productUomQty:
                                              (pkController.text != '')
                                                  ? double.tryParse(
                                                      pkController.text)
                                                  : 0,
                                          uomLine: newValue));
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
                                  pkController.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: pkController.text.length);
                                },
                                onTapOutside: (event) {
                                  // Unfocus when tapping anywhere outside the TextField
                                  FocusScope.of(context).unfocus();
                                },
                                autofocus: false,
                                controller: pkController,
                                onChanged: (value) {
                                  _cartCubit.addCartSaleItem(
                                      saleItem: SaleOrderLine(
                                          autoKey: deliveryItem.autoKey,
                                          product: product,
                                          productId: product.id,
                                          productName: product.name,
                                          pkQty: (pkController.text != '')
                                              ? double.tryParse(
                                                  pkController.text)
                                              : 0,
                                          productUomQty:
                                              (pkController.text != '')
                                                  ? double.tryParse(
                                                      pkController.text)
                                                  : 0,
                                          uomLine: deliveryItem.uomLine ??
                                              product.uomLines?.first));
                                },
                                decoration: const InputDecoration(
                                  isDense: true,
                                  // Reduces height of the TextField
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
                const Divider()
              ],
            ),
          );
        }
      },
    );
  }

  Widget _discountDialog(BuildContext context, {double? discountAmount}) {
    TextEditingController controller =
        TextEditingController(text: (discountAmount ?? 0).toString());
    ValueNotifier<String> warning = ValueNotifier("");
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      onTap: () {
                        controller.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: controller.text.length);
                      },
                      keyboardType: TextInputType.number,
                    ).expanded(),
                    const Icon(Icons.percent)
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: warning,
                builder: (context, value, child) => Text(
                  value,
                  style: TextStyle(color: AppColors.dangerColor),
                ).padding(padding: 4.verticalPadding),
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
                      double percentValue =
                          double.tryParse(controller.text) ?? 0;
                      if (percentValue > 100) {
                        warning.value = ConstString.percentCantExceed100;
                      } else {
                        context.pop(double.tryParse(controller.text));
                      }
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
