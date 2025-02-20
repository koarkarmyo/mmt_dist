import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/stock_loading_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/business%20logic/bloc/lot/lot_cubit.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/common_widget/animated_button.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/common_widget/retry_widget.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/loading/stock_loading_add_lot.dart';

import '../../business logic/bloc/product/product_cubit.dart';
import '../../common_widget/text_widget.dart';
import '../../model/lot.dart';
import '../../model/product/product_product.dart';
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
  late StockLoadingCubit _stockLoadingCubit;
  late ProductCubit _productCubit;
  String? _batchName;
  late LotCubit _lotCubit;

  final TextEditingController _searchBatchController = TextEditingController();

  // final ValueNotifier<List<StockMoveLine>> _stockMoveLineListNotifier =
  //     ValueNotifier([]);
  List<ProductProduct> _productList = [];

  // TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockLoadingCubit = context.read<StockLoadingCubit>();
    _productCubit = context.read<ProductCubit>()..getAllProduct();
    _lotCubit = context.read<LotCubit>()..fetchLot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const TextWidget(ConstString.loading),
        actions: [
          // BlocConsumer<StockLoadingCubit, StockLoadingState>(
          //   listener: (context, state) {
          //     if (state.state == BlocCRUDProcessState.updateFail) {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return CustomAlertDialog(dialogType: AlertDialogType.fail);
          //         },
          //       );
          //     } else if (state.state == BlocCRUDProcessState.updateSuccess) {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return CustomAlertDialog(
          //               dialogType: AlertDialogType.success);
          //         },
          //       );
          //     }
          //   },
          //   builder: (context, state) {
          //     if (state.state == BlocCRUDProcessState.updating) {
          //       return const CircularProgressIndicator();
          //     }
          //     return BlocBuilder<StockLoadingCubit, StockLoadingState>(
          //       builder: (context, state) {
          //         if (state.state == BlocCRUDProcessState.updateSuccess) {
          //           return Container();
          //         }
          //         return IconButton(
          //             onPressed: () async {
          //               bool isAllCheck = true;
          //               bool lotCheck = true;
          //               for (StockMoveLine moveLine
          //                   in state.stockMoveWithTotalList) {
          //                 isAllCheck = moveLine.isChecked ?? false;
          //                 if (!isAllCheck) {
          //                   break;
          //                 }
          //               }
          //
          //               if (state.stockMoveWithTotalList.isEmpty) {
          //                 isAllCheck = false;
          //               }
          //
          //               if (isAllCheck) {
          //                 List<Lot> lotList = [];
          //                 state.stockMoveWithTotalList.forEach(
          //                   (element) {
          //                     if (element.isLot ?? false) {
          //                       if ((element.lotList ?? []).isEmpty) {
          //                         lotCheck = false;
          //                       }
          //                     }
          //                     lotList.addAll(element.lotList ?? []);
          //                     print("Lot length : ${element.lotList?.length}");
          //                     element.lotList?.forEach(
          //                       (element) {
          //                         print("Lot : ${element.toJson()}");
          //                       },
          //                     );
          //                   },
          //                 );
          //
          //                 if (!lotCheck) {
          //                   ScaffoldMessenger.of(context).showSnackBar(
          //                     SnackBar(
          //                       content:
          //                           const TextWidget(ConstString.lotRequired),
          //                       backgroundColor: AppColors.dangerColor,
          //                     ),
          //                   );
          //                 } else {
          //                   bool confirm =
          //                       await MMTApplication.showConfirmDialog(
          //                               confirmQuestion:
          //                                   ConstString.loadingConfirmDialog,
          //                               context: context) ??
          //                           false;
          //
          //                   if (confirm) {
          //                     _stockLoadingCubit.uploadDoneQty(
          //                         stockMoveList: state.stockMoveWithTotalList,
          //                         lotList: lotList,
          //                         productList: _productList);
          //                   }
          //                 }
          //               } else {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content:
          //                         const Text(ConstString.pleaseCheckAllItem),
          //                     duration: const Duration(milliseconds: 500),
          //                     backgroundColor: AppColors.dangerColor,
          //                   ),
          //                 );
          //               }
          //             },
          //             icon: const Icon(Icons.cloud_upload_rounded));
          //       },
          //     );
          //   },
          // )
        ],
      ),
      persistentFooterButtons: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<StockLoadingCubit, StockLoadingState>(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<StockLoadingCubit, StockLoadingState>(
                  listener: (context, state) {
                    if (state.state == BlocCRUDProcessState.updateFail) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              dialogType: AlertDialogType.fail);
                        },
                      );
                    } else if (state.state ==
                        BlocCRUDProcessState.updateSuccess) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              dialogType: AlertDialogType.success);
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.state == BlocCRUDProcessState.updating) {
                      return const CircularProgressIndicator();
                    }
                    return BlocBuilder<StockLoadingCubit, StockLoadingState>(
                      builder: (context, state) {
                        if (state.state == BlocCRUDProcessState.updateSuccess) {
                          return Container();
                        }
                        return AnimatedButton(
                          height: 40,
                          onPressed: () async {
                            ///
                            bool isAllCheck = true;
                            bool lotCheck = true;
                            for (StockMoveLine moveLine
                                in state.stockMoveWithTotalList) {
                              isAllCheck = moveLine.isChecked ?? false;
                              if (!isAllCheck) {
                                break;
                              }
                            }

                            if (state.stockMoveWithTotalList.isEmpty) {
                              isAllCheck = false;
                            }

                            if (isAllCheck) {
                              List<Lot> lotList = [];
                              state.stockMoveWithTotalList.forEach(
                                (element) {
                                  if (element.isLot ?? false) {
                                    if ((element.lotList ?? []).isEmpty) {
                                      lotCheck = false;
                                    }
                                  }
                                  lotList.addAll(element.lotList ?? []);
                                  print(
                                      "Lot length : ${element.lotList?.length}");
                                  element.lotList?.forEach(
                                    (element) {
                                      print("Lot : ${element.toJson()}");
                                    },
                                  );
                                },
                              );

                              if (!lotCheck) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const TextWidget(
                                        ConstString.lotRequired),
                                    backgroundColor: AppColors.dangerColor,
                                  ),
                                );
                              } else {
                                bool confirm =
                                    await MMTApplication.showConfirmDialog(
                                            confirmQuestion: ConstString
                                                .loadingConfirmDialog,
                                            context: context) ??
                                        false;

                                if (confirm) {
                                  _stockLoadingCubit.uploadDoneQty(
                                      stockMoveList:
                                          state.stockMoveWithTotalList,
                                      lotList: lotList,
                                      productList: _productList);
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      ConstString.pleaseCheckAllItem),
                                  duration: const Duration(milliseconds: 500),
                                  backgroundColor: AppColors.dangerColor,
                                ),
                              );
                            }
                          },
                          buttonText: "Save",
                          status: ButtonStatus.start,
                          buttonColor: Colors.green,
                        ).expanded();
                        // return IconButton(
                        //     onPressed: () async {
                        //       bool isAllCheck = true;
                        //       bool lotCheck = true;
                        //       for (StockMoveLine moveLine
                        //           in state.stockMoveWithTotalList) {
                        //         isAllCheck = moveLine.isChecked ?? false;
                        //         if (!isAllCheck) {
                        //           break;
                        //         }
                        //       }
                        //
                        //       if (state.stockMoveWithTotalList.isEmpty) {
                        //         isAllCheck = false;
                        //       }
                        //
                        //       if (isAllCheck) {
                        //         List<Lot> lotList = [];
                        //         state.stockMoveWithTotalList.forEach(
                        //           (element) {
                        //             if (element.isLot ?? false) {
                        //               if ((element.lotList ?? []).isEmpty) {
                        //                 lotCheck = false;
                        //               }
                        //             }
                        //             lotList.addAll(element.lotList ?? []);
                        //             print(
                        //                 "Lot length : ${element.lotList?.length}");
                        //             element.lotList?.forEach(
                        //               (element) {
                        //                 print("Lot : ${element.toJson()}");
                        //               },
                        //             );
                        //           },
                        //         );
                        //
                        //         if (!lotCheck) {
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(
                        //               content: const TextWidget(
                        //                   ConstString.lotRequired),
                        //               backgroundColor: AppColors.dangerColor,
                        //             ),
                        //           );
                        //         } else {
                        //           bool confirm =
                        //               await MMTApplication.showConfirmDialog(
                        //                       confirmQuestion: ConstString
                        //                           .loadingConfirmDialog,
                        //                       context: context) ??
                        //                   false;
                        //
                        //           if (confirm) {
                        //             _stockLoadingCubit.uploadDoneQty(
                        //                 stockMoveList:
                        //                     state.stockMoveWithTotalList,
                        //                 lotList: lotList,
                        //                 productList: _productList);
                        //           }
                        //         }
                        //       } else {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(
                        //             content: const Text(
                        //                 ConstString.pleaseCheckAllItem),
                        //             duration: const Duration(milliseconds: 500),
                        //             backgroundColor: AppColors.dangerColor,
                        //           ),
                        //         );
                        //       }
                        //     },
                        //     icon: const Icon(Icons.cloud_upload_rounded));
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ],
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
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
                            _stockLoadingCubit.fetchBatchByBarcode(
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
                      return BlocBuilder<StockLoadingCubit, StockLoadingState>(
                        builder: (context, state) {
                          if (productState.state ==
                                  BlocCRUDProcessState.fetching ||
                              state.state == BlocCRUDProcessState.fetching) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state.state == BlocCRUDProcessState.fetchFail ||
                              productState.state ==
                                  BlocCRUDProcessState.fetchFail) {
                            return RetryWidget(
                              onRetry: () {
                                _stockLoadingCubit.fetchBatchByBarcode(
                                    barcode: _batchName ?? '');
                              },
                            );
                          }
                          _productList = productState.productList;

                          state.stockMoveList.forEachIndexed(
                            (stockMoveIndex, stockMoveLine) {
                              int index = productState.productList.indexWhere(
                                  (product) =>
                                      product.id == stockMoveLine.productId);
                              if (index != -1) {
                                if (productState
                                        .productList[index].trackingType ==
                                    TrackingType.lot) {
                                  state.stockMoveList[stockMoveIndex].isLot =
                                      true;
                                }
                              }
                            },
                          );

                          return _pickingTableWidget(
                              stockMoveList:
                                  state.stockMoveWithTotalList ?? []);
                        },
                      );
                    },
                  ),
                ],
              ).padding(padding: 16.allPadding),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pickingTableWidget({required List<StockMoveLine> stockMoveList}) {
    List<TableRow> tableRows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[200]),
        children: [
          _tableItem(''),
          _tableItem(ConstString.name, align: Alignment.centerLeft),
          _tableItem(ConstString.uom),
          _tableItem(ConstString.qty),
          _tableItem(''),
          _tableItem(ConstString.doneQty),
        ],
      )
    ];
    int index = 0;
    stockMoveList.forEach(
      (stockMoveLine) {
        if ((stockMoveLine.isLot != true)) {
          if (stockMoveLine.controller == null) {
            TextEditingController controller = TextEditingController(text: '0');
            stockMoveLine.controller = controller;
          }
        }
        ProductProduct? product = _productList
            .where(
              (element) => element.id == stockMoveLine.productId,
            )
            .firstOrNull;
        if (product?.trackingType == TrackingType.lot) {
          stockMoveLine.isLot = true;
        }
        tableRows.add(_tableRow(index: index, stockMoveLine: stockMoveLine));
      },
    );

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(2),
      },
      children: tableRows,
    );
  }

  TableRow _tableRow(
      {required StockMoveLine stockMoveLine, required int index}) {
    return TableRow(children: [
      BlocBuilder<StockLoadingCubit, StockLoadingState>(
        builder: (context, state) {
          return Checkbox(
            value: stockMoveLine.isChecked ?? false,
            onChanged: (value) {
              int index = state.stockMoveWithTotalList.indexWhere(
                (element) =>
                    element.moveId == stockMoveLine.moveId &&
                    element.productUomId == stockMoveLine.productUomId,
              );
              if (index > -1) {
                stockMoveLine.isChecked = value;
                state.stockMoveWithTotalList[index] = stockMoveLine;

                _stockLoadingCubit.editStockMoveLineList(
                    stockMoveLineList: state.stockMoveWithTotalList ?? []);
              }
            },
          );
        },
      ),
      _tableItem(stockMoveLine.productName ?? '', align: Alignment.centerLeft),
      _tableItem(stockMoveLine.productUomName ?? ''),
      // _tableItem((stockMoveLine.productUomQty ?? 0).toString()),

      _tableItem((stockMoveLine.productUomQty ?? 0)
          .toStringAsFixed(MMTApplication.selectedCompany?.qtyDigit ?? 0)),

      (stockMoveLine.isLot ?? false)
          ? Align(
              alignment: Alignment.centerLeft,
              child: BlocBuilder<LotCubit, LotState>(
                builder: (context, lotState) {
                  return BlocBuilder<StockLoadingCubit, StockLoadingState>(
                    builder: (context, state) {
                      return IconButton(
                          alignment: Alignment.centerLeft,
                          onPressed: () async {
                            List<Lot> lotList = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider(
                                      create: (context) => ProductCubit(),
                                      child: StockLoadingAddLot(
                                        stockMoveLine: stockMoveLine,
                                        lotList: lotState.lotList
                                            .where(
                                              (element) =>
                                                  element.productId ==
                                                  stockMoveLine.productId,
                                            )
                                            .toList(),
                                      ),
                                    );
                                  },
                                ) ??
                                (stockMoveLine.lotList ?? []);

                            int index = state.stockMoveWithTotalList.indexWhere(
                              (element) =>
                                  element.moveId == stockMoveLine.moveId &&
                                  element.productUomId ==
                                      stockMoveLine.productUomId,
                            );
                            if (index > -1) {
                              state.stockMoveWithTotalList[index].lotList =
                                  lotList;
                              _stockLoadingCubit.editStockMoveLineList(
                                  stockMoveLineList:
                                      state.stockMoveWithTotalList);

                              // print(
                              //     "Lot List : after dialog : ${lotList.length} : ${_stockMoveLineListNotifier.value[index].lotList?.length}");
                            }
                          },
                          icon: const Icon(Icons.more_vert));
                    },
                  );
                },
              ),
            )
          : Container(),
      (stockMoveLine.isLot ?? false)
          ? _tableItem((_calculateQtyDoneFromLot(stockMoveLine: stockMoveLine))
              .toStringAsFixed(MMTApplication.selectedCompany?.qtyDigit ?? 0))
          : BlocBuilder<StockLoadingCubit, StockLoadingState>(
              builder: (context, state) {
                TextEditingController qtyInputController =
                    TextEditingController();
                return TextField(
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    int index = state.stockMoveWithTotalList.indexWhere(
                        (element) =>
                            element.id == stockMoveLine.id &&
                            element.productUomId == stockMoveLine.productUomId);
                    if (index > -1) {
                      double qtyDone = _changeToRefQty(
                          qty: double.tryParse(value) ?? 0,
                          uomId: stockMoveLine.productUomId ?? 0,
                          productId: stockMoveLine.productId ?? 0);
                      if (qtyDone >
                          (state.stockMoveWithTotalList[index].productUomQty ?? 0)) {
                        stockMoveLine.controller?.text =
                            (stockMoveLine.qtyDone ?? 0).toQty();
                        context.showErrorDialog(ConstString.qtyMustNotGreaterThanRequire);
                        return;
                      }
                      //
                      state.stockMoveWithTotalList[index].qtyDone = qtyDone;
                      _stockLoadingCubit.editStockMoveLineList(
                          stockMoveLineList: state.stockMoveWithTotalList);
                    }
                  },
                  onTap: () {
                    stockMoveLine.controller?.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset:
                            stockMoveLine.controller?.text.length ?? 0);
                  },
                  controller: stockMoveLine.controller,
                  keyboardType: TextInputType.number,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                );
              },
            ).padding(padding: 8.horizontalPadding),
    ]);
  }

  Widget _tableItem(String text, {Alignment align = Alignment.centerRight}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  double _calculateQtyDoneFromLot({required StockMoveLine stockMoveLine}) {
    double doneQty = 0;

    ProductProduct? product = _productList
        .where((element) => element.id == stockMoveLine.productId)
        .firstOrNull;
    UomLine? initialUom = product?.uomLines?.firstWhereOrNull(
      (element) => element.uomId == stockMoveLine.productUomId,
    );
    //
    stockMoveLine.lotList?.forEach(
      (lot) {
        UomLine? uomline = product?.uomLines?.firstWhereOrNull(
          (element) => element.uomId == lot.productUomId,
        );
        if (uomline != null) {
          doneQty +=
              MMTApplication.uomQtyToRefTotal(uomline, lot.productQty ?? 0);
        }
      },
    );

    return (initialUom != null)
        ? MMTApplication.refToUom(initialUom, doneQty).roundTo(position: 2)
        : 0;
  }

  // Widget _tableItemList(List<String> textList) {
  //   List<Widget> textWidgetList = [];
  //
  //   textList.forEach(
  //     (element) => textWidgetList.add(Align(
  //         alignment: Alignment.centerRight,
  //         child: Text(element, style: TextStyle(fontWeight: FontWeight.bold)))),
  //   );
  //
  //   return Padding(
  //     padding: 8.allPadding,
  //     child: Column(
  //       children: textWidgetList,
  //     ),
  //   );
  // }

  Widget _qrScanner() {
    return IconButton(
        onPressed: () async {
          String? barcode = await MMTApplication.scanBarcode(context: context);
          if (barcode != null) {
            _batchName = barcode;
            _searchBatchController.text = _batchName ?? '';
            _stockLoadingCubit.fetchBatchByBarcode(barcode: barcode);
          }
        },
        icon: const Icon(Icons.qr_code));
  }

  double _changeToRefQty(
      {required double qty, required int uomId, required int productId}) {
    UomLine? uomLine = _productList
        .firstWhereOrNull(
          (element) => element.id == productId,
        )
        ?.uomLines
        ?.firstWhere(
          (element) => element.uomId == uomId,
        );

    if (uomLine?.uomType == UomType.bigger.name) {
      return qty * (uomLine?.ratio ?? 0);
    } else if (uomLine?.uomType == UomType.smaller.name) {
      return qty / (uomLine?.ratio ?? 0);
    } else {
      return qty;
    }
  }
}
