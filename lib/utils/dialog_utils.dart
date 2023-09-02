import 'package:flutter/cupertino.dart';

class DialogUtils {
  static Future<bool?> showAlertDialog(
    BuildContext context, {
    required String titleText,
    required String okActionText,
    required String cancelActionText,
  }) async {
    return await showCupertinoDialog<bool?>(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(titleText),
        actions: [
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            child: Text(okActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
