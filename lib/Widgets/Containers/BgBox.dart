import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class BgBox extends StatelessWidget {
  final String title;
  final double size;
  final String imagePath;
  final Widget image;
  final EdgeInsets padding;
  final List<Widget> cols;

  const BgBox({
    this.title,
    this.size,
    this.imagePath,
    this.image,
    this.padding,
    this.cols,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.4,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 40),
      width: Get.width / 1,
      child: Column(
        children: cols,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
        color: ColorConfig.boxColor,
      ),
    );
  }
}
