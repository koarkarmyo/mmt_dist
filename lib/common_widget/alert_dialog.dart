import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_mobile/common_widget/bottom_sheet_selection_widget.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../src/const_dimen.dart';

enum AlertDialogType { success, fail, question, error, warning, info }

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType? dialogType;
  final String title;
  final String content;
  VoidCallback? onPressed;

  CustomAlertDialog(
      {Key? key,
      required this.dialogType,
      this.title = "",
      this.content = "",
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRequest = false;

    if (dialogType == AlertDialogType.question) {
      isRequest = true;
    }

    return Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: Container(
            width: ConstantDimens.dialogWidth,
            margin: const EdgeInsets.all(ConstantDimens.smallPadding),
            padding: const EdgeInsets.all(ConstantDimens.smallPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ConstantDimens.padding),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: ConstantDimens.sizedBoxS,
                ),
                Icon(
                  _getIcon(),
                  size: 40,
                  color: _getIconColor(),
                ),
                SizedBox(
                  height: ConstantDimens.sizedBoxS,
                ),
                Text(_getTitle(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const Divider(),
                Text(content,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: ConstantDimens.sizedBoxL,
                ),
                isRequest
                    ? _requestButton(context)
                    : OutlinedButton(
                        onPressed: onPressed ??
                            () {
                              Navigator.pop(context);
                            },
                        child: const Text('OK',
                            style: TextStyle(color: Colors.green)),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black))),
                ConstantWidgets.SizedBoxHeight
              ],
            ),
          ),
        ));
  }

  _getIcon() {
    switch (dialogType) {
      case AlertDialogType.success:
        return Icons.check_circle;
      case AlertDialogType.fail:
        return Icons.report;
      case AlertDialogType.question:
        return FontAwesomeIcons.questionCircle;
      case AlertDialogType.error:
        return Icons.error;
      case AlertDialogType.info:
        return FontAwesomeIcons.infoCircle;
      case AlertDialogType.warning:
        return FontAwesomeIcons.exclamationTriangle;
      default:
        return Icons.android_outlined;
    }
  }

  _getIconColor() {
    switch (dialogType) {
      case AlertDialogType.success:
        return Colors.green;
      case AlertDialogType.fail:
        return Colors.red;
      case AlertDialogType.question:
        return Colors.blue;
      case AlertDialogType.error:
        return Colors.red;
      case AlertDialogType.info:
        return Colors.blue;
      case AlertDialogType.warning:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  _getTitle() {
    switch (dialogType) {
      case AlertDialogType.success:
        return "$title Successful";
      case AlertDialogType.fail:
        return "Fail $title";
      case AlertDialogType.question:
        return "Are you sure $title?";
      case AlertDialogType.error:
        return "$title";
      case AlertDialogType.info:
        return "$title";
      case AlertDialogType.warning:
        return "$title";
      default:
        return "Default Title";
    }
  }

  _requestButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextButton(
                style: const ButtonStyle(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context, false)),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey))),
          ),
        ),
        Expanded(
          child: Container(
            child: TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.green)),
                onPressed: () => Navigator.pop(context, true)),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey))),
          ),
        ),
      ],
    );
  }
}
