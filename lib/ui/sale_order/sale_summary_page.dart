import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/fetch_database/fetch_database_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/model/delivery/delivery_item.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../src/style/app_color.dart';

class SaleSummaryPage extends StatefulWidget {
  const SaleSummaryPage({super.key});

  @override
  State<SaleSummaryPage> createState() => _SaleSummaryPageState();
}

class _SaleSummaryPageState extends State<SaleSummaryPage> {
  final ValueNotifier<DateTime?> _deliveryDate = ValueNotifier(DateTime.now());
  late CartCubit _cartCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartCubit = context.read<CartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary Page"),
      ),
      persistentFooterButtons: [
        Container(
            padding: 16.allPadding,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: 12.borderRadius,
                border: Border.all()),
            child: const Center(
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _deliveryDateChoiceWidget(),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Delivery Item",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).padding(padding: 16.horizontalPadding),
          _productInCartWidget(),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "FOC Item",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).padding(padding: 16.horizontalPadding),
          _focProductInCartWidget(),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Coupon",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).padding(padding: 16.horizontalPadding),
          _couponInCartWidget(),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 16,
          ),
          _discountWidget(),
          _noteWidget(),
          _totalWidget()
        ],
      ),
    );
  }

  Widget _totalWidget() {
    return Column(
      children: [
        _dataRow(title: "subtotal", value: 1000),
        _dataRow(title: "discount total", value: 1000),
        _dataRow(title: "total", value: 1000),
      ],
    ).padding(padding: 16.allPadding);
  }

  Widget _dataRow({required String title, required double value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          "${value.toString()} K",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _noteWidget() {
    return Container(
      padding: 8.allPadding,
      margin: 16.allPadding,
      decoration:
          BoxDecoration(borderRadius: 8.borderRadius, border: Border.all()),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        maxLines: 3,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Note",
            hintMaxLines: 3,
            hintStyle: TextStyle(fontSize: 14)),
      ),
    );
  }

  Widget _discountWidget() {
    return Container(
        margin: 16.allPadding,
        decoration:
            BoxDecoration(borderRadius: 8.borderRadius, border: Border.all()),
        child: Row(
          children: [
            _discountTypeChoice(),
            TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Discount",
                  hintStyle: TextStyle(fontSize: 14)),
            ).expanded()
          ],
        ));
  }

  Widget _discountTypeChoice() {
    return PopupMenuButton<String>(
      elevation: 0.5,
      color: Colors.white,
      onSelected: (String value) {
        // Handle the selected value
        // _filterProductCategory = value;
        // _productCubit.searchProduct(categoryName: value);
      },
      itemBuilder: (BuildContext context) =>
          [PopupMenuItem(child: Text("Disc")), PopupMenuItem(child: Text("%"))],
      icon: Container(
        padding: 8.allPadding,
        decoration: BoxDecoration(
          borderRadius: 8.borderRadius,
          color: AppColors.primaryColor,
        ),
        child: const Row(
          children: [
            Text(
              "Disc",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),

      // This is the IconButton
    );
  }

  Widget _focProductInCartWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<Widget> columnItem = [];
        state.focItemList.forEach(
          (item) {
            columnItem.add(ListTile(
              title: Text(item.productName ?? 'product'),
              subtitle: (MMTApplication.currentUser?.useLooseBox ?? true)
                  ? Text("${item.pkQty} PK | ${item.pcQty} PC")
                  : Text(
                      "${item.productUomQty.toString()} ${item.uomLine?.uomName}  x ${item.singleItemPrice ?? 0}"),
              trailing: const Text(
                "200000 Ks",
                style: TextStyle(fontSize: 14),
              ),
            ));
          },
        );
        return Column(
          children: columnItem,
        );

        // return (state.itemList.isEmpty)
        //     ? Container()
        //     : Flexible(
        //         child: ListView.builder(
        //           itemCount: state.focItemList.length,
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, index) {
        //             DeliveryItem item = state.focItemList[index];
        //             return ListTile(
        //               title: Text(item.productName ?? 'product'),
        //               subtitle: Text(
        //                   "${item.deliverBQty.toString()} ${item.uomLine?.uomName} x ${item.bPrice}"),
        //             );
        //           },
        //         ),
        //       );
      },
    );
  }

  Widget _couponInCartWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<Widget> columnItem = [];
        state.couponList.forEach(
          (item) {
            columnItem.add(ListTile(
              title: Text(item.productName ?? 'product'),
              subtitle: Text(
                  "${item.productUomQty.toString()} ${item.uomLine?.uomName}  x ${item.singleItemPrice ?? 0}"),
              trailing: const Text(
                "200000 Ks",
                style: TextStyle(fontSize: 14),
              ),
            ));
          },
        );
        return Column(
          children: columnItem,
        );

        // return (state.itemList.isEmpty)
        //     ? Container()
        //     : Flexible(
        //         child: ListView.builder(
        //           itemCount: state.focItemList.length,
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemBuilder: (context, index) {
        //             DeliveryItem item = state.focItemList[index];
        //             return ListTile(
        //               title: Text(item.productName ?? 'product'),
        //               subtitle: Text(
        //                   "${item.deliverBQty.toString()} ${item.uomLine?.uomName} x ${item.bPrice}"),
        //             );
        //           },
        //         ),
        //       );
      },
    );
  }

  Widget _deliveryDateChoiceWidget() {
    return GestureDetector(
      onTap: () async {
        DateTime now = DateTime.now();
        _deliveryDate.value = await showDatePicker(
            context: context,
            firstDate: DateTime(now.year - 1),
            lastDate: DateTime(now.year + 1));
      },
      child: Container(
        padding: 8.allPadding,
        margin: 16.allPadding,
        decoration:
            BoxDecoration(borderRadius: 12.borderRadius, border: Border.all()),
        child: Row(
          children: [
            const Icon(Icons.date_range).padding(padding: 8.horizontalPadding),
            Text(_deliveryDate.value.toString()),
          ],
        ),
      ),
    );
  }

  Widget _productInCartWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<Widget> columnItem = [];
        state.itemList.forEach(
          (item) {
            columnItem.add(ListTile(
              title: Text(item.productName ?? 'product'),
              subtitle: (MMTApplication.currentUser?.useLooseBox ?? true)
                  ? Text("${item.pkQty} PK | ${item.pcQty} PC")
                  : Text(
                      "${item.productUomQty.toString()} ${item.uomLine?.uomName}  x ${item.singleItemPrice ?? 0}"),
              trailing: const Text(
                "200000 Ks",
                style: TextStyle(fontSize: 14),
              ),
            ));
          },
        );
        return Column(
          children: columnItem,
        );

        // return Flexible(
        //   flex: 4,
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: state.itemList.length,
        //     itemBuilder: (context, index) {
        //       DeliveryItem item = state.itemList[index];
        //       return ListTile(
        //         title: Text(item.productName ?? 'product'),
        //         subtitle: Text(
        //             "${item.deliverBQty.toString()} ${item.uomLine?.uomName}  x ${item.bPrice ?? 0}"),
        //         trailing: const Text(
        //           "200000 Ks",
        //           style: TextStyle(fontSize: 14),
        //         ),
        //       );
        //     },
        //   ),
        // );
      },
    );
  }
}
