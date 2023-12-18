import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../Configuration/ColorConfig.dart';
import '../../Configuration/ImageConfig.dart';
import '../Others/CustomTexts.dart';

class CustomRadioButton extends StatefulWidget {
  final dynamic grpValue;
  final Function(dynamic) onChange;
  final String title;
  final String icon;
  final int value;

  CustomRadioButton({
    Key key,
    @required this.grpValue,
    @required this.onChange,
    @required this.title,
    @required this.value,
    this.icon,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.grpValue == widget.value
            ? ColorConfig.primaryDarkAppColor // Color when selected
            : ColorConfig.dukeLightColor, // Default color
      ),
      child: InkWell(
        onTap: () => widget.onChange(widget.value),
        borderRadius: BorderRadius.circular(22),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.grpValue == widget.value
                  ? Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 24,
                    )
                  : SizedBox(
                      width: Get.width / 18,
                      height: Get.height / 40,
                      child: Radio<int>(
                        value: widget.value,
                        groupValue: widget.grpValue,
                        onChanged: widget.onChange,
                        activeColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        autofocus: false,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
            ),
            Container(
                height: 20,
                child: Text("") ??
                    ImageConfig.fromAsset(
                        imagePath: widget.icon, color: Colors.white)),
            SizedBox(
              width: 5,
            ),
            CustomText(
              data: widget.title,
              fWeight: FontWeight.w500,
              fColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
