import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/stock_loading_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/location/location_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/stock_order/stock_order_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/widgets/ke_bottom_sheet_choice_widget.dart';
import 'package:collection/collection.dart';

import '../../common_widget/text_widget.dart';
import '../../model/product/uom_lines.dart';
import '../../model/stock_location.dart';
import '../../model/stock_order.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';
import '../../src/style/app_styles.dart';

class StockRequestListPage extends StatefulWidget {
  const StockRequestListPage({super.key});

  @override
  State<StockRequestListPage> createState() => _StockRequestListPageState();
}

class _StockRequestListPageState extends State<StockRequestListPage> {
  late LocationCubit _locationCubit;
  late StockOrderBloc _stockOrderBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationCubit = context.read<LocationCubit>()..getAllStockLocation();
    _stockOrderBloc = context.read<StockOrderBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Stock Request Page"),
        actions: [
          IconButton(
              onPressed: () {
                context.pushTo(route: RouteList.stockRequestAddPage);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Column(
        children: [
          _locationChoiceWidget(),
          const SizedBox(
            height: 20,
          ),
          _productTableHeaderWidget(),
          _stockRequestListWidget()
        ],
      ).padding(padding: 16.allPadding),
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

                return KESingleChoiceWidget<StockLocation>(
                  valueList: state.locationList,
                  selectedValue: stockOrderState.location,
                  getDisplayString: (value) => value.name ?? '',
                  onSelected: (value) {
                    if (value != null) {
                      _stockOrderBloc
                          .add(StockOrderLocationUpdateEvent(location: value));
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _productTableHeaderWidget() {
    List<TableRow> tableRows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[200]),
        children: [
          _tableItem(ConstString.name, align: Alignment.centerLeft),
          _tableItem(ConstString.balance),
          _tableItem(ConstString.uom),
          _tableItem(ConstString.qty),
        ],
      )
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2)
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

  Widget _stockRequestListWidget() {
    return Expanded(
      child: BlocBuilder<StockOrderBloc, StockOrderState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.stockOrderLineList.length,
            itemBuilder: (context, index) {
              StockOrderLine stockOrderLine = state.stockOrderLineList[index];
              stockOrderLine.controller ??= TextEditingController();
              return _stockRequestRow(
                  stockOrderLine: state.stockOrderLineList[index]);
            },
          );
        },
      ),
    );
  }

  Widget _stockRequestRow({required StockOrderLine stockOrderLine}) {
    return Slidable(
      endActionPane:
      ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
            backgroundColor: AppColors.dangerColor,
            onPressed: (context) {
              _stockOrderBloc.add(StockOrderLineAddEvent(stockOrderLine: stockOrderLine));
            },
            label: "Delete",
            icon: Icons.delete)
      ]),
      child: Container(
        padding: 8.allPadding,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Text(stockOrderLine.productName ?? '')
                .bold()
                .padding(padding: 4.horizontalPadding)
                .expanded(flex: 3),
            const Text("34 Dozen / 3 Units")
                .padding(padding: 4.horizontalPadding)
                .expanded(flex: 2),
            Container(
              margin: 8.horizontalPadding,
              width: 200,
              child: DropdownButton<UomLine>(
                isExpanded: true,
                value: stockOrderLine.productUom != null
                    ? stockOrderLine.product?.uomLines?.firstWhereOrNull(
                        (element) => element.uomId == stockOrderLine.productUom,
                      )
                    : stockOrderLine.product?.uomLines?.firstOrNull,
                items: stockOrderLine.product?.uomLines
                    ?.map((UomLine value) => DropdownMenuItem<UomLine>(
                          value: value,
                          child: Text(value.uomName ?? ''),
                        ))
                    .toList(),
                onChanged: (UomLine? newValue) {
                  // Handle selection change
                  _stockOrderBloc.add(StockOrderLineUpdateEvent(
                      stockOrderLine: stockOrderLine.copyWith(
                          productUomName: newValue?.uomName,
                          productUom: newValue?.uomId)));
                },
                hint: const Text('uom'),
                isDense: true,
              ),
            ).expanded(flex: 2),
            TextField(
              onTap: () {
                stockOrderLine.controller?.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: stockOrderLine.controller?.text.length ?? 0);
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                _stockOrderBloc.add(StockOrderLineUpdateEvent(
                    stockOrderLine: stockOrderLine.copyWith(
                        productQty: double.tryParse(value) ?? 0)));
              },
              keyboardType: TextInputType.number,
              controller: stockOrderLine.controller,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: ConstString.qty),
            ).padding(padding: 8.horizontalPadding).expanded(flex: 2),
          ],
        ),
      ),
    );
  }
}
