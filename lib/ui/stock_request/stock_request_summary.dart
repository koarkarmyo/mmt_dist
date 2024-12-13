import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/stock_order/stock_order_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/common_widget/animated_button.dart';
import 'package:mmt_mobile/src/extension/datetime_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/widgets/ke_text_field.dart';

import '../../business logic/bloc/location/location_cubit.dart';
import '../../model/stock_location.dart';
import '../../model/stock_order.dart';
import '../../src/const_string.dart';
import '../../src/style/app_styles.dart';
import '../widgets/ke_bottom_sheet_choice_widget.dart';

class StockRequestSummary extends StatefulWidget {
  const StockRequestSummary({super.key});

  @override
  State<StockRequestSummary> createState() => _StockRequestSummaryState();
}

class _StockRequestSummaryState extends State<StockRequestSummary> {
  StockLocation? _selectedLocation;
  late StockOrderBloc _stockOrderBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockOrderBloc = context.read<StockOrderBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(ConstString.stockRequestSummary),
      ),
      persistentFooterButtons: [
        SizedBox(
            width: double.infinity,
            child: AnimatedButton(
                buttonText: ConstString.confirm,
                status: ButtonStatus.start,
                buttonColor: Colors.black))
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _locationChoiceWidget(),
            const SizedBox(
              height: 16,
            ),
            _stockRequestDateWidget(),
            Divider(
              thickness: 10,
              color: Colors.grey.shade100,
            ).padding(padding: 16.verticalPadding),
            const Text(
              ConstString.stockOrderSummary,
              style: TextStyle(fontSize: 18),
            ).padding(padding: 16.verticalPadding),
            _requestTableHeader(),
            _requestListWidget(),
            Divider(
              thickness: 10,
              color: Colors.grey.shade100,
            ).padding(padding: 16.verticalPadding),
            _noteWidget()
          ],
        ).padding(padding: 16.allPadding),
      ),
    );
  }

  Widget _requestListWidget() {
    return BlocBuilder<StockOrderBloc, StockOrderState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.stockOrderLineList.length,
          shrinkWrap: true, // Prevent ListView from expanding
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _stockRequestItem(
                stockOrderLine: state.stockOrderLineList[index]);
          },
        );
      },
    );
  }

  Widget _stockRequestItem({required StockOrderLine stockOrderLine}) {
    return Row(
      children: [
        Text(stockOrderLine.productName ?? '').bold().expanded(flex: 3),
        Text(
          stockOrderLine.productUomName ?? '',
          textAlign: TextAlign.end,
        ).padding(padding: 8.horizontalPadding).expanded(flex: 2),
        Text(
          (stockOrderLine.productQty ?? 0).toString(),
          textAlign: TextAlign.end,
        ).padding(padding: 8.horizontalPadding).expanded(flex: 2)
      ],
    ).padding(padding: 8.verticalPadding);
  }

  Widget _noteWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ConstString.note,
          style: AppStyles.miniTitle,
        ),
        const KETextField(
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _requestTableHeader() {
    List<TableRow> tableRows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[200]),
        children: [
          _tableItem(ConstString.name, align: Alignment.centerLeft),
          _tableItem(ConstString.uom),
          _tableItem(ConstString.qty),
        ],
      )
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3)
      },
      children: tableRows,
    );
  }

  Widget _tableItem(String text, {Alignment align = Alignment.centerRight}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _stockRequestDateWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(ConstString.stockRequestDate),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Icon(Icons.calendar_month),
            const SizedBox(
              width: 10,
            ),
            Text(DateTime.now().format("dd-MM-yyyy")),
          ],
        )
      ],
    );
  }

  Widget _locationChoiceWidget() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ConstString.location,
              style: AppStyles.miniTitle,
            ),
            BlocBuilder<StockOrderBloc, StockOrderState>(
              builder: (context, stockOrderState) {
                return Text(stockOrderState.location?.name ?? '').padding(padding: 8.verticalPadding);
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}
