// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

// import '../common_widget/alert_dialog.dart';
// import '../common_widget/sync_progress_dialog.dart';
// import '../common_widget/text_widget.dart';
import '../route/route_list.dart';
import '../src/const_dimen.dart';
import '../src/style/app_color.dart';
// import '../sync/sync_utils/main_sync_process.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTitleIndex = 0;

  final List<String> titles = [
    "Sale",
    "Delivery",
    "Finance & Accounting",
    "Inventory",
    "WMS",
    "Report"
  ];

  final List<List<String>> processLists = [
    ["Route", "Customer Visit", "Today Order", "Contact"],
    ["Today Delivery"],
    ["Account Payments", "Payment Transfer"],
    ["Loading", "Vehicle Inventory", "Product Report", "Stock Request"],
    ["Stock Unloading", "Delivery Return", "Purchase", "Purchase Quotation"],
    [
      "Loading Report",
      "Unloading Report",
      "Vehicle Inventory",
      "Today Order Report",
      "Delivery Report",
      "Delivery Return Report",
      "Delivery Report(Sale)",
      "Stock Order",
      "Delivery Report",
      "Today Sale Order Report",
      "Daily Sale Product Report"
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            onPressed: () {
              debugPrint("Profile");
              Navigator.of(context).pushNamed(RouteList.profilePage);
            },
            icon: const Icon(Icons.person_2_rounded, size: 30),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("SR1"),
            IconButton(
                onPressed: () {
                  debugPrint("SYNC");
                },
                icon: const Icon(
                  Icons.sync,
                  size: 25,
                ))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleList(),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text(titles[selectedTitleIndex],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))
                .padding(padding: 5.allPadding),
            const SizedBox(
              height: 5,
            ),
            buildProcessList()
          ],
        ),
      ),
    );
  }

  Widget buildTitleList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(titles.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0), // Add spacing between items
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTitleIndex = index;
                  });
                },
                child: Container(
                  width: 150,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: selectedTitleIndex == index
                        ? AppColors.primaryColor
                        : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      titles[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: selectedTitleIndex == index
                            ? FontWeight.bold
                            : null,
                        color: selectedTitleIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }


  Widget buildProcessList() {
    final processes = processLists[selectedTitleIndex];
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 6,
            children: processes.map((process) {
              return InkWell(
                onTap: () {
                  debugPrint("Process clicked: $process");

                  if(process == "Route"){
                    Navigator.pushNamed(context, RouteList.routePage);
                  }
                  else if (process == "Contact"){
                    Navigator.pushNamed(context, RouteList.contactPage);
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.business_center, size: 35),
                        const SizedBox(width: ConstantDimens.sizedBoxM),
                        Text(
                          process,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

