import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Model/TaskModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../Configuration/ColorConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Controllers/Department/DepartmentController.dart';
import '../../Widgets/RadioButton/RadioTileList.dart';
import '../../Widgets/TabBar/CustomTab.dart';

class DeptEmpDetailScreen extends StatefulWidget {
  @override
  State<DeptEmpDetailScreen> createState() => _DeptEmpDetailScreenState();
}

class _DeptEmpDetailScreenState extends State<DeptEmpDetailScreen>
    with TickerProviderStateMixin {
  TabController mainTabCltr;
  TabController mainTabCltr1;
  TabController tabController1;
  TabController tabController2;
  TabController tabController3;
  TabController tabController4;
  TabController tabController5;
  TabController tabController6;
  String _selectedOption;
  String _selectedOption1;
  @override
  void initState() {
    PrefsConfig.setWorkingEMP(true);

    mainTabCltr = TabController(length: 3, vsync: this, initialIndex: 2);
    tabController1 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController2 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController3 = TabController(length: 1, vsync: this, initialIndex: 0);
    mainTabCltr1 = TabController(length: 3, vsync: this, initialIndex: 2);
    tabController4 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController5 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController6 = TabController(length: 1, vsync: this, initialIndex: 0);
    selectedRadioTile = 1;
    selectedRadioTile1 = 3;

    super.initState();
  }

  String priority = "1";
  String taskGiven = "All";
  String viewFor = "Team";
  @override
  void dispose() {
    // todo Controller first dispose
    mainTabCltr.dispose();
    tabController1.dispose();
    tabController2.dispose();
    tabController3.dispose();

    // todo Controller second dispose
    mainTabCltr1.dispose();
    tabController4.dispose();
    tabController5.dispose();
    tabController6.dispose();
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
  bool isPriority = true;
  var empDetail = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppbar.profileImageAppbar(
      //     lead: lead(),
      //     actions: [
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.search),
      //       ),
      //       // IconButton(
      //       //   onPressed: () {},
      //       //   icon: Icon(Icons.filter_alt),
      //       // )
      //     ],
      //     empName: empDetail[0],
      //     empType: empDetail[1],
      //     empSt: empDetail[3],
      //     pic: empDetail[2]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isFilter == false
                ? Container(
                    color: ColorConfig.primaryLightAppColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        CustomTab(
                          mainController: mainTabCltr,
                          tabs: [
                            CustomTabDeptContent(text: "Daily Checklist"),
                            CustomTabDeptContent(text: "Objective"),
                            CustomTabDeptContent(text: "Kanban"),
                          ],
                          onTab: (v) {
                            if (v == 0) {
                              setState(() {
                                priority = "3";
                                isPriority = false;
                                PrefsConfig.setWorkingEMP(false);
                                print(v);
                              });
                            } else if (v == 1) {
                              setState(() {
                                priority = "2";
                                isPriority = false;
                                PrefsConfig.setWorkingEMP(false);
                                print(v);
                              });
                            } else if (v == 2) {
                              setState(() {
                                priority = "1";
                                isPriority = true;
                                PrefsConfig.setWorkingEMP(true);
                                print(v);
                              });
                            }
                          },
                        ),
                        CustomTab(
                          mainController: mainTabCltr1,
                          tabs: [
                            CustomTabContent(
                                text: "Pending - ${empDetail[4]}",
                                image: pendingImage),
                            CustomTabContent(
                              text: "Working - ${empDetail[6]}",
                              image: workImage,
                            ),
                            CustomTabContent(
                              text: "Done - ${empDetail[5]}",
                              image: doneImage,
                            ),
                          ],
                          onTab: (v) {
                            if (v == 0) {
                              setState(() {
                                priority = "3";
                                isPriority = false;
                                PrefsConfig.setWorkingEMP(false);
                                print(v);
                              });
                            } else if (v == 1) {
                              setState(() {
                                priority = "2";
                                isPriority = false;
                                PrefsConfig.setWorkingEMP(false);
                                print(v);
                              });
                            } else if (v == 2) {
                              setState(() {
                                priority = "1";
                                isPriority = true;
                                PrefsConfig.setWorkingEMP(true);
                                print(v);
                              });
                            }
                          },
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
                                    setState(() {
                                      taskGiven = 'All';
                                    });
                                    print(taskGiven);
                                  },
                                  title: "All Task",
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
                                  value: 4),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.3,
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                              future: DepartmentController
                                  .getDepartmentListByEmpAPI(
                                taskGiven: "All",
                                viewFor: "kanban",
                                userId: PrefsConfig.getUserId(),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                      child: Center(
                                          child: snapshot.connectionState !=
                                                  ConnectionState.done
                                              ? CircularProgressIndicator()
                                              : Text("NO Data Found!")));
                                } else {
                                  return Container(
                                    
                                    width: Get.width / 1.1,
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: snapshot.data.result.length,
                                        itemBuilder: (context, index) {
                                          var list =
                                              snapshot.data.result[index];
                                          return TaskListUI(
                                            model: TaskModel(result: [list]),
                                          );
                                        }),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}

class TaskListUI extends StatelessWidget {
  final TaskModel model;

  const TaskListUI({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(
        //   color: Colors.red,
        //   width: 2.0,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            model.result[0].mainPoint,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
