import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/model/delivery/delivery_item.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../business logic/bloc/cart/cart_cubit.dart';
import '../../business logic/bloc/product/product_cubit.dart';
import '../../model/product/product.dart';
import '../../model/res_partner.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class StockRequestAddProduct extends StatefulWidget {
  const StockRequestAddProduct({super.key});

  @override
  State<StockRequestAddProduct> createState() => _StockRequestAddProductState();
}

class _StockRequestAddProductState extends State<StockRequestAddProduct> {
  late ProductCubit _productCubit;
  TextEditingController _searchProduct = TextEditingController();
  List<Product> _productList = [];
  String? _filterProductCategory = 'All';
  ResPartner? _customer;
  Function(SaleOrderLine deliveryItem)? _addItemFunction;

  Function(int productId)? _removeItemFunction;

  String? extraType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productCubit = context.read<ProductCubit>()..getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Pops back to the previous screen.
          },
        ),
        title: Text(
          _customer?.name ?? '',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          // IconButton(onPressed: () {
          //   context.pop();
          // }, icon: Badge(
          //     label: Text((extraType == 'foc')
          //         ? state.focItemList.length.toString()
          //         : state.couponList.length.toString()),
          //     child: const Icon(Icons.shopping_cart)))
        ],
      ),
      body: Column(
        children: [
          _searchFieldWidget(),
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
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _filterWidget() {
    return PopupMenuButton<String>(
      elevation: 0.5,
      color: Colors.white,
      onSelected: (String value) {
        // Handle the selected value
        _filterProductCategory = value;
        _productCubit.searchProduct(categoryName: value);
      },
      itemBuilder: (BuildContext context) => _productList
          .fold<Set<String>>({}, (set, e) => set..add(e.categName ?? ''))
          .map((item) => PopupMenuItem(value: item, child: Text(item ?? '')))
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
    return ListTile(
        onTap: () {},
        title: Text(product.name ?? ''),
        subtitle: Text("Available Qty: ${((0).toString())} ${product.uomName}"),
        trailing: Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
        ));
  }
}
