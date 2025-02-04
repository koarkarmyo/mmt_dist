import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/style/app_color.dart';
import 'package:mmt_mobile/ui/widgets/date_range_picker_dialog.dart';

import '../common_widget/constant_widgets.dart';
import '../src/const_dimen.dart';
import '../src/enum.dart';
import '../src/mmt_application.dart';

class AccountPaymentPage extends StatefulWidget {
  const AccountPaymentPage({super.key});

  @override
  State<AccountPaymentPage> createState() => _AccountPaymentPageState();
}

class _AccountPaymentPageState extends State<AccountPaymentPage> {
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  double _lQty = 0;
  double _bQty = 0;
  late List<DateTime> dateRange = [];
  List<DateTime> defaultDate = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash in/out"),
        actions: [
          IconButton(
              onPressed: () {
                AccountPaymentTypes? paymentType;

                Dialog dialog = Dialog(
                  child: StatefulBuilder(builder: (context, innerState) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(
                                  ConstantDimens.normalPadding),
                              height: 40,
                              // color: ThemeColors.successColor,
                              child: const Text('Select cash in/ out',
                                  style: TextStyle(fontSize: 18)),
                              alignment: Alignment.centerLeft),
                          ConstantWidgets.SizedBoxHeight,
                          RadioListTile<AccountPaymentTypes>(
                            title: Text(
                                AccountPaymentTypes.outbound.getConstValue()),
                            value: AccountPaymentTypes.outbound,
                            groupValue: paymentType,
                            onChanged: (v) {
                              // if (MMTApplication.loginResponse?.allowCashOut ??
                              //     false)
                              //   innerState(() {
                              //     paymentType = AccountPaymentTypes.outbound;
                              //   });
                            },
                            dense: true,
                            // tileColor:
                            // MMTApplication.loginResponse?.allowCashOut ?? false
                            // ? null
                            // : Colors.grey.shade600,
                          ),
                          RadioListTile<AccountPaymentTypes>(
                            title: Text(
                                AccountPaymentTypes.inbound.getConstValue()),
                            value: AccountPaymentTypes.inbound,
                            groupValue: paymentType,
                            onChanged: (v) {
                              // if (MMTApplication.loginResponse?.allowCashIn ??
                              //     false)
                              //   innerState(() {
                              //     paymentType = AccountPaymentTypes.inbound;
                              //   });
                            },
                            dense: true,
                            // tileColor:
                            // MMTApplication.loginResponse?.allowCashIn ?? false
                            //     ? null
                            //     : Colors.grey.shade600,
                          ),
                          ConstantWidgets.SizedBoxHeight,
                          if (paymentType == null)
                            Container(
                              child: Text(
                                '*Select payment type',
                                style: TextStyle(color: AppColors.dangerColor),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(
                                  left: ConstantDimens.pagePadding),
                            ),
                          ConstantWidgets.SizedBoxHeight,

                          ElevatedButton(
                              onPressed: () {},
                              child: const Text(ConstString.confirm)),

                          // OkButtonWidget(
                          //     onPressed: () {
                          //       if (paymentType == null) {
                          //         innerState(() {});
                          //       } else {
                          //         context
                          //             .pushTo(paymentType ==
                          //             AccountPaymentTypes.outbound
                          //             ? RouteList
                          //             .journalAccountPaymentCreateOutboundPageRoute
                          //             : RouteList
                          //             .journalAccountPaymentCreateInboundPageRoute)
                          //             .then((value) {
                          //           context.pop();
                          //           callFilter();
                          //         });
                          //       }
                          //     },
                          //     text: 'Confirm'),
                          ConstantWidgets.SizedBoxHeight,
                        ],
                      ),
                    );
                  }),
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DateRangePickerKDialog(
                    (value) {
                      dateRange = value;
                      final fromDate = DateTime(dateRange.first.year,
                          dateRange.first.month, dateRange.first.day);
                      final toDate = DateTime(dateRange.last.year,
                          dateRange.last.month, dateRange.last.day + 1);
                      dateRange = [fromDate, toDate];
                      _dateFilter();
                    },
                    firstDate: DateTime(2021, 1, 1),
                    endDate: DateTime.now(),
                    showClearBtn: true,
                    onClear: () {
                      dateRange.clear();
                      _dateFilter();
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_alt_sharp),
                )
              ],
            )
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
}
