import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';

class TextFieldCustomWidget extends StatelessWidget {
  const TextFieldCustomWidget(
      {super.key, this.hintText, required this.controller, this.keyboardType});

  final String? hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: 8.horizontalPadding,
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: 8.borderRadius, border: Border.all()),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        keyboardType: keyboardType ,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }
}
