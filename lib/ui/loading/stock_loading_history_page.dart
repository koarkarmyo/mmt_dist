import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../src/const_string.dart';
import '../../src/style/app_styles.dart';

class StockLoadingHistoryPage extends StatefulWidget {
  const StockLoadingHistoryPage({super.key});

  @override
  State<StockLoadingHistoryPage> createState() =>
      _StockLoadingHistoryPageState();
}

class _StockLoadingHistoryPageState extends State<StockLoadingHistoryPage> {
  ValueNotifier<DateTime?> _filterDateNotifier = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstString.loadingHistory),
      ),
      body: Column(
        children: [_dateChoiceWidget(), _loadingHistoryListWidget()],
      ),
    );
  }

  Widget _dateChoiceWidget() {
    return GestureDetector(
      onTap: () async {
        _filterDateNotifier.value = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000, 5, 1),
            lastDate: DateTime.now().add(const Duration(days: 30)));
      },
      child: Container(
          margin: 16.horizontalPadding,
          padding: (8, 16).padding,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: 8.borderRadius,
          ),
          child: ValueListenableBuilder(
            valueListenable: _filterDateNotifier,
            builder: (context, value, child) {
              return Text("Date : ${DateFormat('yyyy-MM-dd').format(_filterDateNotifier.value!)}");
            },
          )),
    );
  }

  Widget _loadingHistoryListWidget() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade300,
          thickness: 5,
        );
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        return _loadingHistoryItem();
      },
    ).expanded();
  }

  Widget _loadingHistoryItem() {
    return Container(
      // decoration:
      //     BoxDecoration(border: Border.all(), borderRadius: 8.borderRadius),
      padding: 16.allPadding,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("LOADING/0003").boldSize(17),
          const Divider(),
          _dataRow(title: "Date", text: "23/10/2024"),
          _dataRow(title: "Warehouse Person", text: "U Kyaw Khaing"),
          _dataRow(title: "Employee", text: "23/10/2024"),
          _dataRow(title: "Driver(Car No)", text: "U Driver (34A/0032)"),
        ],
      ),
    );
  }

  Widget _dataRow({required String title, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(text)],
    );
  }
}