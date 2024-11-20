import 'package:flutter/material.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../src/const_string.dart';

class DeliveryReturnPage extends StatefulWidget {
  const DeliveryReturnPage({super.key});

  @override
  State<DeliveryReturnPage> createState() => _DeliveryReturnPageState();
}

class _DeliveryReturnPageState extends State<DeliveryReturnPage> {
  final ValueNotifier<String?> _vehicleNameNotifier = ValueNotifier(null);

  List<String> locationList = [
    "7R/3818",
    "4R/3818",
    "7R/3008",
    "7D/2818",
    "3R/3818",
    "7R/3818",
    "7R/3818",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstString.deliveryReturn),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              String? vehicle = await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomChoiceSheetWidget<String?>(
                      itemList: locationList,
                      toItemString: (value) => value ?? '',
                      title: "Vehicle");
                },
              );
            },
            child: Container(
              padding: 8.horizontalPadding,
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: 8.borderRadius),
              child: ValueListenableBuilder(
                valueListenable: _vehicleNameNotifier,
                builder: (context, value, child) => Text(value ?? ''),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _returnListWidget()
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _returnListWidget() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return const ListTile(
          dense: true,
          title: Text("Product Name"),
          subtitle: Text("12 Kg"),
        );
      },
    ).expanded();
  }
}
