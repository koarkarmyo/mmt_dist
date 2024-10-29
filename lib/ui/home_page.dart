import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mmt_mobile/sync/models/sync_action.dart';
import 'package:mmt_mobile/sync/models/sync_response.dart';

import '../common_widget/alert_dialog.dart';
import '../common_widget/sync_progress_dialog.dart';
import '../common_widget/text_widget.dart';
import '../sync/sync_utils/main_sync_process.dart';

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
    manualSyncStreamListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            List<SyncResponse> actionList = [];
            actionList.add(SyncResponse(
              name: 'get_category'
            ));
            Future.delayed(Duration.zero, () {
              showDialog(
                  context: context,
                  builder: (context) => SyncProgressDialog(
                      key: _dialogKey
                    // cancelClicked: () => _syncBloc
                    //     .add(GetSyncActionCancelEvent()),
                  ));
            });
            MainSyncProcess.instance.startManualSyncProcess(actionList);
          },
          child: const TextWidget("Sync"),
        ),
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
