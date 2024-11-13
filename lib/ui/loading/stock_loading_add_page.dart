import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/batch_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/common_widget/retry_widget.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../common_widget/text_widget.dart';
import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/stock_move.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';

class StockLoadingAddPage extends StatefulWidget {
  const StockLoadingAddPage({super.key});

  @override
  State<StockLoadingAddPage> createState() => _StockLoadingAddPageState();
}

class _StockLoadingAddPageState extends State<StockLoadingAddPage> {
  late BatchCubit _batchCubit;
  String? _batchName;

  final TextEditingController _searchBatchController = TextEditingController();

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
              onPressed: () {}, icon: const Icon(Icons.cloud_upload_rounded))
        ],
      ),
      persistentFooterButtons: const [
        TextWidget(
          '',
          dataList: [ConstString.total, ':', '7'],
          style: TextStyle(fontSize: 20),
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
                  controller: _searchBatchController,
                  onEditingComplete: () {
                    _batchName = _searchBatchController.text;
                    _batchCubit.fetchBatchByBarcode(
                        barcode: _searchBatchController.text);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "BATCH NO/ SO NO/ STOCK PICKING",
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
            "Batch List",
            style: TextStyle(fontSize: 16),
          ),
          _pickingListWidget()
        ],
      ).padding(padding: 16.allPadding),
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
        return ListView.builder(
          itemCount: state.stockMoveList.length,
          itemBuilder: (context, index) {
            StockMoveLine stockMoveLine = state.stockMoveList[index];
            return _pickingItemWidget(stockMoveLine: stockMoveLine);
          },
        );
      },
    ).expanded();
  }

  Widget _pickingItemWidget({required StockMoveLine stockMoveLine}) {
    TextEditingController _qtyController = TextEditingController();
    TextEditingController _pcController = TextEditingController();
    TextEditingController _pkController = TextEditingController();

    return ListTile(
        contentPadding: 10.horizontalPadding,
        // Adjust padding here
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        title: Text(stockMoveLine.productName ?? '').boldSize(16),
        subtitle: Text(
            "${stockMoveLine.productUomQty} ${stockMoveLine.productUomName}"),
        trailing: Checkbox(
          value: true,
          onChanged: (value) {},
        )
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
        ).padding(padding: 8.verticalPadding);
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
