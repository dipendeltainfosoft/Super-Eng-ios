import 'dart:convert';
import 'dart:io';
import 'package:duke_kanban/Controllers/Others/dashboard_controller.dart';
import 'package:http/http.dart' as http;

import 'package:dotted_border/dotted_border.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Widgets/TextFields/TextFields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Animation/FadeAnimation.dart';
import '../../Configuration/APIConfig.dart';
import '../../Configuration/ColorConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Controllers/Profile/ProfileController.dart';
import '../../Networks/Connections/Connection.dart';
import '../../Widgets/Appbar/ImageAppbar.dart';
import '../../Widgets/Messages/Snackbar.dart';
import '../../Widgets/Others/CustomTexts.dart';

class  ProfileScreen extends StatefulWidget {
  final Function(String) onProfileUpdate;

  const ProfileScreen(this.onProfileUpdate, {Key key, }) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDisable = false;
  bool isPass = false;
  bool isPassEnable = false;

  bool isEditIconEnable = true;
  bool isCheckIconEnable = false;

  final GetXNetworkManager networkManager = Get.put(GetXNetworkManager());

  TextEditingController edtName = TextEditingController();
  TextEditingController edtUserName = TextEditingController();
  TextEditingController edtPass = TextEditingController();

  // File selectedImage;
  File _pImage;

  String strName = '';
  String strUserName = '';
  String strPassword = '';
  String strProfilePic = '';
  @override
  void initState() {
    // PermissionChecker.checkAndRequestPermissionIfNeeded(context);
    getProfileDetailsAPICall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppbar.materialAppbar(
          screenName: "Profile",
          /*actions: [
            Tooltip(
              message: "Logout",
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            )
          ],*/
          lead:null
            // IconButton(
            //   onPressed: () {
            //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPage(),), (route) => false);
            //
            //   },
            //   icon: Icon(
            //     Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
            //     color: Colors.white,
            //   )),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            FadeAnimation(
              1.1,
              Center(
                child: Stack(
                  children: [
                    DottedBorder(
                        borderType: BorderType.Circle,
                        dashPattern: [6, 3, 2, 3],
                        color: ColorConfig.primaryAppColor,
                        strokeWidth: 2,
                        /*child: CircleAvatar(
                        backgroundColor: Colors.white,
                        //backgroundImage: AssetImage(profileImage),
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage)
                            : AssetImage(profileImage),
                        radius: 80,
                      ),*/
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                          // _pImage != null
                          //     ? FileImage(
                          //     _pImage) // Display the selected image if available
                          //     : (strProfilePic.isNotEmpty
                          //     ? NetworkImage(strProfilePic)
                          //     :
                          AssetImage(profileImage),
                          radius: 80,
                        )),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: ColorConfig.primaryAppColor,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.cyan,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: ColorConfig.primaryAppColor,behavior: SnackBarBehavior.floating,content: Row(
                              children: [
                                Icon(Icons.info_outline,color: Colors.white,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Currently This feature is not available'),
                              ],
                            )));
                            // imagePickerBottomSheet(context);
                            /*Get.toNamed('/updateprofile',
                                arguments: [name, mobile, email, userId, pass]);*/
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(thickness: 1),
            SizedBox(
              height: 30,
            ),
            FadeAnimation(
              1.2,
              ListTile(
                  title: CustomText(
                    data: "Name",
                    fColor: Colors.black,
                    fWeight: FontWeight.bold,
                  ),
                  subtitle: CustomProfileTextField(
                      isEnabled: false,
                      //hintText: strName,
                      hintText: '',
                      controller: edtName,
                      obscureText: false)
                // leading: IconButton(
                //   onPressed: () {},
                //   // icon: ImageConfig.fromAsset(imagePath: userIcon, size: 30),
                // ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
              1.3,
              ListTile(
                  title: CustomText(
                    data: "User name",
                    fColor: Colors.black,
                    fWeight: FontWeight.bold,
                  ),
                  subtitle: CustomProfileTextField(
                      isEnabled: false,
                      //hintText: strUserName,
                      hintText: '',
                      controller: edtUserName,
                      obscureText: false)
                // leading: IconButton(
                //   onPressed: () {},
                //   // icon: ImageConfig.fromAsset(imagePath: mobileIcon, size: 30),
                // ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
              1.4,
              ListTile(
                title: CustomText(
                  data: "Password",
                  fColor: Colors.black,
                  fWeight: FontWeight.bold,
                ),
                /*subtitle: CustomProfileTextField(
                      isEnabled: isPassEnable,
                      hintText: PrefsConfig.getPass(),
                      controller: edtPass,
                      obscureText: isPass ? false : true,
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              isPass = !isPass;
                            });
                          },
                          icon: Icon(
                            isPass ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black,
                          ))),*/
                subtitle: _addPasswordUpdate(),
                // leading: IconButton(
                //   onPressed: () {},
                //   // icon: ImageConfig.fromAsset(imagePath: mailIcon, size: 30),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addPasswordUpdate() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 2,
          child: CustomProfileTextField(
            isEnabled: isPassEnable,
            //hintText: strPassword,
            hintText: '',
            controller: edtPass,
            obscureText: isPass ? false : true,
          ),
        ),
        Visibility(
          visible: isEditIconEnable,
          child: IconButton(
            onPressed: () {
              setState(() {
                isPass = !isPass;
              });
            },
            icon: Icon(
              isPass ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child: Row(
              children: [
                Visibility(
                  visible: isEditIconEnable,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isPass = !isPass;
                          isPassEnable = true;
                          isEditIconEnable = false;
                          isCheckIconEnable = true;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      )),
                ),
                Visibility(
                  visible: isCheckIconEnable,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          updatePasswordAPICall();
                        });
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.black,
                      )),
                ),
                Visibility(
                  visible: isCheckIconEnable,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isPass = !isPass;
                          isPassEnable = false;
                          isEditIconEnable = true;
                          isCheckIconEnable = false;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                )
              ],
            ))
      ],
    );
  }

  void imagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                //padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: _cameraAttach(context)),
                    Expanded(flex: 1, child: _galleryAttach(context)),
                  ],
                ),
              )
            ],
          );
        });
  }

  Widget _cameraAttach(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        //List<XFile>? photos = await picker.pickMultiImage();
        pickCameraImage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageConfig.fromAsset(imagePath: cameraImage, size: 30),
          const Text(
            "Camera",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _galleryAttach(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);

        pickGalleryImage();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageConfig.fromAsset(imagePath: galleryImage, size: 30),
          const Text(
            "Gallery",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  File img1;
  final picker = ImagePicker();

  // Future pickGalleryImage() async {
  //   var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     img1 = File(pickedImage.path);
  //     updateProfilePickAPICall();
  //   });
  // }

  // File _pImage;
  final picker1 = ImagePicker();
  Future pickGalleryImage() async {
    var pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _pImage = File(pickedImage.path);
      print('On update Call');
      updateProfilePickAPICall();
    });
  }

  // Future pickGalleryImage() async {
  //   try {
  //     final image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     setState(() {
  //       selectedImage = File(image.path);
  //       //getFileName(selectedImage);
  //       updateProfilePickAPICall();

  //       print(image.path);
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  Future<void> pickCameraImage() async {
    var pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _pImage = File(pickedImage.path);
      print('On update Call');

      updateProfilePickAPICall();
    });
  }

  String getFileName(File file) {
    if (file != null) {
      String path = file.path;
      String fileName = path.split('/').last;
      String finalFileName = "IMG_" + fileName;
      return finalFileName;
    }
    return '';
  }

  void getProfileDetailsAPICall() {
    try {
      ProfileController.getProfileDetails(
        context: context,
        userId: PrefsConfig.getUserId() ?? "",
      ).then((value) => {
        isDisable = true,
        if (value['status'] == "200")
          {
            setState(() {
              strName = value['result'][0]['Name'];
              strUserName = value['result'][0]['UserName'];
              strPassword = value['result'][0]['Password'];
              strProfilePic = value['result'][0]['ProfilePic'].replaceAll(
                  'E:/Publish/DeltaWRLite3.0/UploadedPhotos/',
                  'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/');
              PrefsConfig.setProfilePic(strProfilePic);
              //strProfilePic = 'http://103.85.88.58/DukeWRLite/UploadedPhotos/977.jpg';

              edtName.text = strName;
              edtUserName.text = strUserName;
              edtPass.text = strPassword;
            }),
          }
        else
          {
            setState(() {
              isDisable = false;
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

  String backPhoto = '';

  void updateProfilePickAPICall() {
    try {

      imagePickAPI(userId: PrefsConfig.getUserId() ?? "", context: context)
          .then((value) => {
        if (value['status'] == "200")
          {
            setState(() {
              strName = value['result'][0]['Name'];
              strUserName = value['result'][0]['UserName'];
              strPassword = value['result'][0]['Password'];
              strProfilePic = value['result'][0]['ProfilePic'];
              PrefsConfig.setProfilePic(strProfilePic);
              // Get.find<DashboardController>().setProileImage(strProfilePic);
              widget.onProfileUpdate.call(strProfilePic);
              Navigator.pop(context, strProfilePic);

              edtName.text = strName;
              edtUserName.text = strUserName;
              edtPass.text = strPassword;

              CustomSnackbar.snackbarNormal(
                  context, "Profile Image Update Success.");
            }),
          }
        else
          {
            CustomSnackbar.snackbarNormal(
                context,
                value != null
                    ? value['message']
                    : 'Invalid response from server')
          },
      });
    } catch (e) {
      print(e);
      CustomSnackbar.snackbarNormal(context, e.toString());
    }
  }

  void updatePasswordAPICall() {
    try {
      ProfileController.updatePassword(
          userId: PrefsConfig.getUserId() ?? "",
          password: edtPass.text ?? "")
          .then((value) => {
        if (value['status'] == "200")
          {

            setState(() {
              strName = value['result'][0]['Name'];
              strUserName = value['result'][0]['UserName'];
              strPassword = value['result'][0]['Password'];
              strProfilePic = value['result'][0]['ProfilePic'];
              PrefsConfig.setProfilePic(strProfilePic);
              print('Image pick api called');
              //strProfilePic = 'http://103.85.88.58/DukeWRLite/UploadedPhotos/977.jpg';

              edtName.text = strName;
              edtUserName.text = strUserName;
              edtPass.text = strPassword;

              isPass = !isPass;
              isPassEnable = false;
              isEditIconEnable = true;
              isCheckIconEnable = false;

              CustomSnackbar.snackbarNormal(
                  context, 'Profile Password Update Success.');
            }),
          }
        else
          {
            CustomSnackbar.snackbarNormal(
                context,
                value != null
                    ? value['message']
                    : 'Invalid response from server')
          },
      });
    } catch (e) {
      print(e);
      CustomSnackbar.snackbarNormal(context, e.toString());
    }
  }

  Future imagePickAPI({@required String userId, @required context}) async {
    var request =
    http.MultipartRequest('POST', Uri.parse(profileUpdateDetailsURL));
    request.fields['UserId'] = userId;

    var pic = await http.MultipartFile.fromPath("Attachment", _pImage.path);
    _pImage != null ? request.files.add(pic) : null;

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseJson = json.decode(responsed.body);

    return responseJson;
  }

  void onProfileImageChanged(String newImageUrl) {
    print('on profile image set');
    Get.find<DashboardController>().setProileImage(newImageUrl);
  }
}