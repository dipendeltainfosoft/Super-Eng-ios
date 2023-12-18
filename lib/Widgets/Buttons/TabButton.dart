import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../Configuration/ColorConfig.dart';

class CustomTabButton extends StatefulWidget {
  final String value;
  String grpValue;
  final String bName;
  final Function(String) onChanged;

  CustomTabButton(
      {@required this.value,
      @required this.grpValue,
      @required this.bName,
      this.onChanged});

  @override
  State<CustomTabButton> createState() => _CustomTabButtonState();
}

class _CustomTabButtonState extends State<CustomTabButton> {
  Color _buttonColor;

  @override
  void initState() {
    super.initState();
    _buttonColor = widget.grpValue == widget.value
        ? ColorConfig.primaryDarkAppColor
        : ColorConfig.dukeLightColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _buttonColor,
      ),
      child: RadioListTile(
          dense: true,
          title: Center(
            child: Text(
              widget.bName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          value: widget.value,
          groupValue: widget.grpValue,
          onChanged: widget.onChanged),
    );
  }
}
