import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/fetch_database/fetch_database_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/product_category/product_category_cubit.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/model/delivery/delivery_item.dart';
import 'package:mmt_mobile/model/price_list/price_list_item.dart';
import 'package:mmt_mobile/model/product/uom_lines.dart';
import 'package:mmt_mobile/src/enum.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../model/product/product.dart';
import '../../model/sale_order/sale_order_line.dart';
import '../../src/style/app_color.dart';

class SaleOrderAddProductPage extends StatefulWidget {
  const SaleOrderAddProductPage({super.key});

  @override
  State<SaleOrderAddProductPage> createState() =>
      _SaleOrderAddProductPageState();
}

class _SaleOrderAddProductPageState extends State<SaleOrderAddProductPage> {
  late ProductCubit _productCubit;
  TextEditingController _searchProduct = TextEditingController();
  List<Product> _productList = [];
  String? _filterProductCategory = 'All';
  List<SaleOrderLine> _saleOrderLineList = [];
  List<PriceListItem> _priceListItem = [];
  late CartCubit _cartCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productCubit = context.read<ProductCubit>()..getAllProduct();
    context.read<ProductCategoryCubit>().getProductCategory();

    _cartCubit = context.read<CartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     "Customer Name",
        //     style: TextStyle(fontSize: 16),
        //   ),
        // ),
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.of(context).pop(); // Pops back to the previous screen.
          //   },
          // ),
          title: Text(
            "Customer Name",
            style: TextStyle(fontSize: 16),
          ),
        ),
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
                      "$_filterProductCategory Product List",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    );
                  },
                ).padding(padding: 8.verticalPadding),
                _filterWidget()
              ],
            ),
            _showProductList()
          ],
        ).padding(padding: 16.horizontalPadding),
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
              if (value != '') {
                _productCubit.searchProduct(
                    text: value, categoryName: _filterProductCategory);
              } else {
                _productCubit.searchProduct();
              }
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Product Name",
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

  Widget _showProductList() {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      _productList = state.productList;
      return ListView.builder(
        itemCount: state.filterProductList.length,
        itemBuilder: (context, index) {
          Product product = state.filterProductList[index];
          return _productItem(product: product);
        },
      ).expanded();
    });
  }

  Widget _productItem({required Product product}) {
    TextEditingController _qtyController = TextEditingController();
    TextEditingController _pcController = TextEditingController();
    TextEditingController _pkController = TextEditingController();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        SaleOrderLine? deliveryItem = state.itemList
            .where(
              (element) => element.productId == product.id,
            )
            .firstOrNull;

        print("Delivery Item : ${deliveryItem?.toJson()}");

        return ListTile(
          contentPadding: 10.horizontalPadding,
          // Adjust padding here
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),

          title: Text(product.name ?? '').boldSize(16),
          subtitle: Text((product.priceListItems
                          ?.toList() // Convert to a list if it's not already
                        ?..sort((a, b) => (a.fixedPrice ?? 0)
                            .compareTo(b.productUom ?? 0)) // Sort by productUom
                      )
                      ?.map((e) =>
                          '${e.productUomName} ${e.fixedPrice}') // Map to formatted strings
                      .join(', ') // Join the list into a single string
                  ??
                  '' // Provide an empty string if null
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
                              looseBoxType: LooseBoxType.pk,
                              saleItem: deliveryItem?.copyWith(
                                    pkQty: (_pkController.text != '')
                                        ? double.tryParse(_pkController.text)
                                        : 0,
                                  ) ??
                                  SaleOrderLine(
                                      productId: product.id,
                                      productName: product.name,
                                      pkQty: (_pkController.text != '')
                                          ? double.tryParse(_pkController.text)
                                          : 0,
                                      pcUomLine: UomLine(
                                          uomId: product.looseUomId,
                                          uomName: product.looseUomName),
                                      pkUomLine: UomLine(
                                          uomId: product.boxUomId,
                                          uomName: product.boxUomName)));
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
                              looseBoxType: LooseBoxType.pc,
                              saleItem: deliveryItem?.copyWith(
                                    pcQty: (_pcController.text != '')
                                        ? double.tryParse(_pcController.text)
                                        : 0,
                                  ) ??
                                  SaleOrderLine(
                                      productId: product.id,
                                      productName: product.name,
                                      pcQty: (_pcController.text != '')
                                          ? double.tryParse(_pcController.text)
                                          : 0,
                                      pcUomLine: UomLine(
                                          uomId: product.looseUomId,
                                          uomName: product.looseUomName),
                                      pkUomLine: UomLine(
                                          uomId: product.boxUomId,
                                          uomName: product.boxUomName)));
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
                                  productUomQty: (_qtyController.text != '')
                                      ? double.tryParse(_qtyController.text)
                                      : 0,
                                  uomLine: product.uomLines?.firstOrNull));
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
                    const SizedBox(
                        width: 8), // Spacing between TextField and Dropdown
                    Container(
                      padding: 7.allPadding,
                      decoration: BoxDecoration(
                          border: Border.all(), borderRadius: 4.borderRadius),
                      child: DropdownButton<UomLine>(
                        value: deliveryItem?.uomLine ??
                            product.uomLines?.firstOrNull,
                        items: product.uomLines
                            ?.map((UomLine value) => DropdownMenuItem<UomLine>(
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
        );
      },
    ).padding(padding: 4.verticalPadding);
  }
}
