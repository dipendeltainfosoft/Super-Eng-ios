import 'package:duke_kanban/Controllers/TaskApproval/TaskController.dart';
import 'package:duke_kanban/Widgets/DateTime/DateTime.dart';
import 'package:flutter/material.dart';

import '../../Configuration/ColorConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Widgets/Appbar/ImageAppbar.dart';
import '../../Widgets/DialogBox/DialogBox.dart';
import '../../Widgets/Messages/Snackbar.dart';
import '../../Widgets/Others/CustomTexts.dart';
import '../../Widgets/TabBar/CustomTab.dart';

class TaskApprovalScreen extends StatefulWidget {
  const TaskApprovalScreen({Key key}) : super(key: key);

  @override
  _TaskApprovalScreenState createState() => _TaskApprovalScreenState();
}

class _TaskApprovalScreenState extends State<TaskApprovalScreen>
    with TickerProviderStateMixin {
  List<dynamic> _initialData = [];
  List<dynamic> _searchResults = [];

  bool _isP = false;
  bool _isD = false;
  bool _isC = false;
  bool _isA = false;

  TabController mainTabCltr;
  TabController tabController1;
  TabController tabController2;
  TabController tabController3;
  TabController tabController4;

  String listType = "DailyWork";

  @override
  void initState() {
    mainTabCltr = TabController(length: 2, vsync: this, initialIndex: 0);
    // tabController1 = TabController(length: 1, vsync: this, initialIndex: 0);
    // tabController2 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController3 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController4 = TabController(length: 1, vsync: this, initialIndex: 0);
    listType = "Kanban";
    getTaskApprovalListAPICall();

    super.initState();
  }

  @override
  void dispose() {
    mainTabCltr.dispose();
    // tabController1.dispose();
    tabController3.dispose();
    tabController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedData =
        _searchResults.isNotEmpty ? _searchResults : _initialData;

    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
        screenName: "Task Approval",
        lead: lead(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorConfig.primaryLightAppColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  CustomTab(
                    mainController: mainTabCltr,
                    tabs: [
                      // CustomTabDeptContent(
                      //   text: "Daily Checklist",
                      // ),
                      // CustomTabDeptContent(
                      //   text: "Objective",
                      // ),
                      CustomTabDeptContent(
                        text: "Kanban",
                      ),
                      CustomTabDeptContent(
                        text: "Periodic",
                      ),
                    ],
                    onTab: (v) {
                      // if (v == 0) {
                      //   setState(() {
                      //     listType = "DailyWork";
                      //     getTaskApprovalListAPICall();
                      //   });
                      // } else if (v == 1) {
                      //   setState(() {
                      //     listType = "Objective";
                      //     getTaskApprovalListAPICall();
                      //   });
                      // } else
                      if (v == 0) {
                        setState(() {
                          listType = "Kanban";

                          getTaskApprovalListAPICall();
                        });
                      } else if (v == 1) {
                        setState(() {
                          listType = "PeriodicWork";
                          getTaskApprovalListAPICall();
                        });
                      }

                      // if (v == 0) {
                      //   setState(() {
                      //     listType = "Kanban";
                      //     getTaskApprovalListAPICall();
                      //   });
                      // } else if (v == 1) {
                      //   setState(() {
                      //     listType = "PeriodicWork";
                      //     getTaskApprovalListAPICall();
                      //   });
                      // }
                    },
                  ),
                ],
              ),
            ),
            //_cardShow(),
            _dataSetUI(displayedData),
          ],
        ),
      ),
    );
  }

  Widget _cardShow() {
    return Column(
      children: [
        Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: ColorConfig.primaryDarkAppColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        '577',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check,
                      size: 20.0,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  'RC',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: ColorConfig.dukeLightColor,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Task was done After Taking a Lecture',
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F4F4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Done By',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ColorConfig.dukeLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F4F4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Given By',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ColorConfig.dukeLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F4F4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'How to Plan',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ColorConfig.dukeLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F4F4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Target Date',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ColorConfig.dukeLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F4F4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Remarks',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ColorConfig.dukeLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F4F4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Approve By',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: ColorConfig.dukeLightColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Chip(
                //       label: Text('Plan'),
                //       backgroundColor: Colors.grey[300],
                //       labelStyle: TextStyle(fontSize: 12.0, fontFamily: 'hind'),
                //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12.0),
                //       ),
                //     ),
                //     SizedBox(width: 8.0),
                //     Chip(
                //       label: Text('Do'),
                //       backgroundColor: Colors.grey[300],
                //       labelStyle: TextStyle(fontSize: 12.0, fontFamily: 'hind'),
                //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12.0),
                //       ),
                //     ),
                //     SizedBox(width: 8.0),
                //     Chip(
                //       label: Text('Check'),
                //       backgroundColor: Colors.grey[300],
                //       labelStyle: TextStyle(fontSize: 12.0, fontFamily: 'hind'),
                //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12.0),
                //       ),
                //     ),
                //     SizedBox(width: 8.0),
                //     Chip(
                //       label: Text('Act'),
                //       backgroundColor: Colors.grey[300],
                //       labelStyle: TextStyle(fontSize: 12.0, fontFamily: 'hind'),
                //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12.0),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showDisApproveAlertDialog(context, _initialData, 0);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: ColorConfig.primaryDarkAppColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              size: 18.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'DisApprove',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {
                        showApproveAlertDialog(context, _initialData, 0);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: ColorConfig.primaryDarkAppColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 18.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'Approve',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dataSetUI(List<dynamic> displayedData) {
    return displayedData.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Center(
                child: Text('No Task available'),
              ),
            ],
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 1.25,
            child: ListView.builder(
              itemCount: displayedData.length,
              itemBuilder: (context, index) {
                if (displayedData[index]['PDCA'].toString().contains('A')) {
                  _isP = true;
                  _isD = true;
                  _isC = true;
                  _isA = true;
                } else if (displayedData[index]['PDCA']
                    .toString()
                    .contains('C')) {
                  _isP = true;
                  _isD = true;
                  _isC = true;
                } else if (displayedData[index]['PDCA']
                    .toString()
                    .contains('D')) {
                  _isP = true;
                  _isD = true;
                } else if (displayedData[index]['PDCA']
                    .toString()
                    .contains('P')) {
                  _isP = true;
                }

                return Column(
                  children: [
                    Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: ColorConfig.primaryDarkAppColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: CustomText(
                                    data: displayedData[index]['No'],
                                    fSize: 14,
                                    fColor: Colors.white,
                                    fWeight: FontWeight.bold,
                                    align: TextAlign.start,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            CustomText(
                              data: displayedData[index]['Project'],
                              fSize: 16,
                              fColor: Colors.black,
                              fWeight: FontWeight.bold,
                              align: TextAlign.start,
                            ),
                            SizedBox(height: 4.0),
                            CustomText(
                              data: displayedData[index]['MainPoint']
                                  .toString()
                                  .replaceAll("u0026", "&")
                                  .replaceAll("u0027", "'"),
                              fSize: 14,
                              fColor: ColorConfig.dukeLightColor,
                              fWeight: FontWeight.bold,
                              align: TextAlign.start,
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F4F4),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'Done By',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomText(
                                  data: displayedData[index]['EmpName']
                                      .toString()
                                      .replaceAll("u0026", "&")
                                      .replaceAll("u0027", "'"),
                                  fSize: 12,
                                  fColor: ColorConfig.dukeLightColor,
                                  fWeight: FontWeight.normal,
                                  align: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F4F4),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'Given By',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomText(
                                  data: displayedData[index]['PointGivenByName']
                                      .toString()
                                      .replaceAll("u0026", "&")
                                      .replaceAll("u0027", "'"),
                                  fSize: 12,
                                  fColor: ColorConfig.dukeLightColor,
                                  fWeight: FontWeight.normal,
                                  align: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F4F4),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'How to Plan',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomText(
                                  data: displayedData[index]['Remarks']
                                      .toString()
                                      .replaceAll("u0026", "&")
                                      .replaceAll("u0027", "'"),
                                  fSize: 12,
                                  fColor: ColorConfig.dukeLightColor,
                                  fWeight: FontWeight.normal,
                                  align: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F4F4),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'Target Date',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomText(
                                  data: convertDateFormat(
                                      displayedData[index]['TargetDt'],
                                      "MM/dd/yyyy hh:mm:ss a",
                                      "dd-MMM-yyyy"),
                                  fSize: 12,
                                  fColor: ColorConfig.dukeLightColor,
                                  fWeight: FontWeight.normal,
                                  align: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F4F4),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'Remarks',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomText(
                                  data: displayedData[index]['RemarksLn']
                                      .toString()
                                      .replaceAll("u0026", "&")
                                      .replaceAll("u0027", "'"),
                                  fSize: 12,
                                  fColor: ColorConfig.dukeLightColor,
                                  fWeight: FontWeight.normal,
                                  align: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F4F4),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    'Approve By',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                CustomText(
                                  data: displayedData[index]['ApprovedBY']
                                      .toString()
                                      .replaceAll("u0026", "&")
                                      .replaceAll("u0027", "'"),
                                  fSize: 12,
                                  fColor: ColorConfig.dukeLightColor,
                                  fWeight: FontWeight.normal,
                                  align: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Chip(
                                  label: Text('Plan'),
                                  backgroundColor: _isP
                                      ? ColorConfig.dukeLightColor
                                      : Colors.grey[300],
                                  //backgroundColor: Colors.grey[300],
                                  labelStyle: TextStyle(
                                      fontSize: 12.0, fontFamily: 'hind'),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Chip(
                                  label: Text('Do'),
                                  backgroundColor: _isD
                                      ? ColorConfig.dukeLightColor
                                      : Colors.grey[300],
                                  //backgroundColor: Colors.grey[300],
                                  labelStyle: TextStyle(
                                      fontSize: 12.0, fontFamily: 'hind'),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Chip(
                                  label: Text('Check'),
                                  backgroundColor: _isC
                                      ? ColorConfig.dukeLightColor
                                      : Colors.grey[300],
                                  //backgroundColor: Colors.grey[300],
                                  labelStyle: TextStyle(
                                      fontSize: 12.0, fontFamily: 'hind'),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Chip(
                                  label: Text('Act'),
                                  backgroundColor: _isA
                                      ? ColorConfig.dukeLightColor
                                      : Colors.grey[300],
                                  //backgroundColor: Colors.grey[300],
                                  labelStyle: TextStyle(
                                      fontSize: 12.0, fontFamily: 'hind'),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDisApproveAlertDialog(
                                        context, displayedData, index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: ColorConfig.primaryDarkAppColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 18.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.0),
                                        CustomText(
                                          data: 'DisApprove',
                                          fSize: 14,
                                          fColor: Colors.white,
                                          fWeight: FontWeight.normal,
                                          align: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                InkWell(
                                  onTap: () {
                                    showApproveAlertDialog(
                                        context, displayedData, index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: ColorConfig.primaryDarkAppColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 18.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.0),
                                        CustomText(
                                          data: 'Approve',
                                          fSize: 14,
                                          fColor: Colors.white,
                                          fWeight: FontWeight.normal,
                                          align: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ));
  }

  void showApproveAlertDialog(
      BuildContext context, List<dynamic> displayedData, int index) async {
    await CustomDialogBox.alertDialogBox(
      context,
      titleText: 'Update',
      msgText: 'Are you sure you want to approve this task ?',
      copyFunc: () {
        updateTaskApprovalAPICall(displayedData[index]['ddId'], 'A');
      },
    );
  }

  void showDisApproveAlertDialog(
      BuildContext context, List<dynamic> displayedData, int index) async {
    await CustomDialogBox.alertDialogBox(
      context,
      titleText: 'Update',
      msgText: 'Are you sure you want to disapprove this task ?',
      copyFunc: () {
        updateTaskApprovalAPICall(displayedData[index]['ddId'], 'D');
      },
    );
  }

  void getTaskApprovalListAPICall() {
    try {
      _initialData = [];

      TaskController.getTaskApprovalList(
        userId: PrefsConfig.getUserId() ?? "",
        type: listType ?? "",
        context: context,
      ).then((value) => {
            if (value['status'] == "200")
              {
                setState(() {
                  //Map<String, dynamic> map = json.decode(response.body);
                  List<dynamic> jsonData = value["result"];
                  setState(() {
                    _initialData = jsonData;
                  });
                  //print(jsonData);
                  CustomSnackbar.snackbarNormal(context, value['message']);
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

  void updateTaskApprovalAPICall(String id, String status) {
    try {
      TaskController.getUpdateTaskApprovalList(
              userId: PrefsConfig.getUserId() ?? "",
              dDid: id,
              status: status,
              context: context)
          .then((value) => {
                if (value['status'] == "200")
                  {
                    setState(() {
                      Navigator.pop(context);
                      CustomSnackbar.snackbarNormal(context, value['message']);
                      getTaskApprovalListAPICall();
                    }),
                  }
                else
                  {
                    setState(() {
                      CustomSnackbar.snackbarNormal(
                          context,
                          value != null
                              ? value['result']
                              : 'Invalid response from server');
                    })
                  },
              });
    } catch (e) {
      print(e);
      CustomSnackbar.snackbarNormal(context, e.toString());
    }
  }
}
