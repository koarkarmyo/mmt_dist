import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/batch/stock_loading_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/model/product/product.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../common_widget/text_widget.dart';
import '../../model/lot.dart';
import '../../model/product/uom_lines.dart';
import '../../model/stock_move.dart';
import '../../src/const_string.dart';
import '../../src/enum.dart';
import '../../src/style/app_color.dart';
import '../widgets/textfield_custom_widget.dart';
import 'package:collection/collection.dart';

class StockLoadingAddLot extends StatefulWidget {
  const StockLoadingAddLot(
      {super.key, required this.stockMoveLine, required this.lotList});

  final StockMoveLine stockMoveLine;
  final List<Lot> lotList;

  @override
  State<StockLoadingAddLot> createState() => _StockLoadingAddLotState();
}

class _StockLoadingAddLotState extends State<StockLoadingAddLot> {
  final ValueNotifier<Lot?> _lotNotifier = ValueNotifier(null);
  final ValueNotifier<UomLine?> _uomNotifier = ValueNotifier(null);
  final ValueNotifier<List<Lot>> _lotListNotifier = ValueNotifier([]);
  final ValueNotifier<String> _warningNotifier = ValueNotifier('');
  final ValueNotifier<double> _remainingQtyNotifier = ValueNotifier(0);
  TextEditingController _qtyController = TextEditingController();
  late ProductCubit _productCubit;
  String? _waringingText;

  late List<Lot> lotList;
  List<UomLine> _uomList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productCubit = context.read<ProductCubit>();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _productCubit.getProductById(
        productId: widget.stockMoveLine.productId ?? 0);
    _lotListNotifier.value = widget.stockMoveLine.lotList ?? [];
    lotList = widget.lotList;
    _remainingQtyNotifier.value = widget.stockMoveLine.productUomQty ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        // color: Colors.transparent,
        child: Container(
          // margin: 16.allPadding,
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: 16.borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.cancel)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Add Lot").bold(),
                  IconButton(
                      onPressed: () async {
                        String? barcode =
                            await MMTApplication.scanBarcode(context: context);
                        int index = lotList.indexWhere(
                          (element) => element.name == barcode,
                        );
                        if (index > -1) {
                          _lotNotifier.value = lotList[index];
                        }
                      },
                      icon: const Icon(Icons.qr_code))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              _lotChoiceWidget(),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  TextFieldCustomWidget(
                    keyboardType: TextInputType.number,
                    controller: _qtyController,
                    hintText: "Qty",
                  ).expanded(),
                  const SizedBox(
                    width: 8,
                  ),
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state.state == BlocCRUDProcessState.fetchSuccess) {
                        _uomNotifier.value =
                            state.product?.uomLines?.firstWhereOrNull(
                          (element) =>
                              element.uomId ==
                              widget.stockMoveLine.productUomId,
                        );
                        _uomList = state.product?.uomLines ?? [];
                      }
                      return GestureDetector(
                          onTap: () async {
                            UomLine? uomLine = await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomChoiceSheetWidget<UomLine>(
                                    itemList: state.product?.uomLines ?? [],
                                    toItemString: (value) =>
                                        value.uomName ?? '',
                                    title: "Uom");
                              },
                            );
                            _uomNotifier.value = uomLine;
                          },
                          child: Container(
                            width: double.infinity,
                            padding: (12, 8).padding,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: 8.borderRadius,
                                border: Border.all()),
                            child: ValueListenableBuilder(
                              valueListenable: _uomNotifier,
                              builder: (context, value, child) {
                                return Text(
                                  _uomNotifier.value?.uomName ?? 'Uom',
                                  style: const TextStyle(fontSize: 16),
                                );
                              },
                            ),
                          ));
                    },
                  ).expanded(),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              ValueListenableBuilder(
                valueListenable: _warningNotifier,
                builder: (context, value, child) {
                  return TextWidget(
                    value ?? '',
                    style: TextStyle(color: AppColors.dangerColor),
                  ).padding(padding: 8.verticalPadding);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_addButton(), _saveButton(context)],
              ),
              Divider().padding(padding: 8.verticalPadding),
              SizedBox(
                height: 16,
              ),
              ValueListenableBuilder(
                valueListenable: _remainingQtyNotifier,
                builder: (context, value, child) => Text(
                        "Demand Qty : $value ${widget.stockMoveLine.productUomName}")
                    .padding(padding: 8.verticalPadding),
              ),
              _lotListWidget()
            ],
          ).padding(padding: 16.allPadding),
        ),
      ),
    );
  }

  void _resetValue() {
    _uomNotifier.value = _uomList.firstWhereOrNull(
      (element) => element.uomId == widget.stockMoveLine.productUomId,
    );
    _lotNotifier.value = null;
    _qtyController.text = '';
  }

  Widget _lotListWidget() {
    return ValueListenableBuilder(
        valueListenable: _lotListNotifier,
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              Lot lot = value[index];
              return ListTile(
                title: Text(lot.name ?? ''),
                subtitle: Text("${lot.productQty} ${lot.productUomName}"),
                trailing: IconButton(
                    onPressed: () {
                      _lotListNotifier.value.remove(lot);
                      _lotListNotifier.value = List.of(_lotListNotifier.value);
                    },
                    icon: const Icon(Icons.delete)),
              );
            },
          );
        }).expanded();
  }

  Widget _saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        double refQty = _calculateRefLotTotalQty();
        print(
            "Difference : ${((widget.stockMoveLine.productUomQty ?? 0) - refQty).abs()}");
        // if ( ((widget.stockMoveLine.productUomQty ?? 0) - refQty).abs() > 1  ) {
        //   _warningNotifier.value = ConstString.totalQtyNotMatch;
        // } else

        if (_uomNotifier.value == null) {
          _warningNotifier.value = "Uom is empty";
        } else {
          if (_lotNotifier.value != null &&
              double.tryParse(_qtyController.text) != null &&
              _uomNotifier.value != null) {
            Lot lot = Lot.fromJson(_lotNotifier.value!.toJson());
            double qty = double.tryParse(_qtyController.text) ?? 0;
            UomLine uom = _uomNotifier.value!;
            lot.productQty = qty;
            lot.productUomName = uom.uomName;
            lot.productUomId = uom.uomId;
            _lotListNotifier.value.add(lot);
          }
          context.pop(_lotListNotifier.value);
        }
      },
      child: Container(
          padding: (8, 16).padding,
          decoration: BoxDecoration(
              borderRadius: 8.borderRadius,
              border: Border.all(),
              color: AppColors.primaryColor),
          child: const TextWidget(
            ConstString.save,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _addButton() {
    return GestureDetector(
      onTap: () {
        if (_lotNotifier.value != null &&
            double.tryParse(_qtyController.text) != null &&
            _uomNotifier.value != null) {
          Lot lot = Lot.fromJson(_lotNotifier.value!.toJson());
          double qty = double.tryParse(_qtyController.text) ?? 0;
          UomLine uom = _uomNotifier.value!;
          lot.productQty = qty;
          lot.productUomName = uom.uomName;
          lot.productUomId = uom.uomId;
          _lotListNotifier.value.add(lot);
          _lotListNotifier.value = List.of(_lotListNotifier.value);
          _resetValue();
        }
      },
      child: Container(
          padding: (8, 16).padding,
          decoration: BoxDecoration(
              borderRadius: 8.borderRadius,
              border: Border.all(),
              color: AppColors.primaryColor),
          child: const TextWidget(
            ConstString.add,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget _lotChoiceWidget() {
    return GestureDetector(
      onTap: () async {
        Lot? lot = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomChoiceSheetWidget(
                itemList: lotList,
                toItemString: (value) => value.name ?? 'Please choose a lot',
                title: "Lot");
          },
        );
        _lotNotifier.value = lot;
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration:
            BoxDecoration(borderRadius: 8.borderRadius, border: Border.all()),
        padding: 16.allPadding,
        child: ValueListenableBuilder(
          valueListenable: _lotNotifier,
          builder: (context, value, child) =>
              Text(_lotNotifier.value?.name ?? ''),
        ),
      ),
    );
  }

  double _calculateRefLotTotalQty() {
    double refQty = 0;
    _lotListNotifier.value.forEach(
      (lot) {
        UomLine uomLine = _uomList.firstWhere(
          (element) {
            return element.uomId == lot.productUomId;
          },
        );
        if (uomLine.uomId == widget.stockMoveLine.productUomId) {
          refQty += lot.productQty ?? 0;
        } else {
          UomLine? refUom = _uomList.firstWhereOrNull(
            (element) => element.uomType == UomType.reference.name,
          );
          if (refUom != null) {
            refQty += MMTApplication.refToUom(uomLine,
                MMTApplication.uomQtyToRefTotal(refUom, lot.productQty ?? 0));
          }
        }
      },
    );

    return double.parse(refQty.toStringAsFixed(2));
  }
}
