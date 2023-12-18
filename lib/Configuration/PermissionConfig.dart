import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {
  static Future<void> checkPermission(context) async {
    if (!(await Permission.camera.isGranted )&&
        !(await Permission.photos.isGranted)) {
      Map<Permission, PermissionStatus> statues = await [
        Permission.camera,
        Permission.photos,
      ].request();
      PermissionStatus statusCamera = statues[Permission.camera];
      PermissionStatus statusPhotos = statues[Permission.photos];

      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusPhotos == PermissionStatus.granted;
      if (isGranted) {
        print("Granted Permission");
      }

      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusPhotos == PermissionStatus.permanentlyDenied;

      bool isDenied = statusCamera == PermissionStatus.denied ||
          statusPhotos == PermissionStatus.denied;
      if (isPermanentlyDenied) {
        showPermissionDeniedDialog(context);
      } else if (isDenied) {
        showPermissionGuide(context);
      }
    }
  }
}

void showPermissionDeniedDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
            'You have denied some permission. Allow all permission at [Settings] -> [Permission]'),
        actions: <Widget>[
          TextButton(
            child: const Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Go to settings'),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showPermissionGuide(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
          'You have denied some permission. Allow all permission at [Settings] -> [Permission]'),
      action: SnackBarAction(
        label: 'Go to settings',
        onPressed: () {
          openAppSettings();
        },
      ),
    ),
  );
}
