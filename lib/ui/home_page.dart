import 'dart:async';

import 'package:flutter/material.dart';

import '../common_widget/alert_dialog.dart';
import '../common_widget/sync_progress_dialog.dart';
import '../common_widget/text_widget.dart';
import '../sync_utils/main_sync_process.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  StreamSubscription? _masterSyncStream;
  late GlobalKey<SyncProgressDialogState> _dialogKey = GlobalKey();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {

        }, child: TextWidget(
          "Sync"
        )),
      ),
    );
  }


  void manualSyncStreamListener() {
    _masterSyncStream = MainSyncProcess.instance.syncStream.listen((data) {
      if (!data.isAutoSync) {
        _dialogKey.currentState
            ?.changeProgress(actionName: data.name, percentage: data.progress);
        if (data.isFinished) {
          Future.delayed(Duration(milliseconds: 300)).then((value) {
            _dialogKey.currentState?.closeDialog();
            if (data.message == MainSyncProcess.failMessage) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return CustomAlertDialog(
                      dialogType: AlertDialogType.error,
                      title: 'Sync Process',
                      content: '${data.name} fail',
                    );
                  });
            }
          });
        }
      }
    });
  }
}
