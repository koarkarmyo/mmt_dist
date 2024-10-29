import 'package:flutter/material.dart';

import '../../utils/date_time_utils.dart';

class DatePickerBtn extends StatefulWidget {
  final ValueChanged<DateTime> onChange;
  final DateTime defaultDate;
  final bool? isEnable;

  DatePickerBtn(
      {Key? key,
      required this.onChange,
      required this.defaultDate,
      this.isEnable})
      : super(key: key) {
    this.isEnable ?? true;
  }

  @override
  State<DatePickerBtn> createState() => DatePickerBtnState();
}

class DatePickerBtnState extends State<DatePickerBtn> {
  final TextEditingController _textEditingController = TextEditingController();
  late DateTime temp;

  @override
  void initState() {
    temp = widget.defaultDate;
    _textEditingController.text = DateTimeUtils.ddMmYYYFormat.format(temp);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, innerState) {
        return GestureDetector(
          onTap: () async {
            if (widget.isEnable ?? true) {
              DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: temp,
                  firstDate: DateTime(2000, 5, 1),
                  lastDate: DateTime.now().add(const Duration(days: 30)));

              if (dateTime != null) {
                temp = dateTime;
              }

              innerState(() {
              _textEditingController.text =
                  DateTimeUtils.ddMmYYYFormat.format(temp);
              widget.onChange.call(temp);
              });

            }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.today,size: 28,),
                  const SizedBox(width: 10,),
                  Text(_textEditingController.text,style: const TextStyle(fontSize: 18),)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void setDate(DateTime currentDate) {
    temp = currentDate;
    _textEditingController.text = DateTimeUtils.ddMmYYYFormat.format(temp);
    setState(() {});
  }
}
