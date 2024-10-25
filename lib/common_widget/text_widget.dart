import 'package:flutter/material.dart';

import '../src/mmt_application.dart';

class TextWidget extends StatefulWidget {
  final TextStyle? style;
  final TextAlign? textAlign;
  final String data;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? selectionColor;

  // Please feel free to add the parameters of the text to the widget.
  // I was too lazy to write that day. Sorry :3

  const TextWidget(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.selectionColor,
  });

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MMTApplication.languageNotifier,
      builder: (context, value, child) {
        return Text(
          widget.data.preferredLanguage(),
          style: widget.style,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
          selectionColor: widget.selectionColor,
          textAlign: widget.textAlign,
        );
      },
    );
  }
}

extension TextWidgetExtension on TextWidget {
  TextWidget bold() {
    return TextWidget(
      data,
      style: style?.copyWith(fontWeight: FontWeight.bold) ??
          const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  TextWidget boldSize(double fontSize) {
    return TextWidget(
      data,
      style: style?.copyWith(fontWeight: FontWeight.bold, fontSize: fontSize) ??
          TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
    );
  }
}
