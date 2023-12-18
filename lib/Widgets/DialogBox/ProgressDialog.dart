import 'package:flutter/material.dart';

import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../Configuration/ColorConfig.dart';

ProgressDialog progressDialog;

class CustomProgressDialog {
  static showProgress(
      BuildContext context, String message, bool isDismissible) async {
    progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: isDismissible);
    progressDialog.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            width: 100,
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            )),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: ColorConfig.appBarColor,
            fontSize: 19.0,
            fontWeight: FontWeight.w600));
    await progressDialog.show();
  }

  static updateProgress(String message) {
    progressDialog.update(message: message);
  }

  static hideProgress() async {
    if (progressDialog != null) await progressDialog.hide();
  }
}
