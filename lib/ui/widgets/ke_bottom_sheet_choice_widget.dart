import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../src/const_string.dart';

class KESingleChoiceWidget<T> extends StatefulWidget {
  final List<T> valueList;
  final String Function(T value) getDisplayString;
  final Widget? trailingIconWidget;
  final ValueChanged<T?> onSelected;
  final T? selectedValue;
  final String? label;

  const KESingleChoiceWidget({
    super.key,
    required this.valueList,
    this.selectedValue,
    required this.getDisplayString,
    this.trailingIconWidget,
    required this.onSelected,
    this.label,
  });

  @override
  State<KESingleChoiceWidget<T>> createState() =>
      KESingleChoiceWidgetState<T>();
}

class KESingleChoiceWidgetState<T> extends State<KESingleChoiceWidget<T>> {
  T? _selectedValue;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _selectedValue =
            await KEBottomSheetChoiceWidget.showBottomChoiceSheet<T>(
          context: context,
          valueList: widget.valueList,
          getDisplayString: widget.getDisplayString,
        );
        setState(() {});
        widget.onSelected.call(_selectedValue);
      },
      child: InputDecorator(
        decoration: InputDecoration(
            label: widget.label != null ? Text(widget.label!) : null),
        child: SizedBox(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   // border: Border.all(
          //   //     color: value ? AppColors.primaryColor : AppColors.dangerColor,
          //   //     width: value ? 1 : 2),
          //   borderRadius: 10.borderRadius,
          // ),
          child: Text(
              _selectedValue != null
                  ? widget.getDisplayString(_selectedValue as T)
                  : '',
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class KEBottomSheetChoiceWidget {
  static Future<T?> showBottomChoiceSheet<T>({
    required BuildContext context,
    required List<T> valueList,
    required String Function(T value) getDisplayString,
    Widget? trailingIconWidget,
  }) async {
    TextEditingController searchController = TextEditingController();
    ValueNotifier<List<T>> searchNotifier = ValueNotifier(valueList);

    searchController.addListener(() {
      searchNotifier.value = valueList
          .where((element) => (getDisplayString(element).toLowerCase())
              .contains(searchController.text.toLowerCase()))
          .toList();
    });

    return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: (4, 8).padding,
              decoration: BoxDecoration(
                  borderRadius: 10.borderRadius, border: Border.all()),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: ConstString.search),
                  ).expanded(),
                  if (trailingIconWidget != null) trailingIconWidget
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _showCustomerList(
                searchNotifier: searchNotifier,
                getDisplayString: getDisplayString),
          ],
        ).padding(padding: (24, 16).padding);
      },
    );
  }

  static Widget _showCustomerList<T>(
      {required ValueNotifier<List<T>> searchNotifier,
      required String Function(T value) getDisplayString}) {
    return ValueListenableBuilder(
      valueListenable: searchNotifier,
      builder: (context, value, child) {
        return ListView.separated(
                itemBuilder: (context, index) {
                  T item = value[index];
                  return ListTile(
                    onTap: () {
                      context.pop(item);
                    },
                    dense: true,
                    title: Text(getDisplayString(item)).bold(),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                itemCount: value.length)
            .expanded();
      },
    );
  }
}
