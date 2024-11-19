import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/batch_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/business%20logic/bloc/lot/lot_cubit.dart';
import 'package:mmt_mobile/common_widget/retry_widget.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/loading/stock_loading_add_lot.dart';
import 'package:collection/collection.dart';

import '../../business logic/bloc/product/product_cubit.dart';
import '../../common_widget/text_widget.dart';
import '../../model/lot.dart';
import '../../model/product/product.dart';
import '../../model/product/uom_lines.dart';
import '../../model/stock_move.dart';
import '../../src/const_string.dart';
import '../../src/enum.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_color.dart';

class StockLoadingAddPage extends StatefulWidget {
  const StockLoadingAddPage({super.key});

  @override
  State<StockLoadingAddPage> createState() => _StockLoadingAddPageState();
}

class _StockLoadingAddPageState extends State<StockLoadingAddPage> {
  late BatchCubit _batchCubit;
  late ProductCubit _productCubit;
  String? _batchName;
  late LotCubit _lotCubit;

  final TextEditingController _searchBatchController = TextEditingController();
  final ValueNotifier<List<StockMoveLine>> _stockMoveLineListNotifier =
      ValueNotifier([]);
  List<Product> _productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _batchCubit = context.read<BatchCubit>();
    _productCubit = context.read<ProductCubit>()..getAllProduct();
    _lotCubit = context.read<LotCubit>()..fetchLot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(ConstString.loading),
        actions: [
          BlocBuilder<BatchCubit, BatchState>(
            builder: (context, state) {
              if (state.state == BlocCRUDProcessState.updating) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                  onPressed: () {
                    bool isAllCheck = true;
                    bool lotCheck = true;
                    for (StockMoveLine moveLine
                        in _stockMoveLineListNotifier.value) {
                      isAllCheck = moveLine.isChecked ?? false;
                      if (!isAllCheck) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(ConstString.pleaseCheckAllItem),
                            backgroundColor: AppColors.dangerColor,
                          ),
                        );
                      }
                    }

                    if (isAllCheck) {
                      List<Lot> lotList = [];
                      _stockMoveLineListNotifier.value.forEach(
                        (element) {
                          if (element.isLot ?? false) {
                            if ((element.lotList ?? []).isEmpty) {
                              lotCheck = false;
                            }
                          }
                          lotList.addAll(element.lotList ?? []);
                        },
                      );

                      if (!lotCheck) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const TextWidget(ConstString.lotRequired),
                            backgroundColor: AppColors.dangerColor,
                          ),
                        );
                      } else {
                        _batchCubit.uploadDoneQty(
                            stockMoveList: _stockMoveLineListNotifier.value,
                            lotList: lotList,
                            productList: _productList);
                      }
                    }
                  },
                  icon: const Icon(Icons.cloud_upload_rounded));
            },
          )
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
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              return BlocBuilder<BatchCubit, BatchState>(
                builder: (context, state) {
                  if (productState.state == BlocCRUDProcessState.fetching ||
                      state.state == BlocCRUDProcessState.fetching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ).expanded();
                  }
                  if (state.state == BlocCRUDProcessState.fetchFail ||
                      productState.state == BlocCRUDProcessState.fetchFail) {
                    return RetryWidget(
                      onRetry: () {
                        _batchCubit.fetchBatchByBarcode(
                            barcode: _batchName ?? '');
                      },
                    );
                  }
                  _stockMoveLineListNotifier.value = state.stockMoveList;
                  _productList = productState.productList;

                  state.stockMoveList.forEachIndexed(
                    (stockMoveIndex, stockMoveLine) {
                      int index = productState.productList.indexWhere(
                          (product) => product.id == stockMoveLine.productId);
                      if (index != -1) {
                        if (productState.productList[index].trackingType ==
                            TrackingType.lot) {
                          state.stockMoveList[stockMoveIndex].isLot = true;
                        }
                      }
                    },
                  );

                  return _pickingTableWidget(
                      stockMoveList: state.stockMoveWithTotalList ?? []);
                },
              );
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
          _tableItem(''),
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
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(5),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(1)
      },
      children: tableRows,
    );
  }

  TableRow _tableRow({
    required StockMoveLine stockMoveLine,
  }) {
    return TableRow(children: [
      (stockMoveLine.isLot ?? false)
          ? Align(
              alignment: Alignment.centerLeft,
              child: BlocBuilder<LotCubit, LotState>(
                builder: (context, state) {
                  return IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () async {
                        print("Button pressed");
                        List<Lot>? lotList = await showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => ProductCubit(),
                              child: StockLoadingAddLot(
                                stockMoveLine: stockMoveLine,
                                lotList: state.lotList
                                    .where(
                                      (element) =>
                                          element.productId ==
                                          stockMoveLine.productId,
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        );

                        int index = _stockMoveLineListNotifier.value.indexWhere(
                          (element) => element.moveId == stockMoveLine.moveId,
                        );
                        if (index > -1) {
                          _stockMoveLineListNotifier.value[index].lotList =
                              lotList;
                        }
                      },
                      icon: Icon(Icons.more_vert));
                },
              ),
            )
          : Container(),
      _tableItem(stockMoveLine.productName ?? '', align: Alignment.centerLeft),
      // _tableItem((stockMoveLine.productUomQty ?? 0).toString()),
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

      ValueListenableBuilder(
        valueListenable: _stockMoveLineListNotifier,
        builder: (context, value, child) => Checkbox(
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
        ),
      ),
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
