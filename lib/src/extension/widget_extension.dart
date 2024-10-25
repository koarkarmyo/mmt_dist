import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget padding({required EdgeInsetsGeometry padding}) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }
}

extension TextExtension on Text {
  Text bold() {
    return Text(
      data ?? '',
      style: style?.copyWith(fontWeight: FontWeight.bold) ??
          const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text boldSize(double fontSize) {
    return Text(
      data ?? '',
      style: style?.copyWith(fontWeight: FontWeight.bold, fontSize: fontSize) ??
          TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
    );
  }

  Text size(double fontSize) {
    return Text(
      data ?? '',
      style:
          style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize),
    );
  }
}
