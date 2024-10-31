import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/ui/widgets/date_range_picker_dialog.dart';
import 'package:mmt_mobile/ui/widgets/search_box_text_field_widget.dart';

import '../src/enum.dart';

class SaleOrderPage extends StatefulWidget {
  const SaleOrderPage({super.key});

  @override
  State<SaleOrderPage> createState() => _SaleOrderPageState();
}

class _SaleOrderPageState extends State<SaleOrderPage> {
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
        child: Column(
          children: [
            SearchBoxTextField(hintText: "Customer",),
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
            DateRangePickerKDialog((value) {
                  (value) {
                dateRange = value;
                final fromDate = DateTime(dateRange.first.year,
                    dateRange.first.month, dateRange.first.day);
                final toDate = DateTime(dateRange.last.year,
                    dateRange.last.month, dateRange.last.day + 1);
                dateRange = [fromDate, toDate];
                _dateFilter();
              };
              firstDate: DateTime(2021, 1, 1);
              endDate: DateTime.now();
              showClearBtn: true;
              onClear: () {
                dateRange.clear();
                dateRange = defaultDate;
                _dateFilter();
              };
            },)
          ],
        ),
      ),
    );
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
