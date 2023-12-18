import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Configuration/PrefsConfig.dart';
import 'package:duke_kanban/Controllers/Employee/EmployeeController.dart';
import 'package:duke_kanban/Widgets/Appbar/ImageAppbar.dart';
import 'package:duke_kanban/Widgets/Appbar/SpeedDial.dart';
import 'package:duke_kanban/Widgets/DateTime/DateTime.dart';
import 'package:duke_kanban/Widgets/RadioButton/RadioTileList.dart';
import 'package:duke_kanban/Widgets/TabBar/CustomTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Configuration/ImageConfig.dart';
import '../../Widgets/ListView/ListUI.dart';
import '../../Widgets/Messages/Snackbar.dart';
import '../../Widgets/Others/CustomTexts.dart';

class EmployeeView extends StatefulWidget {
  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView>
    with TickerProviderStateMixin {
  List<dynamic> _initialData = [];
  List<dynamic> _searchResults = [];

  // ! Tab Controller
  TabController mainTabCltr;
  TabController tabController1;
  TabController tabController2;
  TabController tabController3;

  @override
  void initState() {
    mainTabCltr = TabController(length: 3, vsync: this, initialIndex: 2);
    tabController1 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController2 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController3 = TabController(length: 1, vsync: this, initialIndex: 0);
    selectedRadioTile = 1;
    selectedRadioTile1 = 3;

    getEmployeeListAPICall();
    super.initState();
  }

  @override
  void dispose() {
    mainTabCltr.dispose();
    tabController1.dispose();
    tabController2.dispose();
    tabController3.dispose();
    super.dispose();
  }

  int selectedRadioTile;
  int selectedRadioTile1;

  String dynamicIcon;
  String dateTime = '';

  String secondTab = 'Team';
  String thirdTab = 'All';
  String priority = "1";
  //String taskGiven = "All";
  //String viewFor = "Team";

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      if (val == 1) {
        secondTab = 'Team';
      } else {
        secondTab = 'Company';
      }
      if (secondTab.isNotEmpty) {
        getEmployeeListAPICall();
      }
    });
  }

  setSelectedRadioTile1(int val) {
    setState(() {
      selectedRadioTile1 = val;
      if (val == 1) {
        thirdTab = 'All';
      } else {
        thirdTab = 'By Me';
      }
      if (thirdTab.isNotEmpty) {
        getEmployeeListAPICall();
      }
    });
  }

  bool isFilter = false;
  bool isPriority = true;
  bool isDynamicIcon = true;

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedData =
        _searchResults.isNotEmpty ? _searchResults : _initialData;

    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
          lead: lead(),
          screenName: "Employee List",
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isFilter = !isFilter;
                });
              },
              icon: Icon(
                Icons.filter_alt,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('/search');
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ]),
      body: Column(
        children: [
          isFilter == false
              ? Container(
                  color: ColorConfig.primaryLightAppColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      // CustomTab(
                      //   mainController: mainTabCltr,
                      //   tabs: [
                      //     CustomTabDeptContent(text: "Daily Checklist"),
                      //     CustomTabDeptContent(text: "Objective"),
                      //     CustomTabDeptContent(text: "Kanban"),
                      //   ],
                      //   onTab: (v) {
                      //     if (v == 0) {
                      //       setState(() {
                      //         priority = "2";
                      //         isPriority = false;
                      //         print(v);
                      //         getEmployeeListAPICall();
                      //       });
                      //     } else if (v == 1) {
                      //       setState(() {
                      //         priority = "3";
                      //         isPriority = false;
                      //         print(v);
                      //         getEmployeeListAPICall();
                      //       });
                      //     } else if (v == 2) {
                      //       setState(() {
                      //         priority = "1";
                      //         isPriority = true;
                      //         print(v);
                      //         getEmployeeListAPICall();
                      //       });
                      //     }
                      //   },
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: CustomRadioButton(
                                grpValue: selectedRadioTile,
                                onChange: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val);
                                },
                                title: "My Team",
                                icon: teamIcon,
                                value: 1),
                          ),
                          Flexible(
                            child: CustomRadioButton(
                                grpValue: selectedRadioTile,
                                onChange: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile(val);
                                },
                                title: "My Company",
                                icon: buildIcon,
                                value: 2),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: CustomRadioButton(
                                grpValue: selectedRadioTile1,
                                onChange: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile1(val);
                                },
                                title: "All Task",
                                icon: allTaskIcon,
                                value: 3),
                          ),
                          Flexible(
                            child: CustomRadioButton(
                                grpValue: selectedRadioTile1,
                                onChange: (val) {
                                  print("Radio Tile pressed $val");
                                  setSelectedRadioTile1(val);
                                },
                                icon: allTaskIcon,
                                title: "Given by me",
                                value: 4),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Text(""),
          //  todo this UI is Used in all common list

          /*ListTile(
          leading: CircleAvatar(
            backgroundColor: ColorConfig.dukeLightColor,
            child: Text("A"),
            radius: 20,
          ),
          title: Row(
            children: [
              CustomText(
                data: "Accounts",
                fColor: Colors.black,
                fWeight: FontWeight.w700,
              ),
              SizedBox(width: 15),
              CustomText(
                data: "- at Duke",
                fSize: 12,
                fColor: Colors.black,
                fWeight: FontWeight.w200,
              ),
              Spacer(),
              Icon(
                Icons.edit,
                size: 20,
                color: Colors.black,
              )
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallCustomContainer(
                status: "P",
                counts: "350",
                secColor: ColorConfig.listBlue,
              ),
              SizedBox(
                width: 15,
              ),
              SmallCustomContainer(
                secColor: ColorConfig.listOrange,
                status: "W",
                counts: "350",
              ),
              SizedBox(
                width: 15,
              ),
              SmallCustomContainer(
                status: "D",
                counts: "350",
                secColor: ColorConfig.listGreen,
              ),
              SizedBox(
                width: 15,
              ),
              Spacer(),
              CustomText(
                data: "07:00 PM",
                fSize: 12,
                fColor: Colors.black,
                fWeight: FontWeight.w200,
              ),
               SmallCustomContainer(
                status: "",
                trailIcon: ImageConfig.fromAsset(
                    imagePath: teamIcon, color: ColorConfig.primaryAppColor),
                counts: "9",
                secColor: Colors.white,
                border:
                    Border.all(color: ColorConfig.dukeLightColor, width: 0),
                countColor: ColorConfig.primaryDarkAppColor,
              ),
            ],
          ),
        ),*/

          /*Divider(
          indent: 20,
          thickness: 2,
        )*/

          //_cardUI(),

          Expanded(child: _dataSetUI1(displayedData)),
          // _dataSetUI(displayedData)
        ],
      ),
      floatingActionButton: CustomSpeedDial(),
    );
  }

  // Widget _cardUI() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               margin: EdgeInsets.only(
  //                 left: 10,
  //                 top: 5,
  //                 bottom: 5,
  //               ),
  //               child: Center(
  //                 child: buildAvatarText(" "),
  //                 /*child: CircleAvatar(
  //                   backgroundColor: ColorConfig.dukeLightColor,
  //                   child: Text("A"),
  //                   radius: 20,
  //                 ),*/
  //               ),
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: 15,
  //                 ),
  //                 Text(
  //                   "Accounts",
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w700,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 15,
  //                 ),
  //                 Text(
  //                   "- at Duke",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w200,
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Spacer(),
  //             Icon(
  //               Icons.check,
  //               size: 20,
  //               color: ColorConfig.primaryDarkAppColor,
  //             ),
  //             SizedBox(
  //               width: 10,
  //             )
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             SizedBox(
  //               width: 60,
  //             ),
  //             SmallCustomContainer(
  //               status: "P",
  //               counts: "350",
  //               secColor: ColorConfig.listBlue,
  //             ),
  //             SizedBox(width: 15),
  //             SmallCustomContainer(
  //               status: "W",
  //               counts: "350",
  //               secColor: ColorConfig.listOrange,
  //             ),
  //             SizedBox(width: 15),
  //             SmallCustomContainer(
  //               status: "D",
  //               counts: "350",
  //               secColor: ColorConfig.listGreen,
  //             ),
  //             Spacer(),
  //             Text(
  //               "07:00 PM",
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w200,
  //                 fontSize: 12,
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10,
  //             )
  //           ],
  //         ),
  //         Divider(
  //           thickness: 2,
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _dataSetUI(List<dynamic> displayedData) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: displayedData.length,
          itemBuilder: (context, index) {
            if (displayedData[index]['LastStatus'].toString().isNotEmpty) {
              if (displayedData[index]['LastStatus'] == 'O' ||
                  displayedData[index]['LastStatus'] == '') {
                dynamicIcon = singleTickIcon;
              } else if (displayedData[index]['LastStatus'] == 'R') {
                dynamicIcon = doubleTickIcon;
              } else if (displayedData[index]['LastStatus'] == 'C') {
                dynamicIcon = doubleTickOrangeIcon;
              } else if (displayedData[index]['LastStatus'] == 'D') {
                dynamicIcon = greenDotIcon;
              } else if (displayedData[index]['LastStatus'] == '-') {
                dynamicIcon = singleTickIcon;
                isDynamicIcon = false;
              }
            } else {
              isDynamicIcon = false;
            }

            if (displayedData[index]['LastDate'].toString().isNotEmpty) {
              String fromDateStr = convertDateFormat(
                  displayedData[index]['LastDate'],
                  'MM/dd/yyyy hh:mm:ss a',
                  'yyyy-MM-dd');
              String toDateStr = convertDateFormat(
                  displayedData[index]['LastDate'],
                  'MM/dd/yyyy hh:mm:ss a',
                  'yyyy-MM-dd');

              int daysDifference =
                  calculateDaysDifference(fromDateStr, toDateStr);

              if (daysDifference == 0) {
                dateTime = convertDateFormat(displayedData[index]['LastDate'],
                    'MM/dd/yyyy hh:mm:ss a', 'hh:mm a');
              } else if (daysDifference == -1) {
                dateTime = 'Yesterday';
              } else {
                dateTime = convertDateFormat(displayedData[index]['LastDate'],
                    'MM/dd/yyyy hh:mm:ss a', 'dd-MMM-yyyy');
              }
            } else {
              //na all task ma rebuild nhi thatu okay
              dateTime = '';
            }

            return Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Center(
                          child: displayedData[index]['PhotoLink']
                                  .toString()
                                  .isEmpty
                              ? buildAvatarText(displayedData[index]['EmpName'])
                              : buildAvatarNetworkImage(
                                  displayedData[index]['PhotoLink']),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          CustomText(
                            data: displayedData[index]['EmpName'],
                            fSize: 16,
                            fColor: Colors.black,
                            fWeight: FontWeight.bold,
                            align: TextAlign.start,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          CustomText(
                            data: displayedData[index]['EmpStatus'],
                            fSize: 12,
                            fColor: Colors.black,
                            fWeight: FontWeight.bold,
                            align: TextAlign.start,
                          ),
                        ],
                      ),
                      Spacer(),
                      Visibility(
                          visible: isDynamicIcon,
                          child: ImageConfig.fromAsset(
                              fit: BoxFit.fill,
                              imagePath: dynamicIcon,
                              size: 15)),
                      /*Icon(
                      Icons.check,
                      size: 20,
                      color: ColorConfig.primaryDarkAppColor,
                    ),*/
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 60,
                      ),
                      SmallCustomContainer(
                        status: "P",
                        counts: displayedData[index]['PendingCnt'],
                        secColor: ColorConfig.listBlue,
                      ),
                      SizedBox(width: 15),
                      Visibility(
                          visible: isPriority,
                          child: SmallCustomContainer(
                            status: "W",
                            counts: displayedData[index]['WorkingCnt'],
                            secColor: ColorConfig.listOrange,
                          )),
                      SizedBox(width: 15),
                      SmallCustomContainer(
                        status: "D",
                        counts: displayedData[index]['DoneCnt'],
                        secColor: ColorConfig.listGreen,
                      ),
                      Spacer(),
                      CustomText(
                        data: dateTime,
                        fSize: 14,
                        fColor: Colors.black,
                        fWeight: FontWeight.w200,
                        align: TextAlign.start,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _dataSetUI1(List<dynamic> displayedData) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: displayedData.length,
          itemBuilder: (context, index) {
            if (displayedData[index]['LastStatus'].toString().isNotEmpty) {
              if (displayedData[index]['LastStatus'] == 'O' ||
                  displayedData[index]['LastStatus'] == '') {
                dynamicIcon = singleTickIcon;
              } else if (displayedData[index]['LastStatus'] == 'R') {
                dynamicIcon = doubleTickIcon;
              } else if (displayedData[index]['LastStatus'] == 'C') {
                dynamicIcon = doubleTickOrangeIcon;
              } else if (displayedData[index]['LastStatus'] == 'D') {
                dynamicIcon = greenDotIcon;
              } else if (displayedData[index]['LastStatus'] == '-') {
                dynamicIcon = singleTickIcon;
                isDynamicIcon = false;
              }
            } else {
              isDynamicIcon = false;
            }

            if (displayedData[index]['LastDate'].toString().isNotEmpty) {
              String fromDateStr = convertDateFormat(
                  displayedData[index]['LastDate'],
                  'MM/dd/yyyy hh:mm:ss a',
                  'yyyy-MM-dd');
              String toDateStr = convertDateFormat(
                  displayedData[index]['LastDate'],
                  'MM/dd/yyyy hh:mm:ss a',
                  'yyyy-MM-dd');

              int daysDifference =
                  calculateDaysDifference(fromDateStr, toDateStr);

              if (daysDifference == 0) {
                dateTime = convertDateFormat(displayedData[index]['LastDate'],
                    'MM/dd/yyyy hh:mm:ss a', 'hh:mm a');
              } else if (daysDifference == -1) {
                dateTime = 'Yesterday';
              } else {
                dateTime = convertDateFormat(displayedData[index]['LastDate'],
                    'MM/dd/yyyy hh:mm:ss a', 'dd-MMM-yyyy');
              }
            } else {
              dateTime = '';
            }

            return InkWell(
              onTap: () {
                Get.toNamed('/taskList',
                    arguments: displayedData[index]['UserId']);
                print(displayedData[index]['EmpName']);
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Center(
                            child: displayedData[index]['PhotoLink']
                                    .toString()
                                    .isEmpty
                                ? buildAvatarText(
                                    displayedData[index]['EmpName'])
                                : buildAvatarNetworkImage(
                                    displayedData[index]['PhotoLink']),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              data: displayedData[index]['EmpName'],
                              fSize: 14,
                              fColor: Colors.black,
                              fWeight: FontWeight.w600,
                              align: TextAlign.start,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CustomText(
                              data: displayedData[index]['EmpStatus'],
                              fSize: 12,
                              fColor: Colors.black,
                              fWeight: FontWeight.w500,
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                        Spacer(),
                        Visibility(
                            visible: isDynamicIcon,
                            child: ImageConfig.fromAsset(
                                fit: BoxFit.fill,
                                imagePath: dynamicIcon,
                                size: 15)),
                        /*Icon(
                      Icons.check,
                      size: 20,
                      color: ColorConfig.primaryDarkAppColor,
                    ),*/
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        SmallCustomContainer(
                          status: "P",
                          counts: displayedData[index]['PendingCnt'],
                          secColor: ColorConfig.listBlue,
                        ),
                        SizedBox(width: 15),
                        Visibility(
                            visible: isPriority,
                            child: SmallCustomContainer(
                              status: "W",
                              counts: displayedData[index]['WorkingCnt'],
                              secColor: ColorConfig.listOrange,
                            )),
                        SizedBox(width: 15),
                        SmallCustomContainer(
                          status: "D",
                          counts: displayedData[index]['DoneCnt'],
                          secColor: ColorConfig.listGreen,
                        ),
                        Spacer(),
                        CustomText(
                          data: dateTime,
                          fSize: 14,
                          fColor: Colors.black,
                          fWeight: FontWeight.w200,
                          align: TextAlign.start,
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  void getEmployeeListAPICall() {
    try {
      _initialData = [];

      EmployeeController.getEmployeeList(
              //userId: PrefsConfig.getUserId() ?? "",
              userId: PrefsConfig.getUserId(),
              priority: priority,
              taskGiven: thirdTab,
              viewFor: secondTab,
              context: context)
          .then((value) => {
                if (value['status'] == "200")
                  {
                    setState(() {
                      List<dynamic> jsonData = value["result"];
                      setState(() {
                        _initialData = jsonData;
                      });
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

  int calculateDaysDifference(String fromDateStr, String toDateStr) {
    DateTime fromDate = DateTime.parse(fromDateStr);
    DateTime toDate = DateTime.parse(toDateStr);

    //Duration difference = toDate.difference(fromDate);
    Duration difference = fromDate.difference(toDate);
    return difference.inDays;
  }

  Widget buildAvatarText(String empName) {
    String first = "";

    if (empName.isNotEmpty) {
      List<String> separated = empName.split(" ");

      String FC = separated[0];
      String LC = separated.length > 1 ? separated[1] : "";

      first =
          FC.toUpperCase().substring(0, 1) + LC.toUpperCase().substring(0, 1);
    }

    /*TextToImageBuilder builder = TextToImageBuilder()
        .beginConfig()
        .withBorder(true)
        .textColor(Colors.white)
        .toUpperCase()
        .endConfig()
        .round();

    ImageProvider ic1 = builder.build(" $first ", backgroundColor: ColorConfig.primaryDarkAppColor);*/

    return CircleAvatar(
      //backgroundImage: ic1,
      backgroundColor: ColorConfig.dukeLightColor,
      child: CustomText(
        data: first,
        fSize: 20,
        fColor: Colors.white,
        fWeight: FontWeight.bold,
        align: TextAlign.center,
      ),
      radius: 20,
    );
  }

  Widget buildAvatarNetworkImage(String url) {
    return CircleAvatar(
      //backgroundImage: ImageConfig.fromNetwork(imagePath: ''),
      backgroundImage: NetworkImage(url),
      backgroundColor: ColorConfig.dukeLightColor,
      child: CustomText(
        data: '',
      ),
      radius: 20,
    );
  }

//_isP ? ColorConfig.dukeLightColor: Colors.grey[300]
//backgroundImage: selectedImage != null? FileImage(selectedImage) : AssetImage(profileImage),
}
