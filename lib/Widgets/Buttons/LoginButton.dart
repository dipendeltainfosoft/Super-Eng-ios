import 'package:flutter/material.dart';

import '../../Configuration/ColorConfig.dart';

class CustomLoginButton extends StatelessWidget {
  final void Function() press;
  final String bName;
  final IconData iconData; // Add this for the icon
  final double fSize;
  final Color color;
  final Color fcolor;
  final Widget circular;

  const CustomLoginButton({
    @required this.press,
    @required this.bName,
    this.iconData, // Add this for the icon
    this.fSize,
    this.color,
    this.fcolor,
    this.circular,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color ?? ColorConfig.primaryAppColor,
        gradient: color ??
            LinearGradient(
              colors: [
                ColorConfig.primaryAppColor,
                ColorConfig.btnColor1,
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
      ),
      child: MaterialButton(
        elevation: 4,
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bName,
              style: TextStyle(
                color: fcolor ?? Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5), // Adjust the spacing as needed
            if (iconData != null) // Conditionally add the icon
              Icon(
                iconData,
                color: fcolor ?? Colors.white,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class CustomCancelButton extends StatelessWidget {
  final void Function() press;
  final String bName;
  final double fSize;
  final Color color;
  final Color fcolor;

  const CustomCancelButton(
      {@required this.press,
      @required this.bName,
      this.fSize,
      this.color,
      this.fcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            ColorConfig.red1,
            ColorConfig.red2,
          ],
        ),
      ),
      child: MaterialButton(
        elevation: 4,
        onPressed: press,
        child: Text(
          bName,
          style: TextStyle(
              color: fcolor ?? Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class CustomOutButton extends StatelessWidget {
  final void Function() press;
  final String bName;
  final double fSize;
  final Color color;
  final Color fcolor;

  const CustomOutButton(
      {@required this.press,
      @required this.bName,
      this.fSize,
      this.color,
      this.fcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? ColorConfig.primaryAppColor),
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            width: 1,
            color: ColorConfig.primaryAppColor,
          ),
        ),
        child: Text(
          bName,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
