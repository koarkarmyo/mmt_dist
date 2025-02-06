import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mmt_mobile/business%20logic/bloc/sale_order/sale_order_history/sale_order_history_cubit.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/route/route_list.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';
import 'package:mmt_mobile/src/style/app_color.dart';
import 'package:mmt_mobile/ui/widgets/date_range_picker_dialog.dart';
import 'package:mmt_mobile/ui/widgets/search_box_text_field_widget.dart';
import 'package:mmt_mobile/utils/date_time_utils.dart';

import '../../../src/enum.dart';
import '../model/sale_order/sale_order_6/sale_order.dart';

class SaleOrderHistoryPage extends StatefulWidget {
  const SaleOrderHistoryPage({super.key});

  @override
  State<SaleOrderHistoryPage> createState() => _SaleOrderHistoryPageState();
}

class _SaleOrderHistoryPageState extends State<SaleOrderHistoryPage> {
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late List<DateTime> dateRange = [];
  double _lQty = 0;
  double _bQty = 0;
  List<DateTime> defaultDate = [];
  String _name = '';
  String _customer = '';

  // final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<DeliveryFilterTypes> filterList = [DeliveryFilterTypes.all];

  // final List<List<String>> data = [
  //   ["Row 1, Col 1", "Done", "Row 1, Col 3"],
  //   ["Row 2, Col 1", "Done", "Row 2, Col 3"],
  //   ["Row 3, Col 1", "Due", "Row 3, Col 3"],
  // ];

  @override
  void initState() {
    // callFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstString.saleOrder),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            SearchBoxTextField(
              hintText: "Customer",
              clearBtnClicked: () {
                _customer = '';
                callFilter();
              },
              onChanged: (value) {
                _customer = value;
                callFilter();
              },
            ),
            ConstantWidgets.SizedBoxHeight,
            Row(
              children: [
                Expanded(
                  child: SearchBoxTextField(
                    hintText: 'SO name',
                    clearBtnClicked: () {
                      _name = '';
                      callFilter();
                    },
                    onChanged: (value) {
                      _name = value;
                      callFilter();
                    },
                  ),
                ),
                // ConstantWidgets.SizedBoxWidth,
                // _createDeliveryFilterWidget(),
              ],
            ),
            ConstantWidgets.SizedBoxHeight,
            DateRangePickerKDialog(
              (value) {
                dateRange = value;
                final fromDate = DateTime(dateRange.first.year,
                    dateRange.first.month, dateRange.first.day);
                final toDate = DateTime(dateRange.last.year,
                    dateRange.last.month, dateRange.last.day + 1);
                dateRange = [fromDate, toDate];
                callFilter();
              },
              firstDate: DateTime(2021, 1, 1),
              endDate: DateTime.now(),
              showClearBtn: true,
              onClear: () {
                dateRange.clear();
                callFilter();
              },
            ),
            ConstantWidgets.SizedBoxHeight,
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final double screenWidth = constraints.maxWidth;
                  final double col1Width = screenWidth * 0.6;
                  final double col2Width = screenWidth * 0.15;
                  final double col3Width = screenWidth * 0.25;

                  return BlocBuilder<SaleOrderHistoryCubit,
                      SaleOrderHistoryState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // color: AppColors.primaryColor,
                            child: Row(
                              children: [
                                Container(
                                  padding: 8.horizontalPadding,
                                  width: col1Width,
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SO ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "Customer ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width: col2Width,
                                    child: const Text(
                                      "Status",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                SizedBox(
                                  width: col3Width,
                                  child: const Text(
                                    "Done Date",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            itemCount: state.saleOrderList.length,
                            itemBuilder: (context, index) {
                              SaleOrder so = state.saleOrderList[index];
                              return GestureDetector(
                                onTap: () {
                                  MMTApplication.currentCustomer = ResPartner(
                                    id: so.partnerId,
                                    name: so.partnerName,
                                  );
                                  //
                                  so.orderLines?.forEach((element) {
                                    debugPrint(element.toJson().toString());
                                  });
                                  context.pushTo(
                                      route: RouteList.saleOrderPage,
                                      args: {
                                        'customer':
                                            MMTApplication.currentCustomer,
                                        'sale_order': so,
                                      });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        width: col1Width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(so.name ?? ''),
                                            Text(so.partnerName ?? ''),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: col2Width,
                                          child: Text(
                                              so.state?.name
                                                      .toFirstLetterCapital() ??
                                                  '',
                                              textAlign: TextAlign.center)),
                                      SizedBox(
                                        width: col3Width,
                                        child: Text(so.dateOrder ?? '',
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ).expanded()
                        ],
                      );
                    },
                  );
                },
              ),
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

  // _createDeliveryFilterWidget() {
  //   return StatefulBuilder(builder: (context, innerState) {
  //     return PopupMenuButton<DeliveryFilterTypes>(
  //       color: Colors.blue,
  //       onSelected: (value) {},
  //       itemBuilder: (context) {
  //         return [
  //           for (final filterType in DeliveryFilterTypes.values)
  //             PopupMenuItem(
  //               onTap: () {
  //                 if (filterType == DeliveryFilterTypes.all) {
  //                   filterList.clear();
  //                   filterList.add(filterType);
  //                 } else {
  //                   if (filterList.contains(DeliveryFilterTypes.all)) {
  //                     filterList.remove(DeliveryFilterTypes.all);
  //                   }
  //
  //                   if (filterList.contains(filterType)) {
  //                     filterList.remove(filterType);
  //                   } else {
  //                     filterList.add(filterType);
  //                   }
  //                   if (filterList.isEmpty) {
  //                     filterList.add(DeliveryFilterTypes.all);
  //                   }
  //                 }
  //                 innerState(() {});
  //                 callFilter();
  //               },
  //               value: filterType,
  //               child: Row(
  //                 children: [
  //                   Icon(filterList.contains(filterType)
  //                       ? Icons.check_box
  //                       : Icons.check_box_outline_blank_rounded),
  //                   ConstantWidgets.SizedBoxWidthL,
  //                   Text('${filterType.getConstValue()}')
  //                 ],
  //               ),
  //             ),
  //         ];
  //       },
  //       child: Container(
  //         width: 50,
  //         height: 50,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(5),
  //           border: Border.all(color: Colors.white),
  //         ),
  //         child: const Icon(Icons.tune),
  //       ),
  //     );
  //   });
  // }

  void callFilter() {
    String? start;
    String? end;
    if (dateRange.isNotEmpty) {
      DateTime startDate = DateTime(
          dateRange.first.year, dateRange.first.month, dateRange.first.day);
      start = DateTimeUtils.ddMmYYYFormatSlug.format(startDate);
      DateTime endDate = DateTime(
          dateRange.last.year, dateRange.last.month, dateRange.last.day);
      end = DateTimeUtils.ddMmYYYFormatSlug.format(endDate);
    }
    context.read<SaleOrderHistoryCubit>().fetch(
        so: _name,
        customer: _customer,
        fromToDate: start != null && end != null ? [start, end] : null);

    // if (dateRange.isNotEmpty) {
    //   DateTime startDate = DateTime(
    //       dateRange.last.year, dateRange.last.month, dateRange.last.day);
    //   DateTime endDate = DateTime(
    //       dateRange.last.year, dateRange.last.month, dateRange.last.day);
    // context.read<SaleOrderHistoryCubit>().fetch();
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
    // }
  }
}
