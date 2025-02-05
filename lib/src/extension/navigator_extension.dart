import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/model/cust_visit.dart';
import 'package:mmt_mobile/src/const_string.dart';
import 'package:mmt_mobile/src/mmt_application.dart';

import '../../business logic/bloc/bloc_crud_process_state.dart';
import '../../business logic/bloc/cust_visit/cust_visit_cubit.dart';
import '../../common_widget/alert_dialog.dart';
import '../../common_widget/text_widget.dart';
import '../style/app_color.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> pushTo<T>({required String route, Map<String, dynamic>? args}) {
    return Navigator.pushNamed<T>(this, route, arguments: args);
  }

  Future<T?> push<T>({required Route<T> route}) {
    return Navigator.push(this, route);
  }

  Future<Map<String, dynamic>?> pushReplace(
      {required String route, Map<String, dynamic>? args}) {
    return Navigator.pushReplacementNamed(this, route, arguments: args);
  }

  void pop<T>([T? result]) {
    return Navigator.pop<T>(this, result);
  }

  void rootPop<T>([T? result]) {
    return Navigator.of(this, rootNavigator: true).pop<T>();
  }

  Future<bool> mayBePop<T>([T? result]) {
    return Navigator.maybePop(this, result);
  }
}

extension SnackBarCustom on BuildContext {
  void showErrorSnackBar(String error) {
    SnackBar snackBar = SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  Future<void> showSuccessDialog(String message, {String? title}) {
    return showDialog(
      context: this,
      builder: (context) {
        return CustomAlertDialog(
          dialogType: AlertDialogType.success,
          title: title ?? message,
          content: message ?? '',
        );
      },
    );
  }

  Future<void> showErrorDialog(String message) {
    return showDialog(
      context: this,
      builder: (context) {
        return CustomAlertDialog(
            dialogType: AlertDialogType.fail, title: message);
      },
    );
  }

  /// [BuildContext]
  /// return success after clock out or not
  Future<bool?> showClockInOutDialog(
      {required CustVisitTypes custVisitType, VoidCallback? onClicked}) {
    return showDialog<bool>(
      context: this,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => CustVisitCubit(),
          child: AlertDialog(
            icon: const Icon(
              Icons.account_box_rounded,
              size: 80,
            ),
            title: TextWidget(
              custVisitType == CustVisitTypes.clock_in
                  ? ConstString.clockIn
                  : ConstString.clockOut,
              style: const TextStyle(fontSize: 24),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  custVisitType == CustVisitTypes.clock_in
                      ? ConstString.clockInConfirm
                      : ConstString.clockOutConfirm,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // const Icon(
                //   Icons.camera_alt_outlined,
                //   size: 80,
                // )
              ],
            ),
            actions: [
              Center(
                child: BlocConsumer<CustVisitCubit, CustVisitState>(
                  listener: (context, state) {
                    if (state.state == BlocCRUDProcessState.createSuccess) {
                      // MMTApplication.currentCustomer = selectedCustomer;
                      // Navigator.pushNamed(
                      //     context, RouteList.customerDashboardPage,
                      //     arguments: {'customer': selectedCustomer});
                      context.pop(true);
                    }
                  },
                  builder: (context, state) {
                    if (state.state == BlocCRUDProcessState.initial ||
                        state.state == BlocCRUDProcessState.createFail) {
                      return SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white),
                          onPressed: () {
                            if (MMTApplication.currentCustomer != null) {
                              context.read<CustVisitCubit>().saveCustVisit(
                                  customer: MMTApplication.currentCustomer!, type:custVisitType);
                            }
                          },
                          child: Text(
                            custVisitType == CustVisitTypes.clock_in
                                ? ConstString.clockIn
                                : ConstString.clockOut,
                          ),
                        ),
                      );
                    } else if (state.state == BlocCRUDProcessState.creating) {
                      return const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
