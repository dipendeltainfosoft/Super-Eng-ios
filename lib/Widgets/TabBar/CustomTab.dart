import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Configuration/ColorConfig.dart';

class CustomTab extends StatefulWidget {
  final TabController mainController;
  final List<Widget> tabs;
  final Function(int) onTab;

  const CustomTab(
      {Key key, @required this.mainController, @required this.tabs, this.onTab})
      : super(key: key);

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConfig.primaryLightAppColor,
      ),
      height: Get.height / 22,
      child: Material(
        color: ColorConfig.dukeLightColor,
        // borderRadius: BorderRadius.circular(10),
        child: TabBar(
          onTap: widget.onTab,
          indicator: BoxDecoration(
            // borderRadius: BorderRadius.circular(8),
            color: ColorConfig.primaryDarkAppColor,
          ),
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          splashBorderRadius: BorderRadius.circular(8),
          tabs: widget.tabs,
          controller: widget.mainController,
        ),
      ),
    );
  }
}

class CustomTabContent extends StatelessWidget {
  final String text;
  final String image;
  const CustomTabContent({Key key, this.text, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageConfig.fromAsset(imagePath: image, size: 18, color: Colors.white),
        SizedBox(
          width: 10,
        ),
        Tab(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
// ama check karvanu che ke jyare task approval ma 
class CustomTabDeptContent extends StatelessWidget {
  final String text;

  const CustomTabDeptContent({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
