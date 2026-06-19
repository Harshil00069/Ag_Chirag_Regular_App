import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Toast {
  info('Alert', Colors.blue, Icons.info_rounded),
  warning("Warning", Colors.orange, Icons.warning_rounded),
  error("Error", Colors.red, Icons.error),
  success("Success", Colors.green, Icons.check_circle_rounded);

  final String title;
  final Color color;
  final IconData icon;

  const Toast(this.title, this.color, this.icon);
}

class AppDialogs {
  static bool _isDialogOpen = false;

  static void showProgressDialog({
    String? message,
    bool isDismissible = false,
  }) {
    if (_isDialogOpen) return;

    _isDialogOpen = true;

    Get.dialog(
      PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => false,
        // disable back press
        child: progressWidget(msg: message),
      ),
      // progressWidget(msg: msg),
      barrierDismissible: isDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.3), // smooth overlay
      // builder: (ctx) => progressWidget(msg: msg),
    );
  }

  /// Hide global loading dialog
  static void hideLoading() {
    if (_isDialogOpen) {
      _isDialogOpen = false;
      if (Get.isDialogOpen ?? false) {
        Get.back(closeOverlays: true);
      }
    }
  }

  static Future<bool?> showInformationDialog({
    String title = 'Information',
    required String data,
  }) async {
    return await showDialog<bool?>(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        content: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(data),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Stack progressWidget({String? msg}) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        UnconstrainedBox(
          child: Container(
            height: 74,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 5),
                  blurRadius: 6.0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 18.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
                const SizedBox(width: 16),
                Material(
                  color: Colors.white,
                  child: FittedBox(
                    child: Text(
                      msg ?? 'Please Wait',
                      style: TextStyle(
                        fontSize: Get.textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Future<void> showToast({
//   int delay = 2,
//   required String message,
//   Toast type = Toast.info,
// }) async {
//   await Get.snackbar(
//     type.title,
//     message,
//     titleText: Text(type.title, style: Font.bodyText1(color: type.color)),
//     messageText: Text(message, style: Font.bodyText2(color: Colors.black)),
//     icon: Icon(type.icon, size: 32.0, color: type.color),
//     margin: EdgeInsets.symmetric(horizontal: 20, vertical: Get.height * 0.36),
//     snackPosition: SnackPosition.BOTTOM,
//     duration: Duration(seconds: delay),
//     borderWidth: 2.0,
//     borderRadius: 12.0,
//     padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
//     backgroundColor: Colors.white,
//     borderColor: type.color,
//   ).future;
// }
