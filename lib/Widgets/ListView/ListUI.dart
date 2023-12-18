import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Configuration/ColorConfig.dart';
import '../Others/CustomTexts.dart';

class SmallCustomContainer extends StatelessWidget {
  final Color secColor;
  final String status;
  final String counts;
  final Color countColor;
  final Widget trailIcon;
  final BoxBorder border;

  const SmallCustomContainer(
      {Key key,
      this.secColor,
      this.status,
      this.counts,
      this.countColor,
      this.trailIcon,
      this.border})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
              height: Get.height / 38,
              width: Get.width / 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: ColorConfig.primaryLightAppColor,
              ),
              child: Center(
                child: trailIcon ??
                    CustomText(
                      data: status,
                      fColor: Colors.black,
                      fWeight: FontWeight.w500,
                    ),
              )),
          Container(
            height: Get.height / 38,
            width: Get.width / 10,
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: secColor,
            ),
            child: Center(
                child: CustomText(
              data: counts,
              fSize: 14,
              fColor: countColor ?? Colors.white,
              fWeight: FontWeight.w500,
            )),
          ),
        ],
      ),
    );
  }
}
