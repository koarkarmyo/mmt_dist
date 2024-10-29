import 'package:flutter/material.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

class BottomSheetSelectionWidget extends StatefulWidget {
  BottomSheetSelectionWidget(
      {super.key,
      required this.selectionList,
      required this.onTap,
      required this.selectedValueList});

  List<String?> selectionList;
  VoidCallback onTap;
  ValueNotifier<List<bool>> selectedValueList;

  @override
  State<BottomSheetSelectionWidget> createState() =>
      _BottomSheetSelectionWidgetState();
}

class _BottomSheetSelectionWidgetState
    extends State<BottomSheetSelectionWidget> {
  bool _isCheckAll = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.selectionList.forEach(
      (element) {
        widget.selectedValueList.value.add(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstantWidgets.SizedBoxHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sync Action List",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: (8, 16).padding,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: 10.borderRadius,
                ),
                child: const Text("sync"),
              ),
            ),
          ],
        ).padding(padding: 16.horizontalPadding),
        const Divider(),
        ValueListenableBuilder(
          valueListenable: widget.selectedValueList,
          builder: (context, valueList, child) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.selectionList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(
                    onTap: () {
                      _isCheckAll = !_isCheckAll;
                      List<bool> boolList = [];
                      for (bool element in widget.selectedValueList.value) {
                          boolList.add(_isCheckAll);
                        }
                      widget.selectedValueList.value = List.from(boolList);
                    },
                    dense: true,
                    title: Text(
                      'select all',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ).padding(padding: 8.horizontalPadding),
                    trailing: Checkbox(
                      value: _isCheckAll,
                      onChanged: (value) {
                        _isCheckAll = !_isCheckAll;
                        List<bool> boolList = [];
                        widget.selectedValueList.value.forEach(
                          (element) {
                            boolList.add(_isCheckAll);
                          },
                        );
                        widget.selectedValueList.value = List.from(boolList);
                      },
                    ),
                  );
                } else {
                  return ListTile(
                    dense: true,
                    title: Text(
                      widget.selectionList[index - 1] ?? '',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ).padding(padding: 8.horizontalPadding),
                    trailing: Checkbox(
                      value: valueList[index - 1],
                      onChanged: (value) {
                        widget.selectedValueList.value[index - 1] =
                            value ?? false;
                        // Notify listeners to trigger a rebuild
                        widget.selectedValueList.value =
                            List.from(widget.selectedValueList.value);
                      },
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
