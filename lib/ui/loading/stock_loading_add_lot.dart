import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/product/product_cubit.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/model/product/product.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../model/lot.dart';
import '../../model/product/uom_lines.dart';
import '../../model/stock_move.dart';
import '../../src/const_string.dart';
import '../../src/style/app_color.dart';
import '../widgets/textfield_custom_widget.dart';

class StockLoadingAddLot extends StatefulWidget {
  const StockLoadingAddLot({super.key, required this.stockMoveLine});

  final StockMoveLine stockMoveLine;

  @override
  State<StockLoadingAddLot> createState() => _StockLoadingAddLotState();
}

class _StockLoadingAddLotState extends State<StockLoadingAddLot> {
  final ValueNotifier<Lot?> _lotNotifier = ValueNotifier(null);
  final ValueNotifier<UomLine?> _uomNotifier = ValueNotifier(null);
  final ValueNotifier<List<Lot>> _lotListNotifier = ValueNotifier([]);
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _uomController = TextEditingController();
  late ProductCubit _productCubit;

  List<Lot> lotList = [
    Lot(id: 1, name: "LOT00001"),
    Lot(id: 2, name: "LOT00002"),
    Lot(id: 3, name: "LOT00003"),
    Lot(id: 4, name: "LOT00004"),
    Lot(id: 5, name: "LOT00005")
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: 16.allPadding,
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: 16.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    return GestureDetector(
                        onTap: () async {
                          UomLine? uomLine = await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BottomChoiceSheetWidget<UomLine>(
                                  itemList: state.product?.uomLines ?? [],
                                  toItemString: (value) => value.uomName ?? '',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_addButton(), _saveButton()],
            ),
            SizedBox(
              height: 16,
            ),
            _lotListWidget()
          ],
        ).padding(padding: 16.allPadding),
      ),
    );
  }

  void _resetValue() {
    _uomNotifier.value = null;
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
              );
            },
          );
        }).expanded();
  }

  Widget _saveButton() {
    return   GestureDetector(
      onTap: () {
      context.pop(_lotListNotifier.value);
      },
      child: Container(
          padding: (8, 16).padding,
          decoration: BoxDecoration(
              borderRadius: 8.borderRadius,
              border: Border.all(),
              color: AppColors.primaryColor),
          child: const Text(
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
          Lot lot = _lotNotifier.value!;
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
          child: const Text(
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
}
