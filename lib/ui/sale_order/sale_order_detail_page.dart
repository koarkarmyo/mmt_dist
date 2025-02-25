import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/cart/cart_cubit.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/model/sale_order/sale_order_6/sale_order.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';
import 'package:mmt_mobile/ui/widgets/ke_app_bar.dart';

import '../../model/sale_order/sale_order_line.dart';
import '../../model/stock_picking/stock_picking_model.dart';
import '../../src/enum.dart';
import '../../src/style/app_color.dart';

class SaleOrderDetailPage extends StatefulWidget {
  const SaleOrderDetailPage({super.key});

  @override
  State<SaleOrderDetailPage> createState() => _SaleOrderDetailPageState();
}

class _SaleOrderDetailPageState extends State<SaleOrderDetailPage> {
  SaleOrder? _saleOrder;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Object? object = ModalRoute.of(context)?.settings.arguments;
      if (object != null) {
        Map<String, dynamic> argJson = object as Map<String, dynamic>;
        _saleOrder = argJson['sale_order'];
      } else {
        context.showErrorSnackBar("Information not sufficient");
        context.pop();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KEAppbar(
        title: _saleOrder?.partnerName ?? '',
        subtitle: _saleOrder?.name,
      ),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ConstString.saleItem,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    _focProductInCartWidget(true),
                    const SizedBox(height: 16),
                    const Text(
                      ConstString.focItem,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    _focProductInCartWidget(false),
                  ],
                ),
              ),
            ),
            _totalWidget(),
          ],
        ).padding(padding: 16.allPadding);
      }),
    );
  }

  Widget _focProductInCartWidget(bool isSale) {
    List<Widget> columnItem = [];
    if (isSale) {
      _saleOrder?.orderLines
          ?.where((element) => element.saleType == SaleType.foc)
          .forEach(
        (item) {
          columnItem.add(_itemListTileWidget(item: item));
        },
      );
    } else {
      _saleOrder?.orderLines
          ?.where((element) => element.saleType == SaleType.sale)
          .forEach(
        (item) {
          columnItem.add(_notChargeItemWidget(item: item));
        },
      );
    }
    return Column(children: columnItem);
  }

  Widget _itemListTileWidget({required SaleOrderLine item}) {
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

    return Card(
      margin: (2, 0).padding,
      child: ListTile(
          title: Text(item.productName ?? 'product'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (MMTApplication.currentUser?.useLooseBox ?? false)
                  ? Text(itemPrice)
                  : Text(
                      "${item.productUomQty.toString()} ${item.uomLine?.uomName}  x ${item.priceUnit ?? 0} K"),
              Text(
                "Discount ${item.discountPercent ?? 0} %",
                style: TextStyle(color: AppColors.dangerColor),
              )
            ],
          ),
          trailing: Text(
            " ${(item.total ?? 0).roundTo(position: 3)} K",
            style: const TextStyle(fontSize: 18),
          )),
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

    return Card(
      margin: (2, 0).padding,
      child: ListTile(
        contentPadding: (0, 8).padding,
        title: Text(item.productName ?? 'product'),
        subtitle: (MMTApplication.currentUser?.useLooseBox ?? false)
            ? Text(pkPcString)
            : Text("${item.pkQty ?? ''} ${item.uomLine?.uomName ?? ''}"),
      ),
    );
  }

  Widget _totalWidget() {
    double subtotal = _saleOrder?.orderLines?.fold<double>(
            0.0, (previousValue, element) => previousValue + (element.total)) ??
        0.0;
    List<SaleOrderLine> lines = _saleOrder?.orderLines
            ?.where((element) => element.saleType == SaleType.disc)
            .toList() ??
        [];
    double discountAmount = 0.0;
    if (lines.isNotEmpty) {
      discountAmount = lines.first.total;
    }
    return Column(
      children: [
        _dataRow(title: "Subtotal", value: subtotal),
        _dataRow(title: "Discount total", value: discountAmount),
        _dataRow(
            title: "Total",
            value: discountAmount.isNegative
                ? subtotal + discountAmount
                : subtotal - discountAmount),
      ],
    );
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
}
