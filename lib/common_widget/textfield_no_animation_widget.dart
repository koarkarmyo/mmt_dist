import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';

import '../src/style/app_color.dart';

class TextFieldNoAnimation extends StatefulWidget {
  const TextFieldNoAnimation({
    super.key,
    this.hintText,
    this.keyboardType,
    bool? canEdit,
    this.textAlign,
    this.maxLines = 1,
    this.initialText,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.controller,
  }) : canEdit = canEdit ?? true;

  final String? hintText;
  final bool canEdit;
  final String? initialText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextAlign? textAlign;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;

  @override
  State<TextFieldNoAnimation> createState() => TextFieldNoAnimationState();
}

class TextFieldNoAnimationState extends State<TextFieldNoAnimation> {
  final ValueNotifier<bool> _isValid = ValueNotifier(true);
  late TextEditingController _controller;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _controller.text == '0') {
        _controller.clear();
      }
      if (!_focusNode.hasFocus &&
          _controller.text == '' &&
          widget.keyboardType == TextInputType.number) {
        _controller.text = '0';
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isValid.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isValid,
        builder: (context, value, child) {
          Color borderColor =
              value ? AppColors.primaryColor : AppColors.dangerColor;
          double borderWidth = value ? 1 : 2;
          return TextFormField(
            onFieldSubmitted: widget.onFieldSubmitted,
            onTap: widget.onTap,
            readOnly: !widget.canEdit,
            textAlign: widget.textAlign ?? TextAlign.start,
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            validator: (value) {
              return null;
            },
            focusNode: _focusNode,
            controller: _controller,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            keyboardType: widget.keyboardType,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding: 12.allPadding,
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 14),
              label: Text(
                widget.hintText ?? '',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
              ),
              enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderSide: BorderSide(color: borderColor, width: borderWidth),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              isDense: true,
              focusColor: AppColors.primaryColor,
            ),
          );
        });
  }

  bool get isValid {
    _isValid.value = _controller.text != '';
    return _isValid.value;
  }

  void setValid(bool isValid) {
    _isValid.value = isValid;
  }

  void unFocus(){
    _focusNode.unfocus();
  }

  bool get isValidNumber {
    _isValid.value = (_controller.text != '') &&
        ((double.tryParse(_controller.text) ?? 0) > 0);
    return _isValid.value;
  }

  void resetValue(String value) {
    _controller.text = value;
  }

  String get text {
    return _controller.text;
  }
}
