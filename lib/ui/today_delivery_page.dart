import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/ui/widgets/date_range_picker_dialog.dart';
import 'package:mmt_mobile/ui/widgets/search_box_text_field_widget.dart';

import '../src/enum.dart';

class TodayDeliveryPage extends StatefulWidget {
  const TodayDeliveryPage({super.key});

  @override
  State<TodayDeliveryPage> createState() => _TodayDeliveryPageState();
}

class _TodayDeliveryPageState extends State<TodayDeliveryPage> {
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late List<DateTime> dateRange = [];
  double _lQty = 0;
  double _bQty = 0;
  List<DateTime> defaultDate = [];
  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<DeliveryFilterTypes> filterList = [DeliveryFilterTypes.all];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ConstString.saleOrder),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            SearchBoxTextField(
              hintText: "Customer",
            ),
            ConstantWidgets.SizedBoxHeight,
            Row(
              children: [
                Expanded(
                  child: SearchBoxTextField(
                    clearBtnClicked: () {
                      // name = null;
                      callFilter();
                    },
                    hintText: 'SO name',
                    onChanged: (value) {
                      // name = value;
                      callFilter();
                    },
                  ),
                ),
                ConstantWidgets.SizedBoxWidth,
                _createDeliveryFilterWidget(),
              ],
            ),
            ConstantWidgets.SizedBoxHeight,
            DateRangePickerKDialog(
              (value) {
                (value) {
                  dateRange = value;
                  final fromDate = DateTime(dateRange.first.year,
                      dateRange.first.month, dateRange.first.day);
                  final toDate = DateTime(dateRange.last.year,
                      dateRange.last.month, dateRange.last.day + 1);
                  dateRange = [fromDate, toDate];
                  _dateFilter();
                };
                firstDate:
                DateTime(2021, 1, 1);
                endDate:
                DateTime.now();
                showClearBtn:
                true;
                onClear:
                () {
                  dateRange.clear();
                  dateRange = defaultDate;
                  _dateFilter();
                };
              },
            ),
            ConstantWidgets.SizedBoxHeight,
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double screenWidth = constraints.maxWidth;
                final double col1Width = screenWidth * 0.6;
                final double col2Width = screenWidth * 0.15;
                final double col3Width = screenWidth * 0.25;

                return Table(
                  border: TableBorder.all(), // Adds border to the table
                  columnWidths: {
                    0: FixedColumnWidth(col1Width),
                    // Sets width for each column (optional)
                    1: FlexColumnWidth(col2Width),
                    // Flex width takes remaining space
                    2: FixedColumnWidth(col3Width),
                  },

                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [

                    // ...data.map((row) {
                    //   return TableRow(
                    //     children: row.map((cell) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(cell, textAlign: TextAlign.center),
                    //       );
                    //     }).toList(),
                    //   );
                    // }).toList(),


                    TableRow(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("SO "),
                              Text("Customer "),
                            ],
                          ),
                        ),
                        Text("Status", textAlign: TextAlign.center),
                        Text("Done Date", textAlign: TextAlign.center),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("SO2410260000028"),
                              Text("Myat Thit Sar"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text("Done"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text("31/10/24"),
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:10.0,vertical: 5),
                          child: Text("Row 2, Col 1"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text("Done"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text("31/10/24"),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ]),
        ));
  }

  void _dateFilter() {
    _lQty = 0;
    _bQty = 0;
    // if (_filter == SaleOrderReportFilter.unsoldProduct) {
    //   _saleOrderReportBloc.add(
    //     FetchUnsoldProductReportEvent(
    //         startDate: dateRange.first.toString(),
    //         endDate: dateRange.last.toString()),
    //   );
    // } else {
    //   _saleOrderReportBloc.add(
    //     FetchSaleOrderReportEvent(
    //         startDate: dateRange.first.toString(),
    //         endDate: dateRange.last.toString()),
    //   );
  }

  _createDeliveryFilterWidget() {
    return StatefulBuilder(builder: (context, innerState) {
      return PopupMenuButton<DeliveryFilterTypes>(
        color: Colors.blue,
        onSelected: (value) {},
        itemBuilder: (context) {
          return [
            for (final filterType in DeliveryFilterTypes.values)
              PopupMenuItem(
                onTap: () {
                  if (filterType == DeliveryFilterTypes.all) {
                    filterList.clear();
                    filterList.add(filterType);
                  } else {
                    if (filterList.contains(DeliveryFilterTypes.all)) {
                      filterList.remove(DeliveryFilterTypes.all);
                    }

                    if (filterList.contains(filterType)) {
                      filterList.remove(filterType);
                    } else {
                      filterList.add(filterType);
                    }
                    if (filterList.isEmpty) {
                      filterList.add(DeliveryFilterTypes.all);
                    }
                  }
                  innerState(() {});
                  callFilter();
                },
                value: filterType,
                child: Row(
                  children: [
                    Icon(filterList.contains(filterType)
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_rounded),
                    ConstantWidgets.SizedBoxWidthL,
                    Text('${filterType.getConstValue()}')
                  ],
                ),
              ),
          ];
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white),
          ),
          child: Icon(Icons.tune),
        ),
      );
    });
  }

  void callFilter() {
    if (dateRange.isNotEmpty) {
      DateTime endDate = DateTime(
          dateRange.last.year, dateRange.last.month, dateRange.last.day);
      // Fluttertoast.showToast(
      //     msg: "${dateRange.first.toString()} \n${endDate.toString()}",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     textColor: Colors.white);

      //   _orderHistoryBloc.add(OrderHistoryCustFetchByDateRangeEvent(
      //       soNo: name,
      //       customerName: customerName,
      //       startDate: dateRange.first.toString(),
      //       endDate: endDate.toString(),
      //       custId: -1,
      //       saleOrderReqType: saleOrderReqTypes,
      //       deliveryStatus: DeliveryStatus.assigned,
      //       deliveryFilterType: _deliveryFilterTypes,
      //       filterList: filterList));
      // } else {
      //   _orderHistoryBloc.add(OrderHistoryCustFetchByDateRangeEvent(
      //       deliveryStatus: DeliveryStatus.assigned,
      //       soNo: name,
      //       custId: -1,
      //       saleOrderReqType: saleOrderReqTypes,
      //       deliveryFilterType: _deliveryFilterTypes,
      //       filterList: filterList));
    }
  }
}
