// import 'package:atom_ui/on_clicked_listener.dart';
import 'package:flutter/material.dart';

enum CustomerFilterType { ALL, VISITED, MISSED, PLAN }

class CustomerVisitFilterWidget extends StatefulWidget {
  // late OnClickCallBack<CustomerFilterType> onClicked;
  late CustomerFilterType selectedFilterType;

  // CustomerVisitFilterWidget(
  //     {Key? key, required this.onClicked, required this.selectedFilterType})
  //     : super(key: key);

  @override
  State<CustomerVisitFilterWidget> createState() =>
      CustomerVisitFilterWidgetState();
}

class CustomerVisitFilterWidgetState extends State<CustomerVisitFilterWidget> {
  void toDefaultState() {
    setState(() {
      widget.selectedFilterType = CustomerFilterType.ALL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
            selectedColor: Colors.white,
            label: Text('All Customer'),
            labelStyle: TextStyle(
                color: widget.selectedFilterType == CustomerFilterType.ALL
                    ? Colors.red
                    : Colors.white),
            side: BorderSide(
                color: widget.selectedFilterType == CustomerFilterType.ALL
                    ? Colors.red
                    : Colors.white),
            selected: widget.selectedFilterType == CustomerFilterType.ALL,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  widget.selectedFilterType = CustomerFilterType.ALL;
                  // widget.onClicked(widget.selectedFilterType);
                });
              }
            }),
        ChoiceChip(
            selectedColor: Colors.white,
            label: Text('Visited Customer'),
            labelStyle: TextStyle(
                color: widget.selectedFilterType == CustomerFilterType.VISITED
                    ? Colors.red
                    : Colors.white),
            side: BorderSide(
                color: widget.selectedFilterType == CustomerFilterType.VISITED
                    ? Colors.red
                    : Colors.white),
            selected: widget.selectedFilterType == CustomerFilterType.VISITED,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  widget.selectedFilterType = CustomerFilterType.VISITED;
                  // widget.onClicked(widget.selectedFilterType);
                });
              }
            }),
        ChoiceChip(
            selectedColor: Colors.white,
            label: Text('Missed Customer'),
            labelStyle: TextStyle(
                color: widget.selectedFilterType == CustomerFilterType.MISSED
                    ? Colors.red
                    : Colors.white),
            side: BorderSide(
                color: widget.selectedFilterType == CustomerFilterType.MISSED
                    ? Colors.red
                    : Colors.white),
            selected: widget.selectedFilterType == CustomerFilterType.MISSED,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  widget.selectedFilterType = CustomerFilterType.MISSED;
                  // widget.onClicked(widget.selectedFilterType);
                });
              }
            }),
      ],
    );
  }
}
