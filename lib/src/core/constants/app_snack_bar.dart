import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  static void error(BuildContext context, String msg) {
    AnimatedSnackBar.material(
      msg,
      type: AnimatedSnackBarType.error,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void success(BuildContext context, String msg) {
    AnimatedSnackBar.material(
      msg,
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void info(BuildContext context, String msg) {
    AnimatedSnackBar.material(
      msg,
      type: AnimatedSnackBarType.info,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
