import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmt_mobile/src/const_string.dart';

import '../src/const_dimen.dart';
import '../src/mmt_application.dart';
import 'alert_dialog.dart';

class ConstantWidgets {
  static final mscmLogoS = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
        radius: 16,
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
      Text(
        ConstString.appName,
        style: GoogleFonts.gabriela(
            fontWeight: FontWeight.bold, letterSpacing: 5, fontSize: 16),
      ),
      Text(
        '(${MMTApplication.loginResponse?.deviceId?.name ?? ' '})',
        style: TextStyle(fontSize: 16),
      ),
    ],
  );

  static final mscmLogoL = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
      Text(
        ConstString.appName,
        style: GoogleFonts.gabriela(
            fontWeight: FontWeight.bold, letterSpacing: 10, fontSize: 32),
      ),
    ],
  );

  static const SizedBoxHeight = SizedBox(height: ConstantDimens.normalPadding);
  static const SizedBoxHeightL = SizedBox(height: ConstantDimens.pagePadding);
  static const SizedBoxWidth = SizedBox(width: ConstantDimens.normalPadding);
  static const SizedBoxWidthL = SizedBox(width: ConstantDimens.pagePadding);

  static final roundedCornerBorderRadiusS =
      BorderRadius.circular(ConstantDimens.normalPadding);
  static final roundedCornerBorderRadiusL =
      BorderRadius.circular(ConstantDimens.pagePadding);

  static Widget separator(_, index) => Divider(thickness: 2, height: 2);

  static InputDecoration inputDecoration(String label,
      {required Color disableColor,
      required Color enableColor,
      required Color focusedColor,
      required Color errorColor}) {
    return InputDecoration(
      label: Text(label),
      disabledBorder: outlineBorder(disableColor, ConstantDimens.normalPadding),
      enabledBorder: outlineBorder(enableColor, ConstantDimens.normalPadding),
      focusedBorder: outlineBorder(focusedColor, ConstantDimens.normalPadding),
      errorBorder: outlineBorder(errorColor, ConstantDimens.normalPadding),
    );
  }

  static OutlineInputBorder outlineBorder(Color color, double radius) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: color));
  }

  static showLottieLoadingDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              // child: Lottie.asset('assets/lotties/125643-loading-two-tone.json',
              //     width: 150, height: 150),
              child: SpinKitCircle(
                color: Colors.black,
              ),
            ),
          );
        });
  }

  static void showErrorSnackBar(BuildContext context, String message,
      {int? durationMilliSecond = 2000}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: Duration(milliseconds: durationMilliSecond!),
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(BuildContext context, String message,
      {int? durationMilliSecond = 2000}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 18)),
      duration: Duration(milliseconds: durationMilliSecond!),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static final GreyLine = Container(
    height: 2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.shade200,
    ),
  );

  static BoxDecoration boxDecoration(
      {required Color cornerColor,
      Color bgColor = Colors.white,
      required double radius}) {
    return BoxDecoration(
        color: bgColor,
        border: Border.all(color: cornerColor),
        borderRadius: BorderRadius.circular(radius));
  }

  static void showInfoSnackBar(BuildContext context, String message,
      {int? durationMilliSecond = 4000, bool isSuccess = false}) {
    final snackBar = SnackBar(
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      content: Text(message, style: TextStyle(color: Colors.white)),
      duration: Duration(milliseconds: durationMilliSecond!),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future showInfoDialog({
    required BuildContext context,
    required String label,
    required AlertDialogType dialogType,
    VoidCallback? onPressed,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            dialogType: dialogType,
            content: label,
            onPressed: onPressed,
          );
        });
  }

  static Widget createContainer(
      {required BuildContext context,
      required String label,
      required Widget child,
      Color? borderColor}) {
    borderColor = borderColor ?? Theme.of(context).colorScheme.background;
    return Container(
      padding: EdgeInsets.all(ConstantDimens.normalPadding),
      child: InputDecorator(
        decoration: InputDecoration(
          label: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: child,
      ),
    );
  }

  static Widget confirmButton({
    required String label,
    required VoidCallback onPressed,
    Icon? icon,
    Color? color,
    Size? size,
  }) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.green,
          minimumSize: size,
        ),
        icon: icon,
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
