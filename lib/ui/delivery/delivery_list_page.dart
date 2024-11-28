import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/customer/customer_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/customer/customer_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/route/route_list.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../common_widget/bottom_choice_sheet_widget.dart';
import '../../model/sale_order/sale_order_6/sale_order.dart';
import '../../src/const_string.dart';

class DeliveryListPage extends StatefulWidget {
  const DeliveryListPage({super.key});

  @override
  State<DeliveryListPage> createState() => _DeliveryListPageState();
}

class _DeliveryListPageState extends State<DeliveryListPage> {
  ValueNotifier<ResPartner?> _customerNotifier = ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CustomerCubit>().fetchAllCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstString.delivery),
        actions: [
          IconButton(
              onPressed: () {},
              icon: IconButton(
                  onPressed: () async {
                    String? barcode =
                        await MMTApplication.scanBarcode(context: context);
                  },
                  icon: const Icon(Icons.qr_code)))
        ],
      ),
      body: Column(
        children: [
          _customerChoiceWidget(),
          const SizedBox(
            height: 8,
          ),
          _saleOrderSearchWidget(),
          SizedBox(
            height: 16,
          ),
          _deliveryOrderListWidget()
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _customerChoiceWidget() {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            ResPartner? resPartner = await showModalBottomSheet<ResPartner>(
              context: context,
              builder: (context) {
                return BottomChoiceSheetWidget<ResPartner>(
                  title: 'Customer',
                  itemList: state.customerList,
                  toItemString: (value) {
                    return value.name ?? '';
                  },
                );
              },
            );
            _customerNotifier.value = resPartner;
          },
          child: ValueListenableBuilder(
            valueListenable: _customerNotifier,
            builder: (context, value, child) => Container(
              width: double.infinity,
              padding: 8.allPadding,
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: 8.borderRadius),
              child: Text(_customerNotifier.value?.name ?? ConstString.chooseCustomer),
            ),
          ),
        );
      },
    );
  }

  Widget _saleOrderSearchWidget() {
    return Row(
      children: [
        Container(
          padding: 8.horizontalPadding,
          decoration:
              BoxDecoration(border: Border.all(), borderRadius: 8.borderRadius),
          child: TextField(
            decoration: InputDecoration(
              hintText: ConstString.saleOrder,
              border: InputBorder.none,
            ),
          ),
        ).expanded(),
        IconButton(onPressed: () {}, icon: Icon(Icons.search))
      ],
    );
  }

  Widget _deliveryOrderListWidget() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            context.pushTo(route: RouteList.deliveryPage, args: {
              'sale_order':
                  SaleOrder(id: 8, name: "SO00034", partnerName: "Partner Name")
            });
          },
          title: Text("SO00034"),
          subtitle: Text("17/11/2024"),
          trailing: Text(
            "Customer Name",
            style: TextStyle(fontSize: 14),
          ),
        );
      },
    ).expanded();
  }
}
