import 'package:flutter/material.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../common_widget/text_widget.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';

class StockLoadingHistory extends StatefulWidget {
  const StockLoadingHistory({super.key});

  @override
  State<StockLoadingHistory> createState() => _StockLoadingHistoryState();
}

class _StockLoadingHistoryState extends State<StockLoadingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(ConstString.loading),
        actions: [
          IconButton(
              onPressed: () {
                context.pushTo(route: RouteList.stockLoadingAddPage);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchTextField(),
          const SizedBox(
            height: 32,
          ),
          const TextWidget(ConstString.history),
          _loadingHistory()
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _loadingHistory() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
            margin: 8.verticalPadding,
            padding: 16.allPadding,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: 16.borderRadius),
            child: Row(
              children: [
                Container(
                  padding: 8.allPadding,
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      borderRadius: 8.borderRadius,
                      color: Colors.greenAccent),
                  child: const Text("Done"),
                ),
                const SizedBox(
                  width: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("BATCH00023").boldSize(14),
                        Text("26/11/2024")
                      ],
                    ),
                    const Text("Employee Name")
                  ],
                ).expanded()
              ],
            )

            // ListTile(
            //   title: Text("BATCH00023"),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Text("Employee Name"),
            //       Text("26/11/2024"),
            //     ],
            //   ),
            //   trailing: Container(
            //     padding: 8.allPadding,
            //     decoration: BoxDecoration(
            //       // border: Border.all(),
            //       borderRadius: 8.borderRadius,
            //       color: Colors.greenAccent
            //     ),
            //     child: Text("Done"),
            //   ),
            // ),
            );
      },
    ).expanded();
  }

  Widget _searchTextField() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(), borderRadius: 8.borderRadius),
      padding: 16.horizontalPadding,
      child: Row(
        children: [
          const TextField(
            decoration:
                InputDecoration(border: InputBorder.none, hintText: "Search"),
          ).expanded(),
          const Icon(Icons.search)
        ],
      ),
    );
  }
}
