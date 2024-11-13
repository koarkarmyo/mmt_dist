import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

typedef ItemToString<T> = String Function(T value);

class BottomChoiceSheetWidget<T> extends StatefulWidget {
  const BottomChoiceSheetWidget(
      {super.key,
      required this.itemList,
      required this.toItemString,
      required this.title});

  final List<T> itemList;
  final ItemToString<T> toItemString;
  final String title;

  @override
  State<BottomChoiceSheetWidget> createState() =>
      _BottomChoiceSheetWidgetState<T>();
}

class _BottomChoiceSheetWidgetState<T>
    extends State<BottomChoiceSheetWidget<T>> {
  final ValueNotifier<String?> _searchNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.title} List",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ).padding(padding: 16.allPadding),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: 8.borderRadius,
              // color: Colors.grey.shade300
            ),
            padding: 16.horizontalPadding,
            margin: 16.horizontalPadding,
            child: Center(
              child: TextField(
                onChanged: (value) {
                  _searchNotifier.value = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: widget.title),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _showItemListWidget()
        ],
      ),
    );
  }

  Widget _showItemListWidget() {
    return ValueListenableBuilder(
        valueListenable: _searchNotifier,
        builder: (context, value, child) {
          List<T> searchItemList = widget.itemList
              .where(
                (element) => (widget.toItemString(element).toLowerCase() ?? '')
                    .contains(value?.toLowerCase() ??
                        widget.toItemString(element).toLowerCase()),
              )
              .toList();
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: searchItemList.length,
            itemBuilder: (context, index) {
              T item = searchItemList[index];
              return ListTile(
                onTap: () {
                  context.pop(item);
                },
                dense: true,
                title: Text(widget.toItemString(item)).bold(),
              );
            },
          ).expanded();
        });
  }
}
