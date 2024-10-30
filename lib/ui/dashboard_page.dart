// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../route/route_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ValueNotifier selectedTitleIndexNotifier = ValueNotifier(0);

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 15.0),
        //     child: IconButton(
        //       onPressed: () {
        //         debugPrint("Profile");
        //         Navigator.of(context).pushNamed(RouteList.profilePage);
        //       },
        //       icon: const Icon(Icons.person_2_rounded, size: 30),
        //     ),
        //   ),
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const Text("SR1"),
        //       IconButton(
        //           onPressed: () {
        //             debugPrint("SYNC");
        //           },
        //           icon: const Icon(
        //             Icons.sync,
        //             size: 30,
        //           ))
        //     ],
        //   ),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 350,
                padding: 10.allPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: 10.allPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dashboard",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text("Hello Sr1", style: TextStyle(fontSize: 12))
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),
                            child: IconButton(
                              onPressed: () {
                                debugPrint("Profile");
                                Navigator.of(context)
                                    .pushNamed(RouteList.profilePage);
                              },
                              icon:
                                  const Icon(Icons.person_2_rounded, size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Colors.black12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5)),
                          height: 70,
                          width: 135,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Delivery Sync",style: TextStyle(color: Colors.white),),
                              Icon(Icons.sync,color: Colors.white,),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5)),
                          height: 70,
                          width: 135,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sale Sync",style: TextStyle(color: Colors.white),),
                              Icon(Icons.sync,color: Colors.white,),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5)),
                          height: 70,
                          width: 90,
                          child: const Icon(Icons.sync,size: 45,color: Colors.white,),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTitleList()
                  ],
                )),
            Text(titles[selectedTitleIndexNotifier.value],
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
    return StatefulBuilder(
      builder: (context, innerState) {
        return Padding(
          padding: 10.allPadding,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(titles.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      innerState(() {
                        selectedTitleIndexNotifier.value = index;
                      },);
                    },
                    child: Container(
                      width: 250,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedTitleIndexNotifier.value == index
                            ? Colors.blueAccent
                            : Colors.black12,
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
                            fontWeight: selectedTitleIndexNotifier.value == index
                                ? FontWeight.bold
                                : null,
                            color: selectedTitleIndexNotifier.value == index
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
      },
    );
  }

  Widget buildProcessList() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: selectedTitleIndexNotifier,
        builder: (context, selectedTitleIndex, _) {
          final processes = processLists[selectedTitleIndex];
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 6,
              childAspectRatio: 0.8,
            ),
            itemCount: processes.length,
            itemBuilder: (context, index) {
              final process = processes[index];
              return InkWell(
                borderRadius: 10.borderRadius,
                onTap: () {
                  debugPrint("Process clicked: $process");

                  if (process == "Route") {
                    Navigator.pushNamed(context, RouteList.routePage);
                  } else if (process == "Contact") {
                    Navigator.pushNamed(context, RouteList.contactPage);
                  }
                },
                child: Card(
                  elevation: 0.6,
                  surfaceTintColor: Colors.blueGrey,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  borderOnForeground: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.business_center, size: 25),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          process,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
