import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/stock_loading_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/common_widget/retry_widget.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../model/stock_move.dart';
import '../../src/const_string.dart';
import '../../src/style/app_color.dart';

class StockLoadingDetailPage extends StatefulWidget {
  const StockLoadingDetailPage({super.key});

  @override
  State<StockLoadingDetailPage> createState() => _StockLoadingDetailPageState();
}

class _StockLoadingDetailPageState extends State<StockLoadingDetailPage> {
  late StockLoadingCubit _batchCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _batchCubit = context.read<StockLoadingCubit>()
      ..fetchBatchByBarcode(barcode: "BATCH/00002");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOADING/00003"),
      ),
      persistentFooterButtons: [
        GestureDetector(
          onTap: () async{
            bool confirm = await MMTApplication.showConfirmDialog(confirmQuestion: "Do you want to cancel the loading?", context: context) ?? false;
          },
          child: Container(
            width: double.infinity,
            padding: 16.allPadding,
            decoration: BoxDecoration(
                color: AppColors.dangerColor, borderRadius: 8.borderRadius),
            child: const Center(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        )
      ],
      body: Column(
        children: [
          _loadingItemDetail(),
          const SizedBox(
            height: 16,
          ),
          _loadingItemTable()
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _loadingItemTable() {
    List<TableRow> tableRows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[200]),
        children: [

          _tableItem(ConstString.name, align: Alignment.centerLeft),
          _tableItem(ConstString.qty),
          _tableItem(ConstString.uom),
          _tableItem(''),
        ],
      )
    ];
    return BlocBuilder<StockLoadingCubit, StockLoadingState>(
      builder: (context, state) {
        if (state.state == BlocCRUDProcessState.fetching) {
          return const Center(
            child: CircularProgressIndicator(),
          ).expanded();
        } else if (state.state == BlocCRUDProcessState.fetchFail) {
          return RetryWidget(
            onRetry: () {},
          );
        } else {
          state.stockMoveList.forEach(
            (element) {
              print("Response : ${element.toJson()}");
              tableRows.add(_tableRow(stockMoveLine: element));
            },
          );
          return Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FlexColumnWidth(5),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(1),
            },
            children: tableRows,
          );
        }
      },
    );
  }

  Widget _tableItem(String text, {Alignment align = Alignment.centerRight}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  TableRow _tableRow({
    required StockMoveLine stockMoveLine,
  }) {
    return TableRow(children: [

      _tableItem(stockMoveLine.productName ?? '', align: Alignment.centerLeft),
      _tableItemList((stockMoveLine.data ?? [])
          .map(
            (e) => e.qty.toString(),
          )
          .toList()),
      _tableItemList((stockMoveLine.data ?? [])
          .map(
            (e) => e.productUomName ?? '',
          )
          .toList()),
      (stockMoveLine.isLot ?? false)
          ? Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () async {},
            icon: Icon(Icons.more_vert)),
      )
          : Container(),
    ]);
  }

  Widget _tableItemList(List<String> textList) {
    List<Widget> textWidgetList = [];

    textList.forEach(
      (element) => textWidgetList.add(Align(
          alignment: Alignment.centerRight,
          child: Text(element, style: TextStyle(fontWeight: FontWeight.bold)))),
    );

    return Padding(
      padding: 8.allPadding,
      child: Column(
        children: textWidgetList,
      ),
    );
  }

  Widget _loadingItemDetail() {
    return Container(
      padding: 16.allPadding,
      decoration:
          BoxDecoration(border: Border.all(), borderRadius: 4.borderRadius),
      child: Column(
        children: [
          _dataRow(title: "Date", text: "23/10/2024"),
          _dataRow(title: "Warehouse Person", text: "U Kyaw Khaing"),
          // _dataRow(title: "Employee", text: "23/10/2024"),
          _dataRow(title: "Driver(Car No)", text: "U Driver (34A/0032)"),
        ],
      ),
    );
  }

  Widget _dataRow({required String title, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(text, style: const TextStyle(fontSize: 14))
      ],
    );
  }
}
