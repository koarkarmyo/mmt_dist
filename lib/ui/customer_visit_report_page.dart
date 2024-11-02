import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/ui/widgets/date_range_picker_dialog.dart';

class CustomerVisitReportPage extends StatefulWidget {
  const CustomerVisitReportPage({super.key});

  @override
  State<CustomerVisitReportPage> createState() =>
      _CustomerVisitReportPageState();
}

class _CustomerVisitReportPageState extends State<CustomerVisitReportPage> {
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late List<DateTime> dateRange = [];
  double _lQty = 0;
  double _bQty = 0;
  List<DateTime> defaultDate = [];

  // Method to handle the date range selection
  void onDateRangeSelected(List<DateTime> dateRange) {
    setState(() {
      formattedDate =
          "${DateFormat('dd/MM/yyyy').format(dateRange[0])} - ${DateFormat('dd/MM/yyyy').format(dateRange[1])}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstString.custVisitReport),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {
                debugPrint("Printer On");
              },
              icon: const Icon(Icons.print),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DateRangePickerKDialog(
              (value) {
                dateRange = value;
                final fromDate = DateTime(dateRange.first.year,
                    dateRange.first.month, dateRange.first.day);
                final toDate = DateTime(dateRange.last.year,
                    dateRange.last.month, dateRange.last.day + 1);
                dateRange = [fromDate, toDate];
                _callFilter();
              },
              firstDate: DateTime(2021, 1, 1),
              endDate: DateTime.now(),
              showClearBtn: true,
              onClear: () {
                dateRange.clear();
                _callFilter();
              },
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25))),
            ),
          )
        ],
      ),
    );
  }

  void _callFilter() {
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
}
