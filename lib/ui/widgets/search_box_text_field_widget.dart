import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../src/const_dimen.dart';

class SearchBoxTextField extends StatefulWidget {
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onTextFieldSubmitted;
  VoidCallback? clearBtnClicked;
  final String? hintText;

  SearchBoxTextField(
      {Key? key,
        this.hintText = 'Search',
        this.onChanged,
        this.onTextFieldSubmitted,
        this.clearBtnClicked})
      :
        // assert(onChanged != null || onTextFieldSubmitted != null),
        super();

  @override
  State<SearchBoxTextField> createState() => _SearchBoxTextFieldState();
}

class _SearchBoxTextFieldState extends State<SearchBoxTextField> {
  TextEditingController _controller = TextEditingController();
  bool _showHideClearIcon = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (value) {
        // setState(() {
        //   _showHideClearIcon = value.isNotEmpty && value.length > 0;
        // });
        // widget.onChanged?.call(value);
      },
      autofocus: false,
      onFieldSubmitted: widget.onTextFieldSubmitted,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        prefixIcon: Icon(Icons.search_outlined),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(ConstantDimens.smallPadding),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(ConstantDimens.smallPadding),
        ),
        suffixIcon: Visibility(
          visible: _showHideClearIcon,
          child: GestureDetector(
            child: Icon(Icons.cancel_outlined),
            onTap: () {
              widget.clearBtnClicked?.call();
              _controller.clear();
              setState(() {
                _showHideClearIcon = false;
              });
            },
          ),
        ),
      ),
    );
  }
}
