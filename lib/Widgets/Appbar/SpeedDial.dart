import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class CustomSpeedDial extends StatefulWidget {
  @override
  State<CustomSpeedDial> createState() => _CustomSpeedDialState();
}

class _CustomSpeedDialState extends State<CustomSpeedDial> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: ColorConfig.primaryAppColor,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child:
              ImageConfig.fromAsset(imagePath: teamIcon, color: Colors.white),
          backgroundColor: ColorConfig.primaryAppColor,
          onTap: () {
            Get.offNamed('/deptList');
          },
          label: 'Department List',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                ImageConfig.fromAsset(imagePath: userIcon, color: Colors.white),
          ),
          backgroundColor: ColorConfig.primaryAppColor,
          onTap: () {
            Get.offNamed('/empList');
          },
          label: 'Employee List',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        // SpeedDialChild(
        //   child: Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child:
        //         ImageConfig.fromAsset(imagePath: dueImage, color: Colors.white),
        //   ),
        //   backgroundColor: ColorConfig.primaryAppColor,
        //   onTap: () => print('Pressed Code'),
        //   label: 'Due Task',
        //   labelStyle:
        //       TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        //   labelBackgroundColor: Colors.black,
        // ),
        // SpeedDialChild(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child:
        //         ImageConfig.fromAsset(imagePath: userIcon, color: Colors.white),
        //   ),
        //   backgroundColor: ColorConfig.primaryAppColor,
        //   onTap: () => print('Pressed Code'),
        //   label: 'My Task',
        //   labelStyle:
        //       TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        //   labelBackgroundColor: Colors.black,
        // ),
      ],
    );
  }
}
