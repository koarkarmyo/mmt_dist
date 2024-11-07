import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';
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
  double _discountAmount = 0;

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
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        double subtotal = 0;
        state.itemList.forEach(
          (element) {
            subtotal += element.subTotal ?? 0;
          },
        );
        return Column(
          children: [
            _dataRow(title: "subtotal", value: subtotal),
            _dataRow(title: "discount total", value: _discountAmount),
            _dataRow(title: "total", value: subtotal - _discountAmount),
          ],
        );
      },
    ).padding(padding: 16.allPadding);
  }

  Widget _dataRow({required String title, required double value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
      onSelected: (String value) {},
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
            columnItem.add(_itemListTileWidget(item: item));
          },
        );
        return Column(
          children: columnItem,
        );
      },
    );
  }

  Widget _couponInCartWidget() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<Widget> columnItem = [];
        state.couponList.forEach(
          (item) {
            columnItem.add(_itemListTileWidget(item: item));
          },
        );
        return Column(
          children: columnItem,
        );
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
            columnItem.add(_itemListTileWidget(item: item));
          },
        );
        return Column(
          children: columnItem,
        );
      },
    );
  }

  Widget _itemListTileWidget({required SaleOrderLine item}) {
    return ListTile(
      title: Text(item.productName ?? 'product'),
      subtitle: (MMTApplication.currentUser?.useLooseBox ?? false)
          ? Text(item.subTotal.toString())
          : Text(
              "${item.productUomQty.toString()} ${item.uomLine?.uomName}  x ${item.singleItemPrice ?? 0} K"),
      trailing: (MMTApplication.currentUser?.useLooseBox ?? false)
          ? Text(
              " ${(((item.pkQty ?? 0) * (item.singlePKPrice ?? 0)) + ((item.pcQty ?? 0) * (item.singlePCPrice ?? 0))).toString()} K",
              style: TextStyle(fontSize: 14),
            )
          : Text(
              "${(item.productUomQty ?? 0) * (item.singleItemPrice ?? 0)} K",
              style: const TextStyle(fontSize: 14),
            ),
    );
  }
}
