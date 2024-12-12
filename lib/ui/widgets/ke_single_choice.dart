import 'package:flutter/material.dart';

import '../../src/const_string.dart';
import '../../src/style/app_styles.dart';
import 'no_item_widget.dart';

typedef DisplayString<T> = String Function(T value);

class KESingleChoiceWithBloc<T> extends StatefulWidget {
  final DisplayString<T> displayString;
  final T? initial;
  final String label;
  final List<T> dataList;
  final ValueChanged<T> onSelect;
  final ValueChanged<String>? searchWorldChanged;

  const KESingleChoiceWithBloc({
    super.key,
    required this.displayString,
    required this.label,
    required this.dataList,
    required this.onSelect,
    this.searchWorldChanged,
    this.initial,
  });

  @override
  State<KESingleChoiceWithBloc<T>> createState() =>
      KESingleChoiceWithBlocState<T>();
}

class KESingleChoiceWithBlocState<T> extends State<KESingleChoiceWithBloc<T>> {
  T? _selectedValue;
  List<T> _dataList = [];
  bool _showLoading = false;
  final GlobalKey _statefulKey = GlobalKey();
  bool init = true;

  @override
  void initState() {
    if (init) {
      _selectedValue = widget.initial;
      _dataList = widget.dataList;
    }
    init = false;
    super.initState();
  }

  void setValue(T value) {
    _selectedValue = value;
    setState(() {});
  }

  void reset() {
    _selectedValue = null;
    setState(() {});
  }

  void showLoadingIndicator() {
    _showLoading = true;
    _statefulKey.currentState?.setState(() {});
  }

  void updateList(List<T> newList) {
    _showLoading = false;
    _dataList = newList;
    _statefulKey.currentState?.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _dataList = widget.dataList;
    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppStyles.miniTitle,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              // border: Border.all(
              //     // color: _selectedValue != null
              //     //     ? AppColors.primaryColor
              //     //     : AppColors.dangerColor,
              //     width: _selectedValue != null ? 1 : 2),
              border: Border(bottom: BorderSide(color: Colors.black54)),
            ),
            child: Text(
              _selectedValue != null
                  ? widget.displayString.call(_selectedValue as T)
                  : '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                // color: (_selectedValue != null)
                //     ? AppColors.primaryColor
                //     : AppColors.primaryColorPale,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showCustomBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          key: _statefulKey,
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              if (widget.searchWorldChanged != null) {
                                setModalState(() {
                                  _showLoading = true;
                                });
                                widget.searchWorldChanged!(value);
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: ConstString.search,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _showLoading
                      ? const Expanded(
                          child: Center(child: CircularProgressIndicator()))
                      : _dataList.isEmpty
                          ? const Expanded(child: Center(child: NoItemWidget()))
                          : Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  T item = _dataList[index];
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        _selectedValue = item;
                                      });
                                      widget.onSelect.call(item);
                                      Navigator.of(context).pop();
                                    },
                                    dense: true,
                                    title: Text(widget.displayString(item)),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.grey,
                                ),
                                itemCount: _dataList.length,
                              ),
                            ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void clear() {
    setState(() {
      _selectedValue = null;
    });
  }
}
