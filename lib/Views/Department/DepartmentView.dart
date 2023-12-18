import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Configuration/PrefsConfig.dart';
import 'package:duke_kanban/Controllers/Department/DepartmentController.dart';
import 'package:duke_kanban/Model/DeptModel.dart';
import 'package:duke_kanban/Widgets/Appbar/ImageAppbar.dart';
import 'package:duke_kanban/Widgets/Appbar/SpeedDial.dart';
import 'package:duke_kanban/Widgets/RadioButton/RadioTileList.dart';
import 'package:duke_kanban/Widgets/TabBar/CustomTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Configuration/ImageConfig.dart';
import '../../Model/EmpModel.dart';
import '../../Widgets/ListView/ListUI.dart';
import '../../Widgets/Others/CustomTexts.dart';

class DepartmentView extends StatefulWidget {
  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView>
    with TickerProviderStateMixin {
  // ! Tab Controller
  TabController mainTabCltr;
  TabController tabController1;
  TabController tabController2;
  TabController tabController3;
  String _selectedOption;
  String _selectedOption1;
  @override
  void initState() {
    PrefsConfig.setWorkingEMP(true);

    mainTabCltr = TabController(length: 3, vsync: this, initialIndex: 2);
    tabController1 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController2 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController3 = TabController(length: 1, vsync: this, initialIndex: 0);
    selectedRadioTile = 1;
    selectedRadioTile1 = 3;

    super.initState();
  }

  String priority = "1";
  String taskGiven = "All";
  String viewFor = "Team";
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
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedRadioTile1(int val) {
    setState(() {
      selectedRadioTile1 = val;
    });
  }

  bool isFilter = false;

  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool isPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
          lead: lead(),
          screenName: "Department List",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            isFilter == false
                ? Container(
                    color: ColorConfig.primaryLightAppColor,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 0),
                        //   child:

                        // CustomTab(
                        //   mainController: mainTabCltr,
                        //   tabs: [
                        //     // CustomTabDeptContent(text: "Daily Checklist"),
                        //     // CustomTabDeptContent(text: "Objective"),
                        //     CustomTabDeptContent(text: "Kanban"),
                        //   ],
                        //   onTab: (v) {
                        //     // if (v == 0) {
                        //     //   setState(() {
                        //     //     priority = "3";
                        //     //     isPriority = false;
                        //     //     PrefsConfig.setWorkingEMP(false);
                        //     //     print(v);
                        //     //   });
                        //     // } else if (v == 1) {
                        //     //   setState(() {
                        //     //     priority = "2";
                        //     //     isPriority = false;
                        //     //     PrefsConfig.setWorkingEMP(false);
                        //     //     print(v);
                        //     //   });
                        //     // }
                        //     if (v == 2) {
                        //       setState(() {
                        //         priority = "1";
                        //         isPriority = true;
                        //         PrefsConfig.setWorkingEMP(true);
                        //         print(v);
                        //       });
                        //     }
                        //   },
                        // ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Flexible(
                                child: CustomRadioButton(
                                    grpValue: selectedRadioTile,
                                    onChange: (val) {
                                      print("Radio Tile pressed $val");
                                      setSelectedRadioTile(val);

                                      setState(() {
                                        viewFor = "Team";
                                      });
                                      print(viewFor);
                                    },
                                    icon: teamIcon,
                                    // iconH: 30,
                                    title: "My Team",
                                    value: 1),
                              ),
                              Flexible(
                                child: CustomRadioButton(
                                    grpValue: selectedRadioTile,
                                    onChange: (val) {
                                      print("Radio Tile pressed $val");
                                      setSelectedRadioTile(val);
                                      setState(() {
                                        viewFor = "Company";
                                      });
                                      print(viewFor);
                                    },
                                    icon: bankImage,
                                    title: "My Company",
                                    value: 2),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: CustomRadioButton(
                                  grpValue: selectedRadioTile1,
                                  onChange: (val) {
                                    print("Radio Tile pressed $val");
                                    setSelectedRadioTile1(val);
                                    setState(() {
                                      taskGiven = 'All';
                                    });
                                    print(taskGiven);
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
                                    setState(() {
                                      taskGiven = 'By Me';
                                    });
                                    print(taskGiven);
                                  },
                                  title: "Given by me",
                                  icon: allTaskIcon,
                                  value: 4),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                : Text(""),
            Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<DepartmentModel>(
                future: DepartmentController.getDepartmentListByEmpAPI(
                  pri: priority,
                  taskGiven: taskGiven,
                  viewFor: viewFor,
                  userId: PrefsConfig.getUserId(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: snapshot.connectionState != ConnectionState.done
                          ? CircularProgressIndicator()
                          : Text("No Data Found!"),
                    );
                  } else if (snapshot.data.result == null ||
                      snapshot.data.result.isEmpty) {
                    return Center(child: Text("No Data Found!"));
                  } else {
                    return Container(
                      // width: Get.width / 1.1,
                      height: MediaQuery.of(context).size.height / 1,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (context, index) {
                          var list = snapshot.data.result[index];
                          return DepartmentListUI(
                            model: DepartmentModel(result: [list]),
                            pri: priority,
                            task: taskGiven,
                            index: index,
                            isPriority: isPriority,
                            view: viewFor,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),

            // Divider(
            //   indent: 20,
            //   thickness: 2,
            // ),
          ],
        ),
      ),
      floatingActionButton: CustomSpeedDial(),
    );
  }
}

class DepartmentListUI extends StatefulWidget {
  final DepartmentModel model;
  final int empCount;
  final String pri;
  final String task;
  final String view;
  final bool isPriority;
  final int index;

  DepartmentListUI({
    this.model,
    this.empCount,
    this.pri,
    this.task,
    this.view,
    this.isPriority,
    this.index,
  });

  @override
  State<DepartmentListUI> createState() => _DepartmentListUIState();
}

class _DepartmentListUIState extends State<DepartmentListUI> {
  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool isExpanded = false;
  double itemHeight = 100.0; // Replace with the actual height of each item
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ListTile(
            onTap: toggleExpansion,
            leading: CircleAvatar(
              backgroundColor: ColorConfig.dukeLightColor,
              child: widget.model.result[0].photolink == ""
                  ? CustomText(
                      data: widget.model.result[0].empDetails[0].empDept[0],
                      // data: widget.model.result[0].empDetails.isNotEmpty
                      //     ? widget.model.result[0].empDetails[0].empDept[0]
                      //     : "-",
                      fColor: Colors.white,
                    )
                  : ImageConfig.fromNetwork(
                      imagePath: widget.model.result[0].photolink
                          .toString()
                          .replaceAll(
                              'E:/Publish/DeltaWRLite3.0/UploadedPhotos/',
                              'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/')),
              radius: 20,
            ),
            title: CustomText(
              // data: widget.model.result[0].empDetails[0].empDept,
              data:
                  // widget.model.result[0].empDetails.isNotEmpty
                  //     ?
                  widget.model.result[0].empDetails[0].empDept,
              // : "-",
              fColor: Colors.black,
              fWeight: FontWeight.w700,
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallCustomContainer(
                  status: "P",
                  counts:
                      //  widget.model.result[0].empDetails.isNotEmpty
                      //     ?
                      widget.model.result[0].empDetails[0].pendingCnt,
                  // : "-",
                  secColor: ColorConfig.listBlue,
                ),
                SizedBox(
                  width: 15,
                ),
                Visibility(
                  visible: widget.isPriority,
                  child: SmallCustomContainer(
                      secColor: ColorConfig.listOrange,
                      status: "W",
                      counts:
                          // widget.model.result[0].empDetails.isNotEmpty
                          //     ?
                          widget.model.result[0].empDetails[0].workingCnt
                      // : "-",
                      ),
                ),
                SizedBox(
                  width: 15,
                ),
                SmallCustomContainer(
                  status: "D",
                  counts: widget.model.result[0].empDetails.isNotEmpty
                      ? widget.model.result[0].empDetails[0].doneCnt
                      : "-",
                  secColor: ColorConfig.listGreen,
                ),
                SizedBox(
                  width: 15,
                ),
                SmallCustomContainer(
                  status: "",
                  trailIcon: ImageConfig.fromAsset(
                      imagePath: teamIcon, color: ColorConfig.primaryAppColor),
                  counts: widget.model.result[0].empcount,
                  secColor: Colors.white,
                  border:
                      Border.all(color: ColorConfig.dukeLightColor, width: 0),
                  countColor: ColorConfig.primaryDarkAppColor,
                ),
              ],
            ),
          ),
          isExpanded
              ? Container(
                  child: FutureBuilder<EmpModel>(
                    future: DepartmentController.getEmpbyDeptId(
                      deptId: widget.model.result[0].deptId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.data == null ||
                          snapshot.data.result == null ||
                          snapshot.data.result.isEmpty) {
                        return Center(child: Text("No Data Found!"));
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.result.length,
                              itemBuilder: (context, index) {
                                var list = snapshot.data.result[index];
                                return EmpListUI(
                                  list: EmpModel(result: [list]),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                )
              : Text(""),
          Divider(height: 10, thickness: 2),
        ],
      ),
    );
  }
}

class EmpListUI extends StatelessWidget {
  final EmpModel list;

  const EmpListUI({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String empName = "";
    List<String> separated = list.result[0].empName.split(" ");

    String FC = separated[0];
    String LC = separated.length > 1 ? separated[1] : "";

    empName =
        FC.toUpperCase().substring(0, 1) + LC.toUpperCase().substring(0, 1);
    return Container(
      child: ListTile(
        onTap: () {
          Get.toNamed('/taskList', arguments: list.result[0].userId);
        },
        leading: CircleAvatar(
          backgroundColor: ColorConfig.dukeLightColor,
          child: CustomText(
            data: empName,
            fColor: Colors.white,
          ),
          radius: 20,
        ),
        title: CustomText(
          data: list.result[0].empName,
          fColor: Colors.black,
          fWeight: FontWeight.w700,
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallCustomContainer(
              status: "P",
              counts: list.result[0].pendingCnt,
              secColor: ColorConfig.listBlue,
            ),
            SizedBox(
              width: 15,
            ),
            Visibility(
              visible: PrefsConfig.getWorkingEMP(),
              child: SmallCustomContainer(
                secColor: ColorConfig.listOrange,
                status: "W",
                counts: list.result[0].workingCnt,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            SmallCustomContainer(
              status: "D",
              counts: list.result[0].doneCnt,
              secColor: ColorConfig.listGreen,
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
