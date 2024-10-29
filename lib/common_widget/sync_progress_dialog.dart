import 'package:flutter/material.dart';

import '../src/const_dimen.dart';
import '../src/style/app_color.dart';
import 'constant_widgets.dart';

// ignore: must_be_immutable
class SyncProgressDialog extends StatefulWidget {
  VoidCallback? cancelClicked;

  SyncProgressDialog({Key? key, this.cancelClicked}) : super(key: key);

  @override
  State<SyncProgressDialog> createState() => SyncProgressDialogState();
}

class SyncProgressDialogState extends State<SyncProgressDialog> {
  String actionName = 'Sync';
  double progressPercent = 0.0;

  changeProgress({required String actionName, required double percentage}) {
    try {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            this.actionName = actionName;
            this.progressPercent = percentage;
          });
        }
      });
    } catch (e) {
      e.toString();
    }
  }

  void closeDialog() {
    print("Close Dialog");
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(ConstantDimens.normalPadding),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(ConstantDimens.normalPadding)),
          child: Container(
            padding: const EdgeInsets.all(ConstantDimens.pagePadding),
            width: 200,
            // height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 70,
                  child: Center(
                    child: Text('Sync Processing',
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: AppColors.primaryColorPale,
                      color: AppColors.successColor,
                      value: progressPercent,
                    ),
                    ConstantWidgets.SizedBoxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            actionName,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                            '${(progressPercent * 100).toStringAsFixed(2)} %'),
                      ],
                    ),
                    ConstantWidgets.SizedBoxHeight,
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Text('Cancel')),
                  ],
                ),
                // if (widget.cancelClicked != null)
                //   ElevatedButton(
                //       onPressed: widget.cancelClicked, child: Text('Cancel')),
                if (widget.cancelClicked != null)
                  ConstantWidgets.SizedBoxHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
