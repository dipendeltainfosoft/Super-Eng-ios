import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('mobile');
    prefs.remove('pass');
  }

  String mobile;

  getUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      mobile = _prefs.getString('mobile');
    });
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              height: Get.height / 4,
              decoration: BoxDecoration(
                color: ColorConfig.primaryAppColor,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    data: "Kanban 3.0",
                    fSize: 26,
                    fColor: Colors.white,
                    fWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      profileImage,
                    ),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    data: "SANDIP MEVADA",
                    fColor: Colors.white,
                    fWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' My Course '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Go Premium '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

    // Helper().customText(
    //   text: "App Version:".tr + " " + "V 1.0",
    //   fontSize: 18,
    //   color: Colors.grey,
    // )
  }
}
