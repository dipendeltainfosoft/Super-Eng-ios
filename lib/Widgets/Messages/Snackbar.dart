import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackbarController snackbarMaterial(
      {@required String title,
      @required String message,
      @required Color bgColor,
      Duration duration,
      Widget icon}) {
    return Get.snackbar(
      title,
      message,
      icon: icon,
      backgroundColor: bgColor,
      duration: duration,
      animationDuration: Duration(seconds: 3),
      colorText: Colors.white,
      borderRadius: 10,
    );
  }

  static snackbarNormal(BuildContext context, String text, {Color color}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,

      content: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
      ),
      //width: 10,
      elevation: 6.0,
      duration: const Duration(seconds: 3),
      backgroundColor: color ?? ColorConfig.primaryAppColor,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
