import 'package:flutter/material.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';

import '../../common_widget/text_widget.dart';
import '../../src/const_string.dart';
import '../../src/style/app_color.dart';

class ConfirmDialogWidget extends StatelessWidget {
  const ConfirmDialogWidget({super.key, required this.confirmQuestion});

  final String confirmQuestion;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: (320, 20).padding,
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: 8.borderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              confirmQuestion,
            ).boldSize(16).padding(padding: 16.horizontalPadding),
            const Divider().padding(padding: 8.verticalPadding),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(AppColors.dangerColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set your desired radius
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.pop(false);
                    },
                    child: const TextWidget(
                      ConstString.cancel,
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          AppColors.primaryColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set your desired radius
                        ),
                      ),
                    ),
                    onPressed: () {
                      context.pop(true);
                    },
                    child: const TextWidget(ConstString.confirm,
                        style: TextStyle(color: Colors.white)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
