import 'package:duke_kanban/Configuration/PrefsConfig.dart';
import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:io' show Platform;
import '../../Configuration/ImageConfig.dart';

class CustomAppbar {
  static Widget customImageAppbar(String title, String dashTop,
      {Widget lead, List<Widget> actions, String screenName}) {
    return AppBar(
      elevation: 0,
      actions: actions,
      backgroundColor: Colors.white,
      title: ListTile(
        title: Text(
          "App Bar text Here",
          style: TextStyle(color: Colors.amber),
        ),
        subtitle: Text(screenName.toString()),
      ),
      leading: lead ?? ImageConfig.fromAsset(imagePath: logoImage),
    );
  }

  static Widget materialAppbar(
      {@required Widget lead,
      List<Widget> actions,
      @required String screenName}) {
    return AppBar(
        elevation: 0,
        actions: actions,
        backgroundColor: ColorConfig.primaryAppColor,
        title: ListTile(
            title: CustomText(
          data: screenName,
          fColor: Colors.white,
          fWeight: FontWeight.w700,
          fSize: 18,
        )),
        leading: lead);
  }
}

Widget lead() {
  return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
        color: Colors.white,
      ));
}

class CustomDashboardAppbar extends StatelessWidget {
  final String uName;
  final String title;
  final String logo;
  final VoidCallback onLogoTap;

  CustomDashboardAppbar(
      {Key key, this.uName, this.title, this.logo, this.onLogoTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.primaryAppColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          ListTile(
            //leading: CircleAvatar(
            //    radius: 25,
            //    backgroundColor: Colors.white,
            //    child: ImageConfig.fromAsset(imagePath: deltaLogo)),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: PrefsConfig.getProfilePic().isNotEmpty
                  ? NetworkImage(PrefsConfig.getProfilePic().replaceAll(
                      'E:/Publish/DeltaWRLite3.0/UploadedPhotos/',
                      'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/'))
                  : AssetImage(profileImage),
              radius: 25,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Center(
              child: Text(uName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white)),
            ),
            subtitle: Center(
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white, fontSize: 20)),
            ),
            trailing: IconButton(
                onPressed: onLogoTap,
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                )),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }
}
