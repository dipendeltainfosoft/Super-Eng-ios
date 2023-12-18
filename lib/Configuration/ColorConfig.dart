import 'package:flutter/material.dart';

class ColorConfig {
  static Color btnColor1 = Color(0xff00716C);
  static Color btnColor2 = Color(0xff67EAE3);
  static Color btnColor3 = Color(0xff2e8890);
  static Color appBarColor = Color(0xffD088E5);
  static Color primaryAppColor = Color(0xff018F89);
  static Color primaryDarkAppColor = Color(0xff01706f);
  static Color primaryLightAppColor = Color(0xffe6e7e7);
  static Color primaryLightAppColor2 = Color(0xffecf1f2);
  static Color dukeLightColor = Color(0xff2da19d);
  static Color boxColor = Color(0xfff2f2f2);
  static Color red1 = Color(0xffFF2400);
  static Color red2 = Color(0xffFF0800);
  static Color red3 = Color(0xffF22952);
  static Color stripColor = Color(0xffe6e6e6);

  // todo List Colors.
  static Color listBlue = Color(0xff32b5ec);
  static Color listOrange = Color(0xfff70303);
  static Color listGreen = Color(0xff65bb6b);

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
