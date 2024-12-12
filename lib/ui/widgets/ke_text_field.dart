import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';

enum TextFieldDecoTypes { allBorder, onlyUnderLine }

class KETextField extends StatefulWidget {
  final String? hintText;
  final String? initialText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? enabled;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final Widget? suffix;
  final String? label;
  final FormFieldValidator<String>? validator;
  final FocusNode? node;
  final ValueChanged<String>? onChanged;
  final TextFieldDecoTypes? decoType;
  final bool required;

  const KETextField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.textAlign,
    this.maxLines = 1,
    this.initialText,
    this.controller,
    this.enabled,
    this.readOnly,
    this.onPressed,
    this.suffix,
    this.label,
    this.validator,
    this.node,
    this.onChanged,
    this.required = false,
    this.decoType = TextFieldDecoTypes.onlyUnderLine,
  });

  @override
  State<KETextField> createState() => KETextFieldState();
}

class KETextFieldState extends State<KETextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
    // _focusNode.addListener(() {
    //   if (_focusNode.hasFocus && _controller.text == '0') {
    //     _controller.clear();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.label != null) ...[
    //   Padding(
    //     padding: 8.horizontalPadding,
    //     child: Text(widget.label ?? ''),
    //   ),
    //   4.sizedBoxAll,
    // ],
    return TextFormField(
      onTap: () {
        // widget.node?.requestFocus();
        // print(widget.node?.hasFocus);
        widget.onPressed?.call();
      },
      onChanged: widget.onChanged,
      validator: widget.validator,
      enabled: widget.enabled,
      readOnly: widget.readOnly ?? false,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.maxLines,
      // validator: (value) {
      //   return null;
      // },
      focusNode: widget.node,
      controller: _controller,
      onTapOutside: (event) {
        if (widget.node == null) {
          FocusScope.of(context).unfocus();
        }
      },
      keyboardType: widget.keyboardType,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: widget.decoType == TextFieldDecoTypes.allBorder
            ? (12, 16).padding
            : 0.allPadding,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: widget.suffix,
        hintText: widget.hintText,
        label: widget.label != null
            ? RichText(
                text: TextSpan(children: [
                TextSpan(
                    text: widget.label,
                    style: Theme.of(context).textTheme.bodyMedium),
                if (widget.required)
                  const TextSpan(
                    text: ' ${ConstString.requiredStar}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
              ]))
            : null,
        // label: widget.label != null ? Text(widget.label ?? '') : null,
        enabledBorder: widget.decoType == TextFieldDecoTypes.allBorder
            ? OutlineInputBorder(
                gapPadding: 0,
                borderSide: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(10.0),
              )
            : null,
        disabledBorder: widget.decoType == TextFieldDecoTypes.allBorder
            ? OutlineInputBorder(
                gapPadding: 0,
                borderSide: const BorderSide(width: 2),
                borderRadius: BorderRadius.circular(10.0),
              )
            : null,
        focusedBorder: widget.decoType == TextFieldDecoTypes.allBorder
            ? OutlineInputBorder(
                borderSide: const BorderSide(width: 2),
                borderRadius: BorderRadius.circular(10.0),
              )
            : null,
        border: widget.decoType == TextFieldDecoTypes.allBorder
            ? OutlineInputBorder(
                borderSide: const BorderSide(width: 2),
                borderRadius: BorderRadius.circular(10.0),
              )
            : null,
        isDense: widget.decoType == TextFieldDecoTypes.allBorder,
        // focusColor: AppColors.majorColor,
      ),
    );
  }

  bool get isValid {
    return _controller.text != '';
  }

  bool get isValidNumber {
    return (_controller.text != '') &&
        ((double.tryParse(_controller.text) ?? 0) > 0);
  }

  void resetValue(String value) {
    _controller.text = value;
  }

  String get text {
    return _controller.text;
  }
}
