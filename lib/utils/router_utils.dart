import 'package:flutter/material.dart';

class RouterUtils {
  static Future<dynamic> navigateTransparent(
    BuildContext context,
    Widget page,
  ) {
    const transitionDuration = Duration(milliseconds: 200);
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        transitionDuration: transitionDuration,
        reverseTransitionDuration: transitionDuration,
        pageBuilder: (_, __, ___) => page,
      ),
    );
  }
}
