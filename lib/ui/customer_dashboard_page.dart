import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../route/route_list.dart';
import '../src/mmt_application.dart';

class CustomerDashboardPage extends StatefulWidget {
  const CustomerDashboardPage({super.key});

  @override
  State<CustomerDashboardPage> createState() => _CustomerDashboardPageState();
}

class _CustomerDashboardPageState extends State<CustomerDashboardPage> {
  ResPartner? _customer;

  List<String> items = [
    "Sale order",
    "Feedback",
    "Quotation",
    "Delivery",
    "Direct sale",
    "Payment collection"
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(ConstString.customerDashboard),
      ),
      // backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          _customerInfoWidget(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 150,
                crossAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context.pushTo(
                        route: RouteList.saleOrderPage,
                        args: {'customer': _customer});
                  },
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.tasks,
                          size: 35,
                        ).padding(padding: 8.verticalPadding),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            items[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ).padding(padding: 8.horizontalPadding),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _customerInfoWidget() {
    return Container(
      decoration:
          BoxDecoration(color: Colors.blueGrey, borderRadius: 8.borderRadius),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.account_box_rounded,
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  _customer?.name ?? '',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 0.1, // Extends the shadow
                      blurRadius: 1, // Blurs the shadow
                      offset: Offset(0, 1), // Positioning of shadow (x, y)
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 35,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Sale",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ConstantWidgets.SizedBoxWidth,
              Container(
                height: 80,
                padding: 8.horizontalPadding,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 0.1, // Extends the shadow
                      blurRadius: 1, // Blurs the shadow
                      offset: Offset(0, 1), // Positioning of shadow (x, y)
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      size: 35,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Invoiced",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ConstantWidgets.SizedBoxWidth,
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 0.1, // Extends the shadow
                      blurRadius: 1, // Blurs the shadow
                      offset: Offset(0, 1), // Positioning of shadow (x, y)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 35,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Due",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ConstantWidgets.SizedBoxHeightL,
          ConstantWidgets.SizedBoxHeightL,
        ],
      ),
    );
  }
}
