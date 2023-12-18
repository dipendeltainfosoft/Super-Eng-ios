import 'dart:isolate';

import 'package:duke_kanban/Views/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Views/Dashboard/DashCard.dart';
import 'package:duke_kanban/Widgets/DialogBox/DialogBox.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Configuration/ColorConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Controllers/Profile/ProfileController.dart';
import '../../Widgets/Messages/Snackbar.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }

  String userId = '';
  String userName = '';

  @override
  void initState() {
    getProfileDetailsAPICall();
    super.initState();
  }

  String profilePicURL = "";

  void getProfileDetailsAPICall() {
    try {
      ProfileController.getProfileDetails(
        context: context,
        userId: PrefsConfig.getUserId() ?? "",
      ).then((value) => {
            if (value['status'] == "200")
              {
                setState(() {
                  profilePicURL = value['result'][0]['ProfilePic'].replaceAll(
                      'E:/Publish/DeltaWRLite3.0/UploadedPhotos/',
                      'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/');
                  PrefsConfig.setProfilePic(profilePicURL);
                  // Get.find<DashboardController>().setProileImage(profilePicURL);
                  print('Updated profile pic ${PrefsConfig.getProfilePic()}');
                  print(profilePicURL);
                }),
              }
            else
              {
                setState(() {
                  CustomSnackbar.snackbarNormal(
                      context,
                      value != null
                          ? value['message']
                          : 'Invalid response from server');
                })
              },
          });
    } catch (e) {
      print(e);
      CustomSnackbar.snackbarNormal(context, e.toString());
    }
  }

  var photoPic = Get.arguments;

  Future<void> getProfilePic() async {
    print('hii iam recall');
    final response = await ProfileController.getProfileDetails(
        context: context, userId: PrefsConfig.getUserId());

    if (response['status'] == "200") {
      Get.to(() => DashboardPage());
      setState(() {
        print('hii iam recall');
        profilePicURL = response['result'][0]['ProfilePic']
            .toString()
            .replaceAll('E:/Publish/DeltaWRLite3.0/UploadedPhotos',
                'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/');
        print('Init profile screen $profilePicURL');
      });
      print(response['result'][0]['ProfilePic']);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
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
                    // leading:  FutureBuilder(
                    //   future: getProfilePic(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       final profileUrl = snapshot.data['result'][0]['ProfilePic']
                    //           .toString()
                    //           .replaceAll('E:/Publish/DeltaWRLite3.0/UploadedPhotos',
                    //           'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/');
                    //       return CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         backgroundImage: NetworkImage(profileUrl),
                    //         radius: 25,
                    //       );
                    //     } else {
                    //       return CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         backgroundImage: profilePicURL.isNotEmpty
                    //             ? NetworkImage(profilePicURL)
                    //             : AssetImage(profileImage),
                    //         radius: 25,
                    //       );
                    //     }
                    //   }
                    // ),
                    visualDensity: VisualDensity.standard,
                    leading: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen((p0) {}),
                            ));
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(profileImage),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Center(
                      child: Text(PrefsConfig.getUserName(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white)),
                    ),
                    subtitle: Center(
                      child: Text("Kanban 3.0",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white, fontSize: 20)),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        CustomDialogBox.logoutDialogIOS(context, yes: () {
                          removeValues();

                          Get.offAllNamed('/login');
                        });
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
                SizedBox(height: 30)
              ],
            ),
          ),
          // CustomDashboardAppbar(
          //   title: "Kanban 3.0",
          //   // todo put here profile image instead of ierpImage
          //   //logo: strProfilePic.isNotEmpty
          //   //    ? NetworkImage(strProfilePic)
          //   //    : AssetImage(profileImage),

          //   //logo: profileImage,
          //   uName: PrefsConfig.getUserName().toUpperCase(),
          //   onLogoTap: () {
          //     CustomDialogBox.logoutDialogIOS(context, yes: () {
          //       removeValues();

          //       Get.offAllNamed('/login');
          //     });
          //   },
          // ),
          // !Grid View Start from here
          Container(
            color: ColorConfig.primaryAppColor,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  // ! Dashboard Cards Start From here
                  DashCardView(
                    title: "Department\nView",
                    onTap: () {
                      Get.toNamed(
                        '/deptList',
                      );
                    },
                    image: bankImage,
                  ),
                  DashCardView(
                      title: "Employee\nView",
                      onTap: () {
                        Get.toNamed('/empList', arguments: userId);
                      },
                      image: empImage),
                  DashCardView(
                      title: "Task\nApproval",
                      onTap: () {
                        Get.toNamed('/taskAppr', arguments: userId);
                      },
                      image: taskImage),
                  DashCardView(
                      title: "Request \nApproval",
                      onTap: () {
                        Get.toNamed('/reqAppr', arguments: userId);
                      },
                      image: stampImage),
                  DashCardView(
                    title: "Notifications",
                    onTap: () {
                      Get.toNamed('/notification', arguments: userId);
                    },
                    image: bellImage,
                  ),
                  DashCardView(
                      title: "Profile",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen((p0) {}),
                            ));
                        // navigateToProfileScreen();
                      },
                      image: userImage),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(child: ImageConfig.fromAsset(imagePath: deltaImage, size: 60)),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              'Version:  1.0.0',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  void navigateToProfileScreen() async {
    final updatedProfilePicURL = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(
                (p0) {},
              )),
    );

    // Check if the result contains an updated profilePicURL and update the state
    if (updatedProfilePicURL != null) {
      setState(() {
        profilePicURL = updatedProfilePicURL;
      });
    }
  }
}
