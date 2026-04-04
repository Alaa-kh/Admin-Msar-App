import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  // Show error snackbar
  static void error(BuildContext context, String msg) {
    final ctx = AppOverlay.overlayContext ?? context;

    AnimatedSnackBar.material(
      msg,
      type: AnimatedSnackBarType.error,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(ctx);
  }

  // Show success snackbar
  static void success(BuildContext context, String msg) {
    final ctx = AppOverlay.overlayContext ?? context;

    AnimatedSnackBar.material(
      msg,
      type: AnimatedSnackBarType.success,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(ctx);
  }

  // Show info snackbar
  static void info(BuildContext context, String msg) {
    final ctx = AppOverlay.overlayContext ?? context;

    AnimatedSnackBar.material(
      msg,
      type: AnimatedSnackBarType.info,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      duration: const Duration(seconds: 3),
    ).show(ctx);
  }
}

class AppOverlay {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Get overlay context for snackbars
  static BuildContext? get overlayContext =>
      navigatorKey.currentState?.overlay?.context;
}
