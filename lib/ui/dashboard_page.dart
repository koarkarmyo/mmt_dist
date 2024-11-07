import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/database/data_object.dart';
import 'package:mmt_mobile/database/db_repo/currency_db_repo.dart';
import 'package:mmt_mobile/database/db_repo/res_partner_repo.dart';
import 'package:mmt_mobile/database/product_repo/product_db_repo.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../business logic/bloc/dashboard/dashboard_cubit.dart';
import '../common_widget/alert_dialog.dart';
import '../common_widget/bottom_sheet_selection_widget.dart';
import '../common_widget/sync_progress_dialog.dart';
import '../model/dashboard.dart';
import '../route/route_list.dart';
import '../src/style/app_color.dart';
import '../sync/bloc/sync_action_bloc/sync_action_bloc_cubit.dart';
import '../sync/models/sync_response.dart';
import '../sync/sync_utils/main_sync_process.dart';
import 'package:collection/collection.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late SyncActionCubit _syncActionCubit;
  late AutoScrollController _scrollController;

  final ValueNotifier<int> selectedTitleIndexNotifier = ValueNotifier(0);
  ValueNotifier<List<bool>> selectActionList = ValueNotifier([]);
  GlobalKey<SyncProgressDialogState> _dialogKey = GlobalKey();
  StreamSubscription? _masterSyncStream;
  late DashboardCubit _dashboardCubit;
  List<Dashboard> _dashboardList = [];

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
        newIndex < _dashboardList.length) {
      selectedTitleIndexNotifier.value = newIndex;
    }
  }

  @override
  void initState() {
    _scrollController = AutoScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
    manualSyncStreamListener();
    _syncActionCubit = context.read<SyncActionCubit>()
      ..getSyncAction(isManualSync: true);
    _dashboardCubit = context.read<DashboardCubit>()..getDashboard();
  }

  Future<void> _scrollToIndex(int index) async {
    await _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _scrollController
        .highlight(index); // Optional: highlight the scrolled-to item
  }

  @override
  void dispose() {
    selectedTitleIndexNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
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
            Text(MMTApplication.currentUser?.name ?? '',
                style: const TextStyle(fontSize: 18)),
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
              return StreamBuilder(
                  stream: MainSyncProcess.instance.syncStream,
                  builder: (context, snapshot) {
                    if (MainSyncProcess.instance.syncProcessIsRunning) {
                      bool isAutoSync = snapshot.data?.isAutoSync ?? false;

                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 1),
                            content: const Text("Auto Sync is in progress. Please wait"),
                            backgroundColor: AppColors.dangerColor,
                          ));
                        },
                        child: Row(
                          children: [
                            Text(
                              "Auto Sync",
                              style: TextStyle(color: AppColors.dangerColor),
                            ).padding(padding: 8.horizontalPadding),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: CircularProgressIndicator.adaptive(
                                    backgroundColor: isAutoSync
                                        ? AppColors.dangerColor
                                        : AppColors.primaryColor,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                    strokeWidth: 3),
                              ),
                            ).padding(padding: const EdgeInsets.only(right: 16))
                          ],
                        ),
                      );
                    }

                    return PopupMenuButton<String>(
                      color: Colors.white,
                      onSelected: (String value) {
                        // Handle the selected value
                        _showSyncActionSelectWidget(
                            listTitle: value,
                            actionList: state.actionList
                                .where(
                                  (element) => element.checkActionGroup(
                                      groupName: value),
                                )
                                .toList());
                      },
                      itemBuilder: (BuildContext context) =>
                          state.actionGroupList
                              .map((item) => PopupMenuItem<String>(
                                    value: item.name,
                                    child: Text(item.name ?? ''),
                                  ))
                              .toList(),
                      icon: const Icon(Icons.sync), // This is the IconButton
                    );
                  });
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              MainSyncProcess.instance
                  .setAutoSyncActions('MASTER', isImmediate: false);
            },
            child: const Text(
              "Dashboard",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ).padding(padding: 10.allPadding),
          ),
          buildWorkingPart(),
          // Move the process list to follow the title list
        ],
      ),
    );
  }

  Widget buildWorkingPart() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        print("Dashboard State : ${state.state}");
        if (state.state == BlocCRUDProcessState.fetching) {
          return const CircularProgressIndicator();
        } else if (state.state == BlocCRUDProcessState.fetchSuccess) {
          return ValueListenableBuilder<int>(
            valueListenable: selectedTitleIndexNotifier,
            builder: (context, selectedTitleIndex, _) {
              // List<String> processes = processLists[selectedTitleIndex];
              _dashboardList = [
                Dashboard(
                    groupName: 'Sale',
                    dashboardName: 'Sale Order',
                    actionUrl: 'today_order'),
                Dashboard(groupName: 'Sale', dashboardName: 'Sale Report',
                actionUrl: RouteList.saleOrderPage
                ),
                Dashboard(groupName: 'Delivery', dashboardName: 'Loading')
              ];

              List<Dashboard> dashboardList = state.dashboardList;
              List<String> groupList = _dashboardList
                  .map(
                    (e) => e.groupName ?? '',
                  )
                  .toSet()
                  .toList();

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleList(
                        dashboardGroupList: groupList,
                        selectedTitleIndex: selectedTitleIndex),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidgets.SizedBoxHeight,
                                Text(
                                  titles[selectedTitleIndex],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ).padding(
                                  padding: 5.allPadding,
                                ),
                                const SizedBox(height: 5),
                                buildProcessList(_dashboardList
                                    .where(
                                      (element) =>
                                          element.groupName ==
                                          groupList[selectedTitleIndex],
                                    )
                                    .toList())
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
        } else {
          return const Center(
            child: Text("Dashboard Not Found"),
          );
        }
      },
    );
  }

  Widget buildTitleList(
      {required List<String> dashboardGroupList,
      required int selectedTitleIndex}) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: List.generate(dashboardGroupList.length, (index) {
            return AutoScrollTag(
              index: index,
              controller: _scrollController,
              key: ValueKey(index),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    _scrollToIndex(index);
                    // selectedTitleIndexNotifier.value = index;
                  },
                  child: Container(
                    width: 250,
                    height: selectedTitleIndex == index ? 80 : 70,
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
                          fontSize: selectedTitleIndex == index ? 16 : 14,
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
              ),
            );
          }),
        ),
      ),
    );
  }

  Expanded buildProcessList(List<Dashboard> dashboardList) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 6,
          childAspectRatio: 0.8,
        ),
        itemCount: dashboardList.length,
        itemBuilder: (context, index) {
          final process = dashboardList[index];
          return InkWell(
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.lightBlueAccent,
            borderRadius: 14.borderRadius,
            onTap: () {
              debugPrint("Process clicked: $process");
              if (process.actionUrl != null) {
                context.pushTo(route: process.actionUrl!);
              }
              // if (process == "Route") {
              //   Navigator.pushNamed(context, RouteList.routePage);
              // } else if (process == "Contact") {
              //   Navigator.pushNamed(context, RouteList.contactPage);
              // } else if (process == "Product Report") {
              //   Navigator.pushNamed(context, RouteList.productReportPage);
              // } else if (process == "Customer Visit") {
              //   Navigator.pushNamed(context, RouteList.customerVisitPage);
              // } else if (process == "Today Order") {
              //   Navigator.pushNamed(context, RouteList.todayOrderPage);
              // } else if (process == "Today Delivery") {
              //   Navigator.pushNamed(context, RouteList.todayDeliveryPage);
              // } else if (process == "Account Payments") {
              //   Navigator.pushNamed(context, RouteList.accountPayment);
              // }
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
                      process.dashboardName ?? '',
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
