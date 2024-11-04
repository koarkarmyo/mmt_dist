import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/constant_widgets.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';
import 'package:mmt_mobile/src/style/app_color.dart';
import 'package:collection/collection.dart';

import '../common_widget/alert_dialog.dart';
import '../common_widget/bottom_sheet_selection_widget.dart';
import '../common_widget/sync_progress_dialog.dart';
import '../model/partner.dart';
import '../model/tag.dart';
import '../route/route_list.dart';
import '../share_preference/sh_keys.dart';
import '../share_preference/sh_utils.dart';
import '../src/const_string.dart';
import '../src/enum.dart';
import '../sync/bloc/sync_action_bloc/sync_action_bloc_cubit.dart';
import '../sync/models/sync_response.dart';
import '../sync/sync_utils/main_sync_process.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SyncActionCubit _syncActionCubit;
  ValueNotifier<List<bool>> selectActionList = ValueNotifier([]);
  GlobalKey<SyncProgressDialogState> _dialogKey = GlobalKey();
  StreamSubscription? _masterSyncStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    manualSyncStreamListener();
    _syncActionCubit = context.read<SyncActionCubit>()
      ..getSyncAction(isManualSync: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildProfileCard(),
            const SizedBox(height: 10),
            BlocBuilder<SyncActionCubit, SyncActionState>(
              builder: (context, state) {
                return _buildButton(
                    onPressed: () {
                      if (MainSyncProcess.instance.syncProcessIsRunning) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 1),
                          content: const Text("Auto Sync is running"),
                          backgroundColor: AppColors.dangerColor,
                        ));
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            List<String?> selectionList = [];
                            state.actionList.forEach(
                              (element) => selectionList.add(element.name),
                            );
                            return BottomSheetSelectionWidget(
                                selectedValueList: selectActionList,
                                onTap: () {
                                  List<SyncResponse> syncList = [];
                                  state.actionList.forEachIndexed(
                                    (index, element) {
                                      if (selectActionList.value[index]) {
                                        syncList.add(element);
                                      }
                                    },
                                  );

                                  MainSyncProcess.instance
                                      .startManualSyncProcess(syncList);
                                  context.pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SyncProgressDialog(
                                        key: _dialogKey,
                                      );
                                    },
                                  );
                                },
                                selectionList: selectionList);
                          },
                        );
                      }
                    },
                    label: "Master Sync",
                    icon: Icons.sync,
                    color: Colors.white70,
                    textColor: Colors.black);
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 10,
            ),
            _buildSettingsCard(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        _buildButton(
            onPressed: () async {
              await SharePrefUtils().delete(ShKeys.currentUser);
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteList.loginPage,
                (route) => false,
              );
            },
            label: "Log Out",
            icon: Icons.logout,
            color: AppColors.primaryColor,
            textColor: Colors.white),
      ],
    );
  }

  // Widget _syncWidget() {
  //   return const ListTile(
  //     title: Text("Delivery Sync"),
  //     subtitle: Text("sync action name"),
  //   );
  // }

  Widget _buildProfileCard() {
    return Card(
      surfaceTintColor: Colors.white24,
      elevation: 0.3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey,
              child: Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.white.withOpacity(0.5),
              ),
            ).padding(padding: 12.horizontalPadding),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantWidgets.SizedBoxHeight,
                Text(
                  MMTApplication.currentUser?.name ?? "",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                ConstantWidgets.SizedBoxHeight,
                _buildInfoRow(Icons.phone,
                    MMTApplication.currentUser?.phone ?? '----------'),
                _buildInfoRow(Icons.email_outlined,
                    MMTApplication.currentUser?.email ?? '----------'),
                _buildInfoRow(
                    Icons.device_unknown,
                    MMTApplication.currentUser?.defaultLocationName ??
                        '----------'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(info, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
    Color? color,
    Color? textColor,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          shadowColor: Colors.grey.shade50),
      onPressed: onPressed ?? () => debugPrint("Sync"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, color: textColor ?? Colors.white)),
          const SizedBox(width: 8),
          Icon(
            icon,
            size: 18,
            color: textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Card(
      surfaceTintColor: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: 'Vehicle',
              decoration: const InputDecoration(border: InputBorder.none),
              items: const [
                DropdownMenuItem(value: 'Vehicle', child: Text("Vehicle"))
              ],
              onChanged: (value) {},
            ),
            const Divider(),
            _buildSettingsOption("Copy Database", null, () {
              debugPrint("Copy Database");
            }),
            const Divider(),
            _buildSettingsOption("Version", null, null,
                trailingText: ConstString.version),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(String title, IconData? icon, VoidCallback? onTap,
      {String? trailingText}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16)),
                if (icon != null) Icon(icon, size: 25),
              ],
            ),
            if (trailingText != null)
              Text(trailingText, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  void manualSyncStreamListener() async {
    _masterSyncStream = MainSyncProcess.instance.syncStream.listen((data) {
      if (!data.isAutoSync) {
        _dialogKey.currentState
            ?.changeProgress(actionName: data.name, percentage: data.progress);
        print("Sync Progress : ${data.toJson()} : ${data.progress}");
        if (data.isFinished) {
          print("Sync Complete");
          _dialogKey.currentState?.closeDialog();
          Future.delayed(const Duration(milliseconds: 300)).then((value) {
            _dialogKey.currentState?.closeDialog();
            if (data.message == MainSyncProcess.failMessage) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (context.mounted) {
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
          });
        }
      }
    });
  }
}
