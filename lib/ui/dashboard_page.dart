import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import '../common_widget/alert_dialog.dart';
import '../common_widget/bottom_sheet_selection_widget.dart';
import '../common_widget/sync_progress_dialog.dart';
import '../route/route_list.dart';
import '../sync/bloc/sync_action_bloc/sync_action_bloc_cubit.dart';
import '../sync/models/sync_response.dart';
import '../sync/sync_utils/main_sync_process.dart';
import 'package:collection/collection.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late SyncActionCubit _syncActionCubit;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<int> selectedTitleIndexNotifier = ValueNotifier(0);
  ValueNotifier<List<bool>> selectActionList = ValueNotifier([]);
  GlobalKey<SyncProgressDialogState> _dialogKey = GlobalKey();
  StreamSubscription? _masterSyncStream;

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

  void _onScroll() {
    double offset = _scrollController.offset;
    int newIndex = (offset / 250).round();

    if (newIndex != selectedTitleIndexNotifier.value &&
        newIndex < titles.length) {
      selectedTitleIndexNotifier.value = newIndex;
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
    manualSyncStreamListener();
    _syncActionCubit = context.read<SyncActionCubit>()
      ..getSyncAction(isManualSync: true);
  }

  @override
  void dispose() {
    selectedTitleIndexNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: IconButton(
                  onPressed: () {
                    debugPrint("Profile");
                    Navigator.of(context).pushNamed(RouteList.profilePage);
                  },
                  icon: const Icon(Icons.person_2_rounded, size: 30),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Sr1", style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: [
            // IconButton(onPressed: () {
            //
            // }, icon: Icon(Icons.sync,size: 30,))
            BlocBuilder<SyncActionCubit, SyncActionState>(
              builder: (context, state) {
                state.actionGroupList.forEach(
                  (element) => print(element.name),
                );
                return PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: (String value) {
                    // Handle the selected value
                    _showSyncActionSelectWidget(
                        listTitle: value,
                        actionList: state.actionList
                            .where(
                              (element) =>
                                  element.checkActionGroup(groupName: value),
                            )
                            .toList());
                  },
                  itemBuilder: (BuildContext context) => state.actionGroupList
                      .map((item) => PopupMenuItem<String>(
                            value: item.name,
                            child: Text(item.name ?? ''),
                          ))
                      .toList(),
                  icon: const Icon(Icons.sync), // This is the IconButton
                );
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ).padding(padding: 10.allPadding),
            buildWorkingPart(),
            // Move the process list to follow the title list
          ],
        ),
      ),
    );
  }

  Widget buildWorkingPart() {
    return ValueListenableBuilder<int>(
      valueListenable: selectedTitleIndexNotifier,
      builder: (context, selectedTitleIndex, _) {
        final processes = processLists[selectedTitleIndex];
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleList(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titles[selectedTitleIndex],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ).padding(
                            padding: 5.allPadding,
                          ),
                          const SizedBox(height: 5),
                          buildProcessList(processes)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildTitleList() {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: List.generate(titles.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ValueListenableBuilder<int>(
                valueListenable: selectedTitleIndexNotifier,
                builder: (context, selectedTitleIndex, _) {
                  return Container(
                    width: 250,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: selectedTitleIndex == index
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
                          fontWeight: selectedTitleIndex == index
                              ? FontWeight.bold
                              : null,
                          color: selectedTitleIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Expanded buildProcessList(List<String> processes) {
    return Expanded(
      child: GridView.builder(
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
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.lightBlueAccent,
            borderRadius: 14.borderRadius,
            onTap: () {
              debugPrint("Process clicked: $process");
              if (process == "Route") {
                Navigator.pushNamed(context, RouteList.routePage);
              } else if (process == "Contact") {
                Navigator.pushNamed(context, RouteList.contactPage);
              } else if (process == "Product Report") {
                Navigator.pushNamed(context, RouteList.productReportPage);
              }
            },
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              color: Colors.grey.shade50,
              borderOnForeground: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
      ),
    );
  }

  void _showSyncActionSelectWidget(
      {required List<SyncResponse> actionList, String? listTitle}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        List<String?> selectionList = [];
        actionList.forEach(
          (element) => selectionList.add(element.description),
        );
        return BottomSheetSelectionWidget(
            listTitle: "$listTitle Sync Action",
            selectedValueList: selectActionList,
            onTap: () {
              List<SyncResponse> syncList = [];
              actionList.forEachIndexed(
                (index, element) {
                  if (selectActionList.value[index]) {
                    syncList.add(element);
                  }
                },
              );

              MainSyncProcess.instance.startManualSyncProcess(syncList);
              context.pop();
              showDialog(
                context: context,
                builder: (context) {
                  return SyncProgressDialog(
                    key: _dialogKey,
                  );
                },
              );
            },
            selectionList: selectionList);
      },
    );
  }

  void manualSyncStreamListener() async {
    MainSyncProcess.instance.syncStream.listen((data) {
      if (!data.isAutoSync) {
        _dialogKey.currentState
            ?.changeProgress(actionName: data.name, percentage: data.progress);
        print("Sync Progress : ${data.toJson()} : ${data.progress}");
        if (data.isFinished) {
          print("Sync Complete");
          _dialogKey.currentState?.closeDialog();
          Future.delayed(const Duration(milliseconds: 300)).then((value) {
            _dialogKey.currentState?.closeDialog();
            if (data.message == MainSyncProcess.failMessage) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (context.mounted) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return CustomAlertDialog(
                          dialogType: AlertDialogType.error,
                          title: 'Sync Process',
                          content: '${data.name} fail',
                        );
                      });
                }
              });
            }
          });
        }
      }
    });
  }

// Widget buildQuickActions() {
//   int itemCount = 1; // Update with the number of items you want in the row
//   double containerWidth = MediaQuery.of(context).size.width / itemCount - 20; // Adjusts width based on screen size
//
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       buildQuickAction("Delivery Sync", Icons.sync, width: containerWidth),
//     ],
//   );
// }
//
//
// Widget buildQuickAction(String title, IconData icon, {double? width}) {
//   return Container(
//     decoration: BoxDecoration(
//         color: Colors.blueAccent,
//         borderRadius: BorderRadius.circular(5)),
//     height: 70,
//     width: width,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(color: Colors.white),
//         ),
//         Icon(
//           icon,
//           color: Colors.white,
//         ),
//       ],
//     ),
//   );
// }
}
