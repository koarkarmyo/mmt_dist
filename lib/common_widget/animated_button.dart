import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mmt_mobile/common_widget/text_widget.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';

import '../src/style/app_color.dart';

enum ButtonStatus { start, loading, fail, success }

extension ButtonStatusExtension on ButtonStatus {
  Color get color {
    switch (this) {
      case ButtonStatus.fail:
        return AppColors.dangerColor;
      case ButtonStatus.success:
        return AppColors.successColor;
      default:
        return Colors.white;
    }
  }

  String get string {
    switch (this) {
      case ButtonStatus.fail:
        return "Fail";
      case ButtonStatus.success:
        return "Success";
      case ButtonStatus.start:
        return "Confirm";
      case ButtonStatus.loading:
        return "Loading";
      default:
        return '';
    }
  }
}

class AnimatedButton extends StatefulWidget {
  AnimatedButton(
      {super.key,
      required this.buttonText,
      required this.status,
      required this.buttonColor});

  String buttonText;

  ButtonStatus status;
  Color buttonColor;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: 20.borderRadius,
        border: Border.all(
            color: (widget.status == ButtonStatus.loading)
                ? widget.buttonColor
                : Colors.white),
        color: (widget.status == ButtonStatus.start)
            ? widget.buttonColor
            : widget.status.color,
      ),
      child: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              height: (widget.status == ButtonStatus.loading) ? 50 : 0,
              width: (widget.status == ButtonStatus.loading) ? 400 : 0,
              duration: 100.milliseconds,
              decoration: BoxDecoration(
                  borderRadius: 20.borderRadius, color: Colors.white),
            ),
          ),
          Center(
            child: _getButtonTextWidget(),
          ),
        ],
      ),
    );
  }

  Widget _getButtonTextWidget() {
    if (widget.status == ButtonStatus.loading) {
      return Padding(
        padding: 8.verticalPadding,
        child: CircularProgressIndicator(
          color: widget.buttonColor,
        ),
      );
    } else if (widget.status == ButtonStatus.start) {
      return TextWidget(
        widget.buttonText,
        style: const TextStyle(
          color: Colors.white,
        ),
      );
    } else {
      return TextWidget(
        widget.status.string,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      );
    }
  }
}
