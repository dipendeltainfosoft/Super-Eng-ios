import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../Configuration/ColorConfig.dart';
import '../../Configuration/ImageConfig.dart';
import '../Authentication/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 2), () => SelectLanguage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        // width: 450,
                        child: AnimatedSplashScreen(
                          centered: true,
                          splashIconSize: 150,
                          duration: 2000,
                          splash: ImageConfig.fromAsset(
                              imagePath: applogoImage, size: 80),
                          nextScreen: LoginScreen(),
                          splashTransition: SplashTransition.fadeTransition,
                          animationDuration: Duration(seconds: 3),
                          pageTransitionType: PageTransitionType.bottomToTop,
                          // backgroundColor: splashBGColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    Text(
                      "Super Eng Kanban 3.0",
                      style: TextStyle(
                          color: ColorConfig.primaryAppColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    // Center(
                    //     child: ImageConfig.fromAsset(
                    //         imagePath: deltaImage, size: 60))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
