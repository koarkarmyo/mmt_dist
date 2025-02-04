import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/sale_order/sale_order_cubit.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_line.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../src/const_string.dart';
import '../../src/enum.dart';
import '../../src/style/app_color.dart';
import '../../sync/sync_utils/main_sync_process.dart';

class SaleSummaryPage extends StatefulWidget {
  const SaleSummaryPage({super.key});

  @override
  State<SaleSummaryPage> createState() => _SaleSummaryPageState();
}

class _SaleSummaryPageState extends State<SaleSummaryPage> {
  final ValueNotifier<DateTime?> _deliveryDate = ValueNotifier(DateTime.now());
  late CartCubit _cartCubit;
  late SaleOrderCubit _saleOrderCubit;
  double _discountAmount = 0;
  double _total = 0;
  final TextEditingController _discController = TextEditingController();
  final ValueNotifier<DiscountTypes> _discountType =
      ValueNotifier(DiscountTypes.K);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartCubit = context.read<CartCubit>();
    _saleOrderCubit = context.read<SaleOrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstString.summaryPage),
      ),
      persistentFooterButtons: [
        BlocConsumer<CartCubit, CartState>(
          listener: (BuildContext context, CartState state) {
            if (state.state == BlocCRUDProcessState.createSuccess) {
              context.showSuccessDialog(ConstString.successMM).then((value) {
                context.rootPop();
                //
                MainSyncProcess.instance.startManualSyncWithSyncGroup("SALE");
              });
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                SaleOrder saleOrder = SaleOrder(
                  partnerId: MMTApplication.currentCustomer?.id,
                  partnerName: MMTApplication.currentCustomer?.name,
                  amountTotal: _total - _discountAmount,
                  warehouseId: MMTApplication.currentUser?.defaultWarehouseId,
                  warehouseName:
                      MMTApplication.currentUser?.defaultWarehouseName,
                  createDate: DateTime.now().toString(),
                  isUpload: false,
                );
                _cartCubit.saveSaleOrder(saleOrder: saleOrder);
              },
              child: Container(
                padding: 16.allPadding,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.successColor,
                    borderRadius: 12.borderRadius,
                    border: Border.all(color: AppColors.successColor)),
                child: Center(
                  child: (state.state == BlocCRUDProcessState.creating)
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            );
          },
        )
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
            ConstString.saleItem,
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
            ConstString.focItem,
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
          // const Text(
          //   "Coupon",
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          // ).padding(padding: 16.horizontalPadding),
          // _couponInCartWidget(),
          // const SizedBox(
          //   height: 10,
          // ),
          // Divider(
          //   color: Colors.grey.shade200,
          //   thickness: 16,
          // ),
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
            _dataRow(title: "Subtotal", value: subtotal),
            _dataRow(title: "Discount total", value: _discountAmount),
            _dataRow(title: "Total", value: subtotal - _discountAmount),
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
          style: const TextStyle(
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
              controller: _discController,
              keyboardType: TextInputType.number,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                //some logic on discount
                _discountAmount = double.tryParse(value) ?? 0;
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
    return PopupMenuButton<DiscountTypes>(
      elevation: 0.5,
      color: Colors.white,
      onSelected: (DiscountTypes value) {
        _discountType.value = value;
      },
      itemBuilder: (BuildContext context) => DiscountTypes.values
          .map(
            (e) => PopupMenuItem<DiscountTypes>(value: e, child: Text(e.name)),
          )
          .toList(),

      icon: Container(
        padding: 8.allPadding,
        decoration: BoxDecoration(
          borderRadius: 8.borderRadius,
          color: AppColors.primaryColor,
        ),
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: _discountType,
              builder: (context, value, child) => Text(
                value.name,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
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
            columnItem.add(_notChargeItemWidget(item: item));
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
            columnItem.add(_notChargeItemWidget(item: item));
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
            columnItem
                .add(_itemListTileWidget(item: item, type: SaleItemType.sale));
          },
        );
        return Column(
          children: columnItem,
        );
      },
    );
  }

  Widget _notChargeItemWidget({required SaleOrderLine item}) {
    String pkPcString = ((item.pkQty != null)
            ? "${item.pkQty} ${item.pkUomLine?.uomName} | "
            : '') +
        ((item.pcQty != null)
            ? "${item.pcQty} ${item.pcUomLine?.uomName} "
            : '');

    if ((item.productUomQty ?? 0) == 0 &&
        (item.pkQty ?? 0) == 0 &&
        (item.pcQty ?? 0) == 0) {
      return Container();
    }

    return ListTile(
      title: Text(item.productName ?? 'product'),
      subtitle: (MMTApplication.currentUser?.useLooseBox ?? false)
          ? Text(pkPcString)
          : Text("${item.productUomQty ?? ''} ${item.uomLine?.uomName ?? ''}"),
    );
  }

  Widget _itemListTileWidget(
      {required SaleOrderLine item, required SaleItemType type}) {
    String itemPrice = ((item.pkQty != null)
            ? "${item.pkQty} ${item.pkUomLine?.uomName} x ${item.singlePKPrice} K | "
            : '') +
        ((item.pcQty != null)
            ? "${item.pcQty} ${item.pcUomLine?.uomName} x ${item.singlePCPrice} K"
            : '');

    if ((item.productUomQty ?? 0) == 0 &&
        (item.pkQty ?? 0) == 0 &&
        (item.pcQty ?? 0) == 0) {
      return Container();
    }

    return ListTile(
        title: Text(item.productName ?? 'product'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (MMTApplication.currentUser?.useLooseBox ?? false)
                ? Text(itemPrice)
                : Text(
                    "${item.productUomQty.toString()} ${item.uomLine?.uomName}  x ${item.singleItemPrice ?? 0} K"),
            Text(
              "Discount ${item.discountPercent ?? 0} %",
              style: TextStyle(color: AppColors.dangerColor),
            )
          ],
        ),
        trailing: Text(
          " ${(item.subTotal ?? 0).roundTo(position: 3)} K",
          style: const TextStyle(fontSize: 18),
        ));
  }
}
