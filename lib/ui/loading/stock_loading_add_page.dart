import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/batch_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/common_widget/retry_widget.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/loading/stock_loading_add_lot.dart';

import '../../business logic/bloc/product/product_cubit.dart';
import '../../common_widget/text_widget.dart';
import '../../model/lot.dart';
import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/stock_move.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class StockLoadingAddPage extends StatefulWidget {
  const StockLoadingAddPage({super.key});

  @override
  State<StockLoadingAddPage> createState() => _StockLoadingAddPageState();
}

class _StockLoadingAddPageState extends State<StockLoadingAddPage> {
  late BatchCubit _batchCubit;
  String? _batchName;

  final TextEditingController _searchBatchController = TextEditingController();
  final ValueNotifier<List<StockMoveLine>> _stockMoveLineListNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _batchCubit = context.read<BatchCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(ConstString.loading),
        actions: [
          IconButton(
              onPressed: () {
                bool isAllCheck = true;
                for (StockMoveLine moveLine
                    in _stockMoveLineListNotifier.value) {
                  isAllCheck = moveLine.isChecked ?? false;
                  if (!isAllCheck) {
                    break;
                  }
                }

                print("All Check : $isAllCheck");
              },
              icon: const Icon(Icons.cloud_upload_rounded))
        ],
      ),
      persistentFooterButtons: [
        BlocBuilder<BatchCubit, BatchState>(
          builder: (context, state) {
            return TextWidget(
              '',
              dataList: [
                ConstString.total,
                ':',
                state.stockMoveList.length.toString()
              ],
              style: const TextStyle(fontSize: 20),
            );
          },
        )
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: 8.horizontalPadding,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: 12.borderRadius),
            child: Row(
              children: [
                TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  autofocus: false,
                  controller: _searchBatchController,
                  onEditingComplete: () {
                    _batchName = _searchBatchController.text;
                    _batchCubit.fetchBatchByBarcode(
                        barcode: _searchBatchController.text);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "BATCH NO/ SO NO/ PRODUCT NO",
                      hintStyle: TextStyle(fontSize: 14)),
                ).expanded(),
                _qrScanner()
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            ConstString.products,
            style: TextStyle(fontSize: 16),
          ),

          // _pickingListWidget()
          BlocBuilder<BatchCubit, BatchState>(
            builder: (context, state) {
              if (state.state == BlocCRUDProcessState.fetching) {
                return Center(
                  child: CircularProgressIndicator(),
                ).expanded();
              }
              if (state.state == BlocCRUDProcessState.fetchFail) {
                return RetryWidget(
                  onRetry: () {
                    _batchCubit.fetchBatchByBarcode(barcode: _batchName ?? '');
                  },
                );
              }
              return _pickingTableWidget(stockMoveList: state.stockMoveList);
            },
          )
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _pickingTableWidget({required List<StockMoveLine> stockMoveList}) {
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

    stockMoveList.forEach(
      (element) {
        tableRows.add(_tableRow(stockMoveLine: element));
      },
    );

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1)
      },
      children: tableRows,
    );
  }

  TableRow _tableRow({required StockMoveLine stockMoveLine}) {
    return TableRow(children: [
      _tableItem(stockMoveLine.productName ?? '', align: Alignment.centerLeft),
      _tableItem((stockMoveLine.productUomQty ?? 0).toString()),
      _tableItem(stockMoveLine.productUomName ?? ''),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: IconButton(
              alignment: Alignment.center,
              onPressed: () async {
                List<Lot> lotList = await showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ProductCubit(),
                      child: StockLoadingAddLot(
                        stockMoveLine: stockMoveLine,
                      ),
                    );
                  },
                );


              },
              icon: Icon(Icons.more_vert)),
        ),
      )
    ]);
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

  Widget _pickingListWidget() {
    return BlocBuilder<BatchCubit, BatchState>(
      builder: (context, state) {
        if (state.state == BlocCRUDProcessState.fetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == BlocCRUDProcessState.fetchFail) {
          return RetryWidget(onRetry: () {
            _batchCubit.fetchBatchByBarcode(barcode: _batchName ?? '');
          });
        }
        _stockMoveLineListNotifier.value = state.stockMoveList;
        return ValueListenableBuilder(
            valueListenable: _stockMoveLineListNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: state.stockMoveList.length,
                itemBuilder: (context, index) {
                  StockMoveLine stockMoveLine = state.stockMoveList[index];
                  return _pickingItemWidget(stockMoveLine: stockMoveLine);
                },
              );
            });
      },
    ).expanded();
  }

  Widget _pickingItemWidget({required StockMoveLine stockMoveLine}) {
    TextEditingController _qtyController = TextEditingController();
    TextEditingController _pcController = TextEditingController();
    TextEditingController _pkController = TextEditingController();

    return GestureDetector(
      onTap: () async {
        // String? lotNumber = await showModalBottomSheet(
        //   context: context,
        //   builder: (context) {
        //     return BottomChoiceSheetWidget<String>(
        //         itemList: ['LOT0001', 'LOT0002', 'LOT0008'],
        //         toItemString: (value) => value,
        //         title: "LOT");
        //   },
        // );
        //
        // if (lotNumber != null) {
        //   int index = _stockMoveLineListNotifier.value.indexWhere(
        //     (element) => element.moveId == stockMoveLine.moveId,
        //   );
        //   if (index > -1) {
        //     stockMoveLine.lotName = lotNumber;
        //     _stockMoveLineListNotifier.value[index] = stockMoveLine;
        //     _stockMoveLineListNotifier.value =
        //         List.from(_stockMoveLineListNotifier.value);
        //   }
        // }
        showDialog(
          context: context,
          builder: (context) {
            return BlocProvider(
              create: (context) => ProductCubit(),
              child: StockLoadingAddLot(
                stockMoveLine: stockMoveLine,
              ),
            );
          },
        );
      },
      child: Container(
        margin: 16.verticalPadding,
        padding: 16.allPadding,
        decoration:
            BoxDecoration(border: Border.all(), borderRadius: 8.borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stockMoveLine.productName ?? '').boldSize(16),
                const SizedBox(
                  height: 16,
                ),
                Text(
                    "${stockMoveLine.productUomQty} ${stockMoveLine.productUomName} | ${stockMoveLine.scheduledDate}"),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 260,
                  child: Wrap(
                    spacing: 8.0, // Horizontal spacing between cards
                    runSpacing: 8.0, // Vertical spacing between rows of cards
                    children: List.generate(
                      2, // Replace with the actual number of _lotCard() items
                      (index) => _lotCard(),
                    ),
                  ),
                ),
              ],
            ),
            Checkbox(
              value: stockMoveLine.isChecked ?? false,
              onChanged: (value) {
                int index = _stockMoveLineListNotifier.value.indexWhere(
                  (element) => element.moveId == stockMoveLine.moveId,
                );
                if (index > -1) {
                  stockMoveLine.isChecked = value;
                  _stockMoveLineListNotifier.value[index] = stockMoveLine;
                  _stockMoveLineListNotifier.value =
                      List.from(_stockMoveLineListNotifier.value);
                }
              },
            )
          ],
        ),
      ),
    );

    // Row(
    //   mainAxisSize: MainAxisSize.min,
    //   // Minimize column height
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   // Aligns widgets to the right
    //   children: MMTApplication.currentUser?.useLooseBox ?? false
    //       ? [
    //           SizedBox(
    //             width: 80, // Set a fixed width for the TextField
    //             child: TextField(
    //               keyboardType: TextInputType.number,
    //               onTap: () {
    //                 _pkController.selection = TextSelection(
    //                     baseOffset: 0,
    //                     extentOffset: _pkController.text.length);
    //               },
    //               onTapOutside: (event) {
    //                 // Unfocus when tapping anywhere outside the TextField
    //                 FocusScope.of(context).unfocus();
    //               },
    //               autofocus: false,
    //               controller: _pkController,
    //               onChanged: (value) {},
    //               decoration: const InputDecoration(
    //                   isDense: true,
    //                   // Reduces height of the TextField
    //                   contentPadding:
    //                       EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //                   border: OutlineInputBorder(),
    //                   hintText: 'PK',
    //                   label: Text("PK")),
    //             ),
    //           ),
    //           const SizedBox(width: 8),
    //           SizedBox(
    //             width: 80, // Set a fixed width for the TextField
    //             child: TextField(
    //               keyboardType: TextInputType.number,
    //               onTap: () {
    //                 _pcController.selection = TextSelection(
    //                     baseOffset: 0,
    //                     extentOffset: _pcController.text.length);
    //               },
    //               onTapOutside: (event) {
    //                 // Unfocus when tapping anywhere outside the TextField
    //                 FocusScope.of(context).unfocus();
    //               },
    //               autofocus: false,
    //               controller: _pcController,
    //               onChanged: (value) {},
    //               decoration: const InputDecoration(
    //                   isDense: true,
    //                   // Reduces height of the TextField
    //                   contentPadding:
    //                       EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //                   border: OutlineInputBorder(),
    //                   hintText: 'PC',
    //                   label: Text("PC")),
    //             ),
    //           ),
    //         ]
    //       : [
    //           SizedBox(
    //             width: 80, // Set a fixed width for the TextField
    //             child: TextField(
    //               keyboardType: TextInputType.number,
    //               onTap: () {
    //                 _qtyController.selection = TextSelection(
    //                     baseOffset: 0,
    //                     extentOffset: _qtyController.text.length);
    //               },
    //               onTapOutside: (event) {
    //                 // Unfocus when tapping anywhere outside the TextField
    //                 FocusScope.of(context).unfocus();
    //               },
    //               autofocus: false,
    //               controller: _qtyController,
    //               onChanged: (value) {},
    //               textAlign: TextAlign.right,
    //               decoration: const InputDecoration(
    //                 isDense: true, // Reduces height of the TextField
    //                 contentPadding:
    //                     EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //                 border: OutlineInputBorder(),
    //                 hintText: 'Qty',
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //               width: 8), // Spacing between TextField and Dropdown
    //           Container(
    //             padding: 7.allPadding,
    //             decoration: BoxDecoration(
    //                 border: Border.all(), borderRadius: 4.borderRadius),
    //             child: DropdownButton<UomLine>(
    //               value: product.uomLines?.firstOrNull,
    //               items: product.uomLines
    //                   ?.map((UomLine value) => DropdownMenuItem<UomLine>(
    //                         value: value,
    //                         child: Text(value.uomName ?? ''),
    //                       ))
    //                   .toList(),
    //               onChanged: (UomLine? newValue) {
    //                 // Handle selection change
    //               },
    //               hint: const Text('uom'),
    //               isDense: true,
    //             ),
    //           ),
    //         ],
    // ),
    // ).padding(padding: 8.verticalPadding);
  }

  Widget _lotCard() {
    return Container(
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          color: AppColors.primaryColorPale, borderRadius: 8.borderRadius),
      padding: 8.allPadding,
      child: const Text(
        "LOT000002 7 Kg",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _qrScanner() {
    return IconButton(
        onPressed: () async {
          String? barcode = await MMTApplication.scanBarcode(context: context);
          if (barcode != null) {
            _batchName = barcode;
            _batchCubit.fetchBatchByBarcode(barcode: barcode);
          }
        },
        icon: const Icon(Icons.qr_code));
  }
}
