import 'package:flutter/material.dart';

import '../../on_clicked_listener.dart';
import '../../utils/date_time_utils.dart';

class DateRangePickerKDialog extends StatefulWidget {
  final OnClickCallBack<List<DateTime>> callBack;
  late DateTime? firstDate;
  late DateTime? endDate;
  late bool? showClearBtn;
  List<DateTime>? defaultDateRange;
  late VoidCallback? onClear;
  bool fromStart;

  DateRangePickerKDialog(this.callBack,
      {Key? key,
        this.firstDate,
        this.endDate,
        this.showClearBtn,
        this.onClear,
        bool? fromStart,
        this.defaultDateRange})
      : fromStart = fromStart ?? false,
        super(key: key) {
    // this.firstDate ??= DateTime(2000, 1, 1);
    // this.endDate ??= DateTime.now();
    this.showClearBtn ??= false;
  }

  @override
  State<DateRangePickerKDialog> createState() => DateRangePickerKDialogState();
}

class DateRangePickerKDialogState extends State<DateRangePickerKDialog> {
  late String inputString;

  final TextEditingController _textFieldController = TextEditingController();

  DateTime? tempFirstDate;
  DateTime? tempEndDate;
  bool fromStart = false;

  void clear() {
    _textFieldController.clear();
  }

  @override
  void initState() {
    tempFirstDate = widget.firstDate;
    tempEndDate = widget.endDate;
    _resetRange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fromStart) {
      _resetRange();
    }
    return TextFormField(
      controller: _textFieldController,
      readOnly: true,
      decoration: InputDecoration(
        isDense: true,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        hintText: 'Search by date',
        prefixIcon: Icon(Icons.date_range_rounded),
        suffixIcon:
        widget.showClearBtn! && _textFieldController.text.trim().length > 0
            ? IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () {
            widget.onClear?.call();
            _textFieldController.clear();
            // tempFirstDate = null;
            // tempEndDate = null;
            _resetRange();
            widget.fromStart = false;
            setState(() {});
          },
        )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(8.0), left: Radius.circular(8.0))),
      ),
      onTap: () async {
        // if(widget.firstDate != null && widget.endDate != null) {
        // Future.delayed(Duration(milliseconds: 200)).then((value) async {
        DateTimeRange? dateTime = await showDateRangePicker(
            context: context,
            firstDate: widget.firstDate ?? DateTime(2001),
            lastDate: widget.endDate ?? DateTime.now());
        if (dateTime != null &&
            !dateTime.start
                .isAtSameMomentAs(widget.firstDate ?? DateTime.now())) {
          widget.callBack.call([dateTime.start, dateTime.end]);
          inputString =
          '${DateTimeUtils.ddMmYYYFormatSlug.format(dateTime.start)} - ${DateTimeUtils.ddMmYYYFormatSlug.format(dateTime.end)}';
          setState(() {
            widget.fromStart = false;
            _textFieldController.text = inputString;
          });
        }
        // });
      },
    );
  }

  void _resetRange() {
    DateTimeRange? dateTime;
    if (widget.defaultDateRange != null &&
        widget.defaultDateRange!.isNotEmpty) {
      dateTime = DateTimeRange(
          start: widget.defaultDateRange!.first,
          end: widget.defaultDateRange!.last);
      inputString =
      '${DateTimeUtils.ddMmYYYFormatSlug.format(dateTime.start)} - ${DateTimeUtils.ddMmYYYFormatSlug.format(dateTime.end)}';
      _textFieldController.text = inputString;
      widget.callBack.call([dateTime.start, dateTime.end]);
    } else if (tempFirstDate != null && tempEndDate != null) {
      dateTime = DateTimeRange(
          start: tempEndDate ?? DateTime.now(),
          end: tempEndDate ?? DateTime.now());
      inputString =
      '${DateTimeUtils.ddMmYYYFormatSlug.format(dateTime.start)} - ${DateTimeUtils.ddMmYYYFormatSlug.format(dateTime.end)}';
      _textFieldController.text = inputString;
      widget.callBack.call([dateTime.start, dateTime.end]);
    } else
      _textFieldController.text = '';
  }
}
