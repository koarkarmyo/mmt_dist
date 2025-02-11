import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/product_category/product_category_cubit.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/model/product/uom_lines.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_6/sale_order.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../common_widget/text_widget.dart';
import '../../model/product/product_product.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../src/const_string.dart';
import '../../src/style/app_color.dart';

class SaleOrderAddProductPage extends StatefulWidget {
  final SaleOrder? saleOrder;
  final ResPartner? customer;

  const SaleOrderAddProductPage({super.key, this.customer, this.saleOrder});

  @override
  State<SaleOrderAddProductPage> createState() =>
      _SaleOrderAddProductPageState();
}

class _SaleOrderAddProductPageState extends State<SaleOrderAddProductPage> {
  late ProductCubit _productCubit;
  final TextEditingController _searchProduct = TextEditingController();
  String? _filterProductCategory = 'All';
  late CartCubit _cartCubit;
  ResPartner? _customer;
  final List<TextEditingController> _pk = [];
  final List<TextEditingController> _pc = [];
  final List<FocusNode> _focusNodeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productCubit = context.read<ProductCubit>()..getAllProduct();
    context.read<ProductCategoryCubit>().getProductCategory();

    _cartCubit = context.read<CartCubit>();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (data != null) {
      _customer = data['customer'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.customer?.name ?? 'Customer 01'),
          leading: BackButton(onPressed: () async {
            // context.rootPop();
            bool? isOk = await context.showConfirmDialog(
                confirmQuestion: ConstString.areYouSureToExit,
                context: context);
            if (isOk ?? false) {
              context.rootPop();
            }
          }),
        ),
        persistentFooterButtons: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return TextWidget(
                '',
                dataList: [
                  ConstString.total,
                  ':',
                  state.productList.length.toString()
                ],
                style: const TextStyle(fontSize: 20),
              );
            },
          )
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchFieldWidget(),
            ConstantWidgets.SizedBoxHeightL,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    return Text(
                      "$_filterProductCategory product list",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    );
                  },
                ).padding(padding: 8.verticalPadding),
                _filterWidget()
              ],
            ),
            // _showProductList()
            _productTableHeaderWidget(),
            _productTableRows()
          ],
        ).padding(padding: 16.horizontalPadding),
      ),
    );
  }

  Widget _productTableHeaderWidget() {
    List<TableRow> tableRows = [
      TableRow(
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        children: (MMTApplication.currentUser?.useLooseBox ?? false)
            ? [
                _tableItem(ConstString.name, align: Alignment.centerLeft),
                _tableItem(ConstString.pk),
                _tableItem(ConstString.pc),
              ]
            : [
                _tableItem(ConstString.name, align: Alignment.centerLeft),
                _tableItem(ConstString.uom),
                _tableItem(ConstString.qty),
              ],
      )
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: (MMTApplication.currentUser?.useLooseBox ?? false)
          ? const {
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            }
          : const {
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(3),
            },
      children: tableRows,
    );
  }

  Widget _productTableRows() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.productList.length,
          itemBuilder: (context, index) {
            //
            if (!(MMTApplication.selectedCompany?.useLooseUom ?? true)) {
              _pc.add(TextEditingController());
            }
            //
            _pk.add(TextEditingController());
            //
            _focusNodeList.add(FocusNode());
            //
            return (MMTApplication.currentUser?.useLooseBox ?? false)
                ? _productRowWithPKPC(
                    product: state.productList[index],
                    position: index,
                  )
                : _productRow(
                    product: state.productList[index], position: index);
          },
        ).expanded();
      },
    );
  }

  Widget _productRowWithPKPC(
      {required ProductProduct product, required int position}) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      SaleOrderLine? deliveryItem = state.itemList
          .where(
            (element) => element.productId == product.id,
          )
          .firstOrNull;

      return Container(
        padding: 8.allPadding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name ?? '').bold(),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "10000K",
                  style: TextStyle(fontSize: 14),
                ),
                const Text("10 PK 5 PC", style: TextStyle(fontSize: 14))
              ],
            ).expanded(flex: 6),
            TextField(
              onTap: () {
                _pk[position].selection = TextSelection(
                    baseOffset: 0, extentOffset: _pk[position].text.length);
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                _cartCubit.addCartSaleItem(
                    looseBoxType: LooseBoxType.pk,
                    saleItem: deliveryItem?.copyWith(
                          pkQty: (_pk[position].text != '')
                              ? double.tryParse(_pk[position].text)
                              : 0,
                        ) ??
                        SaleOrderLine(
                            productId: product.id,
                            productName: product.name,
                            pkQty: (_pk[position].text != '')
                                ? double.tryParse(_pk[position].text)
                                : 0,
                            pcUomLine: UomLine(
                                uomId: product.looseUomId,
                                uomName: product.looseUomName),
                            pkUomLine: UomLine(
                                uomId: product.boxUomId,
                                uomName: product.boxUomName)));
              },
              keyboardType: TextInputType.number,
              controller: _pk[position],
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: ConstString.qty),
            ).padding(padding: 8.horizontalPadding).expanded(flex: 3),
            TextField(
              onTap: () {
                _pc[position].selection = TextSelection(
                    baseOffset: 0, extentOffset: _pc[position].text.length);
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                _cartCubit.addCartSaleItem(
                    looseBoxType: LooseBoxType.pc,
                    saleItem: deliveryItem?.copyWith(
                          pcQty: (_pc[position].text != '')
                              ? double.tryParse(_pc[position].text)
                              : 0,
                        ) ??
                        SaleOrderLine(
                            productId: product.id,
                            productName: product.name,
                            pcQty: (_pc[position].text != '')
                                ? double.tryParse(_pc[position].text)
                                : 0,
                            pcUomLine: UomLine(
                                uomId: product.looseUomId,
                                uomName: product.looseUomName),
                            pkUomLine: UomLine(
                                uomId: product.boxUomId,
                                uomName: product.boxUomName)));
              },
              keyboardType: TextInputType.number,
              controller: _pc[position],
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: ConstString.qty),
            ).padding(padding: 8.horizontalPadding).expanded(flex: 3),
          ],
        ),
      );
    });
  }

  Widget _productRow({required ProductProduct product, required int position}) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      SaleOrderLine? deliveryItem = state.itemList
          .where(
            (element) =>
                element.productId == product.id &&
                element.uomLine?.uomId == product.uomId,
          )
          .firstOrNull;

      _pk[position].text = deliveryItem?.pkQty?.toQty() ?? '';
      if (!(MMTApplication.selectedCompany?.useLooseUom ?? true)) {
        _pc[position].text = deliveryItem?.pcQty?.toQty() ?? '';
      }

      return Container(
        padding: 8.allPadding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name ?? '').bold(),
                const SizedBox(height: 8),
                Text("${(product.priceListItems?.firstWhereOrNull(
                      (element) =>
                          element.productUom ==
                          (deliveryItem?.uomLine?.uomId ??
                              product.uomLines?.firstOrNull?.uomId),
                    )?.fixedPrice ?? 0).roundTo(position: 1).toString()} K "),
                Text((MMTApplication.currentUser?.useLooseBox ?? false)
                    ? "23 PK / 6 PC"
                    : "300 Units"),
              ],
            ).expanded(flex: 6),
            Container(
              margin: 8.horizontalPadding,
              width: 200,
              child: DropdownButton<UomLine>(
                isExpanded: true,
                autofocus: false,
                value: deliveryItem?.uomLine ?? product.uomLines?.firstOrNull,
                items: product.uomLines
                    ?.map((UomLine value) => DropdownMenuItem<UomLine>(
                          value: value,
                          child: Text(value.uomName ?? ''),
                        ))
                    .toList(),
                onChanged: (UomLine? newValue) {
                  if (newValue != null) {
                    //
                    double price = (product.priceListItems
                            ?.firstWhereOrNull(
                              (element) => element.productUom == newValue.uomId,
                            )
                            ?.fixedPrice ??
                        0);
                    // Handle selection change
                    _cartCubit.addCartSaleItem(
                      saleItem: SaleOrderLine(
                        productId: product.id,
                        productName: product.name,
                        pkQty: deliveryItem?.pkQty,
                        priceUnit: price,
                        productUomQty: deliveryItem?.productUomQty ?? 0.0,
                        uomLine: newValue,
                      ),
                    );
                  }
                },
                hint: const Text('uom'),
                isDense: true,
              ),
            ).expanded(flex: 4),
            TextField(
              focusNode: _focusNodeList[position],
              onEditingComplete: () {
                if (position < _focusNodeList.length) {
                  FocusScope.of(context)
                      .requestFocus(_focusNodeList[position + 1]);
                }
              },
              textInputAction: TextInputAction.next,
              onTap: () {
                _pk[position].selection = TextSelection(
                    baseOffset: 0, extentOffset: _pk[position].text.length);
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                //
                double price = (product.priceListItems
                        ?.firstWhereOrNull(
                          (element) =>
                              element.productUom ==
                              (deliveryItem?.uomLine?.uomId ??
                                  product.uomLines?.firstOrNull?.uomId),
                        )
                        ?.fixedPrice ??
                    0);
                //
                _cartCubit.addCartSaleItem(
                  saleItem: SaleOrderLine(
                    productId: product.id,
                    productName: product.name,
                    pkQty: double.tryParse(value),
                    productUomQty: double.tryParse(value),
                    priceUnit: price,
                    uomLine:
                        deliveryItem?.uomLine ?? product.uomLines?.firstOrNull,
                  ),
                );
              },
              keyboardType: TextInputType.number,
              controller: _pk[position],
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: '0'),
            ).padding(padding: 8.horizontalPadding).expanded(flex: 3),
          ],
        ),
      );
    });
  }

  Widget _tableItem(String text, {Alignment align = Alignment.centerRight}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _searchFieldWidget() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(), borderRadius: 14.borderRadius),
      padding: 8.horizontalPadding,
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 16,
          ).padding(padding: 8.horizontalPadding),
          TextField(
            controller: _searchProduct,
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _productCubit.searchProduct(
                    text: value, categoryName: _filterProductCategory);
              } else {
                _productCubit.searchProduct();
              }
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: ConstString.productName,
                hintStyle: TextStyle(fontSize: 14)),
          ).expanded(),
          _productQrScanner()
        ],
      ),
    );
  }

  Widget _productQrScanner() {
    return IconButton(
        onPressed: () async {
          String? barcode = await MMTApplication.scanBarcode(context: context);
          if (barcode != null) {
            _productCubit.searchProduct(barcode: barcode);
          }
        },
        icon: const Icon(Icons.qr_code));
  }

  Widget _filterWidget() {
    return BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
      builder: (context, state) {
        return PopupMenuButton<String>(
          elevation: 0.5,
          color: Colors.white,
          onSelected: (String value) {
            // Handle the selected value
            _filterProductCategory = value;
            _productCubit.searchProduct(categoryName: value);
          },
          // itemBuilder: (BuildContext context) => _productList
          //     .fold<Set<String>>({}, (set, e) => set..add(e.categName ?? ''))
          //     .map((item) => PopupMenuItem(value: item, child: Text(item ?? '')))
          //     .toList(),
          itemBuilder: (BuildContext context) => state.productCategoryList
              .map(
                (item) => PopupMenuItem(
                    value: item.name, child: Text(item.name ?? '')),
              )
              .toList(),
          icon: Container(
            padding: 8.allPadding,
            decoration: BoxDecoration(
              borderRadius: 8.borderRadius,
              color: AppColors.primaryColor,
            ),
            child: const Row(
              children: [
                Text(
                  "Product Type",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                Icon(
                  Icons.filter_list_alt,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),

          // This is the IconButton
        );
      },
    );
  }

// Widget _showProductList() {
//   return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
//     return ListView.builder(
//       itemCount: state.filterProductList.length,
//       itemBuilder: (context, index) {
//         Product product = state.filterProductList[index];
//         //
//         if (!(MMTApplication.selectedCompany?.useLooseUom ?? true)) {
//           _pc.add(TextEditingController());
//         }
//         _pk.add(TextEditingController());
//         //
//         return _productItem(product: product, position: index);
//       },
//     ).expanded();
//   });
// }
//
// Widget _productItem({required Product product, required int position}) {
//   //
//   return BlocBuilder<CartCubit, CartState>(
//     builder: (context, state) {
//       SaleOrderLine? deliveryItem = state.itemList
//           .where((element) => element.productId == product.id)
//           .firstOrNull;
//
//       print('orderrr:::${deliveryItem?.pcQty}');
//       print('orderrr:::${deliveryItem?.pkQty}');
//
//       _pk[position].text = deliveryItem?.pkQty?.toQty() ?? '';
//       if (!(MMTApplication.selectedCompany?.useLooseUom ?? true)) {
//         _pc[position].text = deliveryItem?.pcQty?.toQty() ?? '';
//       }
//
//       return ListTile(
//         contentPadding: 10.horizontalPadding,
//         // Adjust padding here
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: Colors.black, width: 1),
//           borderRadius: BorderRadius.circular(5),
//         ),
//
//         title: Text(product.name ?? '').boldSize(16),
//         subtitle: Text((product.priceListItems
//                         ?.toList() // Convert to a list if it's not already
//                       ?..sort((a, b) => (a.fixedPrice ?? 0)
//                           .compareTo(b.productUom ?? 0)) // Sort by productUom
//                     )
//                     ?.map((e) =>
//                         '${e.productUomName} ${e.fixedPrice}') // Map to formatted strings
//                     .join(', ') // Join the list into a single string
//                 ??
//                 '' // Provide an empty string if null
//             ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           // Minimize column height
//           crossAxisAlignment: CrossAxisAlignment.end,
//           // Aligns widgets to the right
//           children: MMTApplication.currentUser?.useLooseBox ?? false
//               ? [
//                   SizedBox(
//                     width: 80, // Set a fixed width for the TextField
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       onTap: () {
//                         _pk[position].selection = TextSelection(
//                             baseOffset: 0,
//                             extentOffset: _pk[position].text.length);
//                       },
//                       onTapOutside: (event) {
//                         // Unfocus when tapping anywhere outside the TextField
//                         FocusScope.of(context).unfocus();
//                       },
//                       autofocus: false,
//                       controller: _pk[position],
//                       onChanged: (value) {
//                         _cartCubit.addCartSaleItem(
//                             looseBoxType: LooseBoxType.pk,
//                             saleItem: deliveryItem?.copyWith(
//                                   pkQty: (_pk[position].text != '')
//                                       ? double.tryParse(_pk[position].text)
//                                       : 0,
//                                 ) ??
//                                 SaleOrderLine(
//                                     productId: product.id,
//                                     productName: product.name,
//                                     pkQty: (_pk[position].text != '')
//                                         ? double.tryParse(_pk[position].text)
//                                         : 0,
//                                     pcUomLine: UomLine(
//                                         uomId: product.looseUomId,
//                                         uomName: product.looseUomName),
//                                     pkUomLine: UomLine(
//                                         uomId: product.boxUomId,
//                                         uomName: product.boxUomName)));
//                       },
//                       decoration: const InputDecoration(
//                           isDense: true,
//                           // Reduces height of the TextField
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 8),
//                           border: OutlineInputBorder(),
//                           hintText: 'PK',
//                           label: Text("PK")),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   SizedBox(
//                     width: 80, // Set a fixed width for the TextField
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       onTap: () {
//                         _pc[position].selection = TextSelection(
//                             baseOffset: 0,
//                             extentOffset: _pc[position].text.length);
//                       },
//                       onTapOutside: (event) {
//                         // Unfocus when tapping anywhere outside the TextField
//                         FocusScope.of(context).unfocus();
//                       },
//                       autofocus: false,
//                       controller: _pc[position],
//                       onChanged: (value) {
//                         _cartCubit.addCartSaleItem(
//                           looseBoxType: LooseBoxType.pc,
//                           saleItem: deliveryItem?.copyWith(
//                                 pcQty: (_pc[position].text != '')
//                                     ? double.tryParse(_pc[position].text)
//                                     : 0,
//                               ) ??
//                               SaleOrderLine(
//                                   productId: product.id,
//                                   productName: product.name,
//                                   pcQty: (_pc[position].text != '')
//                                       ? double.tryParse(_pc[position].text)
//                                       : 0,
//                                   pcUomLine: UomLine(
//                                       uomId: product.looseUomId,
//                                       uomName: product.looseUomName),
//                                   pkUomLine: UomLine(
//                                     uomId: product.boxUomId,
//                                     uomName: product.boxUomName,
//                                   )),
//                         );
//                       },
//                       decoration: const InputDecoration(
//                           isDense: true,
//                           // Reduces height of the TextField
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 8),
//                           border: OutlineInputBorder(),
//                           hintText: 'PC',
//                           label: Text("PC")),
//                     ),
//                   ),
//                 ]
//               : [
//                   SizedBox(
//                     width: 80, // Set a fixed width for the TextField
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       onTap: () {
//                         _pk[position].selection = TextSelection(
//                             baseOffset: 0,
//                             extentOffset: _pk[position].text.length);
//                       },
//                       onTapOutside: (event) {
//                         // Unfocus when tapping anywhere outside the TextField
//                         FocusScope.of(context).unfocus();
//                       },
//                       autofocus: false,
//                       controller: _pk[position],
//                       onChanged: (value) {
//                         _cartCubit.addCartSaleItem(
//                           saleItem: SaleOrderLine(
//                             productId: product.id,
//                             productName: product.name,
//                             pkQty: double.tryParse(value),
//                             productUomQty: double.tryParse(value),
//                             uomLine: product.uomLines?.firstOrNull,
//                           ),
//                         );
//                       },
//                       textAlign: TextAlign.right,
//                       decoration: const InputDecoration(
//                         isDense: true, // Reduces height of the TextField
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                         border: OutlineInputBorder(),
//                         hintText: 'Qty',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                       width: 8), // Spacing between TextField and Dropdown
//                   Container(
//                     padding: 7.allPadding,
//                     decoration: BoxDecoration(
//                         border: Border.all(), borderRadius: 4.borderRadius),
//                     child: DropdownButton<UomLine>(
//                       value: deliveryItem?.uomLine ??
//                           product.uomLines?.firstOrNull,
//                       items: product.uomLines
//                           ?.map((UomLine value) => DropdownMenuItem<UomLine>(
//                                 value: value,
//                                 child: Text(value.uomName ?? ''),
//                               ))
//                           .toList(),
//                       onChanged: (UomLine? newValue) {
//                         // Handle selection change
//                         _cartCubit.addCartSaleItem(
//                             saleItem: SaleOrderLine(
//                                 productId: product.id,
//                                 productName: product.name,
//                                 productUomQty: (_pk[position].text != '')
//                                     ? double.tryParse(_pk[position].text)
//                                     : 0,
//                                 uomLine: newValue));
//                       },
//                       hint: const Text('uom'),
//                       isDense: true,
//                     ),
//                   ),
//                 ],
//         ),
//       );
//     },
//   ).padding(padding: 4.verticalPadding);
// }
}
