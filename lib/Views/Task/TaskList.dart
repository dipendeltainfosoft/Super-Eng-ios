import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:duke_kanban/Widgets/Buttons/LoginButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:duke_kanban/Configuration/APIConfig.dart';
import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Controllers/Employee/EmployeeController.dart';
import 'package:duke_kanban/Controllers/TaskApproval/TaskController.dart';
import 'package:duke_kanban/Model/EmpModel.dart';
import 'package:duke_kanban/Model/TaskModel.dart';
import 'package:duke_kanban/Widgets/DialogBox/BottomSheet.dart';
import 'package:duke_kanban/Widgets/ListView/TaskListUI.dart';
import 'package:duke_kanban/Widgets/Messages/Snackbar.dart';
import 'package:duke_kanban/Widgets/TextFields/TextFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Configuration/ColorConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Widgets/Appbar/ImageAppbar.dart';
import '../../Widgets/DateTime/DateTime.dart';
import '../../Widgets/Others/CustomTexts.dart';
import '../../Widgets/RadioButton/RadioTileList.dart';
import '../../Widgets/TabBar/CustomTab.dart';
import 'package:http/http.dart' as http;

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> with TickerProviderStateMixin {
  bool isFilter = false;
  TabController mainTabCltr;
  TabController tabController1;
  TabController tabController2;
  TabController tabController3;

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

  String priority = "1";

  String taskGiven = "All";
  String viewFor = "Kanban";

  bool isPriority = true;
  bool isDynamicIcon = true;

  bool isInsideLayoutShow = false;
  bool isDotShow = true;
  bool isDownShow = false;

  String dealerCategory;
  List dealerCategoryList = [];

  var assignTxtDate = TextEditingController();
  var howToPlan = TextEditingController();
  String assignDate;

  bool isKanbanUIShow = true;
  bool isObjectiveUIShow = false;
  bool isDailyUIShow = false;

  @override
  void initState() {
    selectedRadioTile = 1;
    selectedRadioTile1 = 4;
    mainTabCltr = TabController(length: 3, vsync: this, initialIndex: 2);
    tabController1 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController2 = TabController(length: 1, vsync: this, initialIndex: 0);
    tabController3 = TabController(length: 1, vsync: this, initialIndex: 0);
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

  TextEditingController taskCltr = TextEditingController();
  TextEditingController projectCltr = TextEditingController();
  TextEditingController dateCltr = TextEditingController();
  TextEditingController planCltr = TextEditingController();
  TextEditingController pIdCltr = TextEditingController();

  bool isMultipleUsers = false;

  List<String> selectedValues = [];
  List<String> selectedId = [];

  var userId = Get.arguments;
  List<TaskModel> itemList = [];
  String _searchText = 'Pending';

  @override
  Widget build(BuildContext context) {
    return isMultipleUsers == false
        ? Scaffold(
            appBar: CustomAppbar.materialAppbar(
                lead: lead(),
                screenName: "Task List",
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
                    onPressed: () {},
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
                              height: 10,
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
                            //         priority = "3";
                            //         isPriority = false;
                            //         PrefsConfig.setWorkingEMP(false);
                            //         viewFor = "Daily Work";
                            //         print(v);
                            //       });
                            //     } else if (v == 1) {
                            //       setState(() {
                            //         priority = "2";
                            //         viewFor = "Objective";
                            //         isPriority = false;
                            //         PrefsConfig.setWorkingEMP(false);
                            //         print(v);
                            //       });
                            //     } else if (v == 2) {
                            //       setState(() {
                            //         priority = "1";
                            //         viewFor = "Kanban";
                            //         isPriority = true;
                            //         PrefsConfig.setWorkingEMP(true);
                            //         print(v);
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
                                      _searchText = "Pending";
                                    },
                                    title: "Pending",
                                    icon: pendingImage,
                                    value: 1,
                                  ),
                                ),
                                Flexible(
                                  child: CustomRadioButton(
                                      grpValue: selectedRadioTile,
                                      onChange: (val) {
                                        print("Radio Tile pressed $val");
                                        setSelectedRadioTile(val);
                                        _searchText = "Working";
                                      },
                                      title: "Working",
                                      icon: workImage,
                                      value: 2),
                                ),
                                Flexible(
                                  child: CustomRadioButton(
                                    grpValue: selectedRadioTile,
                                    onChange: (val) {
                                      print("Radio Tile pressed $val");
                                      setSelectedRadioTile(val);
                                      _searchText = "Done";
                                    },
                                    title: "Done",
                                    icon: doneImage,
                                    value: 3,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                )
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
                                        setState(() {
                                          taskGiven = 'All';
                                        });
                                      },
                                      title: "All Task",
                                      icon: allTaskIcon,
                                      value: 4),
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
                                      },
                                      title: "Given by me",
                                      icon: allTaskIcon,
                                      value: 5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Text(""),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        height: isFilter == false
                            ? MediaQuery.of(context).size.height / 1.7
                            : MediaQuery.of(context).size.height / 1,
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<TaskModel>(
                            future: TaskController.getTaskList(
                                pri: priority,
                                taskGiven: taskGiven,
                                viewFor: viewFor,
                                userId: userId),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Center(
                                    child: Center(
                                        child: snapshot.connectionState !=
                                                ConnectionState.done
                                            ? CircularProgressIndicator()
                                            : Text("No Data Found!")));
                              } else {
                                itemList = snapshot.data.result
                                    .map((e) => TaskModel(result: [e]))
                                    .toList();
                                return Container(
                                  width: Get.width / 1.1,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data.result.length,
                                    // itemBuilder: (context, index) {
                                    //   var list = snapshot.data.result[index];
                                    //   return TaskListUI(
                                    //     model: TaskModel(
                                    //       result: [list],
                                    //     ),
                                    //     refresh: () {
                                    //       setState(() {
                                    //         TaskController.getTaskList(
                                    //           pri: priority,
                                    //           taskGiven: taskGiven,
                                    //           viewFor: viewFor,
                                    //           userId: userId,
                                    //         );
                                    //       });
                                    //     },
                                    //   );
                                    // },

                                    itemBuilder: (context, index) {
                                      final status = itemList[index]
                                          .result[0]
                                          .status
                                          .toLowerCase();
                                      if (status.contains(
                                          _searchText.toLowerCase())) {
                                        return TaskListUI(
                                          model: itemList[index],
                                          refresh: () {
                                            setState(() {});
                                          },
                                        );
                                      } else {
                                        return SizedBox.shrink(); // T
                                      }
                                    },
                                  ),
                                );
                              }
                            }),
                      ),
                    ]),
                  ),
                ),
                AddTaskUI(
                  priority: priority,
                  taskgiven: taskGiven,
                  userId: userId,
                  viewFor: viewFor,
                  dateCltr: dateCltr,
                  planCltr: planCltr,
                  projectCltr: projectCltr,
                  taskCltr: taskCltr,
                  pIdCltr: pIdCltr,
                  selectedId: selectedId,
                  selectedValues: selectedValues,
                  multiple: () {
                    setState(() {
                      isMultipleUsers = !isMultipleUsers;

                      Get.back();
                    });
                  },
                ),
              ],
            ),
          )
        : MultipleUsers(
            selectedId: selectedId,
            selectedValues: selectedValues,
            backButton: () {
              setState(() {
                isMultipleUsers = false;
              });
            },
          );
  }
}

// ignore: must_be_immutable
class AddTaskUI extends StatefulWidget {
  final TextEditingController taskCltr;
  final TextEditingController projectCltr;
  final TextEditingController dateCltr;
  final TextEditingController planCltr;
  final TextEditingController pIdCltr;
  final List<String> selectedValues;
  final List<String> selectedId;
  final String priority;
  final String taskgiven;
  final String viewFor;
  final String userId;

  VoidCallback multiple;

  AddTaskUI({
    this.taskCltr,
    this.projectCltr,
    this.dateCltr,
    this.planCltr,
    this.pIdCltr,
    this.selectedValues,
    this.selectedId,
    this.multiple,
    this.priority,
    this.taskgiven,
    this.viewFor,
    this.userId,
  });

  @override
  State<AddTaskUI> createState() => _AddTaskUIState();
}

class _AddTaskUIState extends State<AddTaskUI> {
  Future<void> pickDate1(
      BuildContext context, TextEditingController controller) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorConfig.primaryAppColor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: ColorConfig.primaryAppColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    ColorConfig.primaryAppColor, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );

    if (selected != null) {
      setState(() {
        controller.text = DateFormat('dd-MMM-yyyy').format(selected);
      });
    }
  }

  //* Attachment API start from here
  File img1;
  var pic1;
  final picker = ImagePicker();

  Future<void> selectPhoto(ImageSource source) async {
    await Permission.camera.request();

    var pickedImage = await picker.pickImage(
      source: source,
    );
    setState(() {
      img1 = File(pickedImage.path);
      if (pickedImage.path != null) {
        CustomSnackbar.snackbarNormal(context, "Image Selected");
      }
    });
  }

  String fileName = "";
  String tempFileName;

  Future<void> pickFile() async {
    // Check if permission is granted
    if (await Permission.storage.request().isGranted) {
      try {
        FilePickerResult result = await FilePicker.platform.pickFiles();
        if (result != null) {
          PlatformFile file = result.files.first;
          setState(() {
            fileName = file.path;
            tempFileName = file.name;
            print(fileName);
            debugPrint("filePicked===>${fileName}");
          });
          // CustomSnackbar.snackbarNormal(context, "Selected File");
          CustomSnackbar.snackbarNormal(context, "File picked: $e");
        } else {
          CustomSnackbar.snackbarNormal(context, "No Select File");
        }
      } on PlatformException catch (e) {
        CustomSnackbar.snackbarNormal(context, 'Failed to pick file: $e');

        print('Failed to pick file: $e');
      }
    } else {
      CustomSnackbar.snackbarNormal(context, "Permission not granted");
      print('Permission not granted');
      // You can show a dialog or message to inform the user
    }
  }

  // Future<bool> _requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //   ].request();

  //   return statuses[Permission.storage] == PermissionStatus.granted;
  // }

  // Future pickFile() async {
  //   try {
  //     FilePickerResult result = await FilePicker.platform.pickFiles();
  //     if (result != null) {
  //       PlatformFile file = result.files.first;
  //       setState(() {
  //         fileName = file.path;
  //         tempFileName = file.name;
  //         print(fileName);
  //       });
  //       CustomSnackbar.snackbarNormal(context, "Selected File");
  //     } else {
  //       CustomSnackbar.snackbarNormal(context, "No Select File");
  //     }
  //   } on PlatformException catch (e) {
  //     print('Failed to pick file: $e');
  //   }
  // }

  // selectDocs() async {
  //   final file = await FilePicker.platform.pickFiles(
  //     type: FileType.,

  //   );

  //   if (file != null) {
  //     setState(() {
  //       img1 = File(file.files.single.path);
  //     });
  //   }
  // }

  // Future fromGallery() async {
  //   var pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     img1 = File(pickedImage.path);
  //   });
  // }

  Future insertTaskAPI(
      {@required String givenToUserId,
      @required String givenByuserID,
      @required String task,
      @required String projectID,
      @required String dt,
      @required String targetDt,
      @required String howToPlan,
      @required String deptId}) async {
    var request = http.MultipartRequest('POST', Uri.parse(insertTask));
    request.fields['GivenToUserId'] = givenToUserId;
    request.fields['GivenByuserID'] = givenByuserID;
    request.fields['Task'] = task;
    request.fields['ProjectID'] = projectID;
    request.fields['Dt'] = dt;
    request.fields['TargetDt'] = targetDt;
    request.fields['HowToPlan'] = howToPlan;
    request.fields['DeptId'] = deptId;

    // img1 != null
    //     ? pic1 = await http.MultipartFile.fromPath("Attachment", img1.path)
    //     : request.fields['Attachment'] = "";
    img1 != null
        ? pic1 = await http.MultipartFile.fromPath(
            "Attachment",
            fileName == "" ? img1.path : fileName,
          )
        : request.fields['Attachment'] = "";

    img1 != null ? request.files.add(pic1) : null;
    // request.files.add(pic1);
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseJson = json.decode(responsed.body);
    TaskController.getTaskList(
        pri: widget.priority,
        taskGiven: widget.taskgiven,
        viewFor: widget.viewFor,
        userId: widget.userId);

    CustomSnackbar.snackbarNormal(context, responseJson['message']);

    print(responseJson['message']);
    return responseJson;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: ColorConfig.primaryLightAppColor2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Write Task....",
                    controller: widget.taskCltr,
                    obscureText: false,
                    title: "",
                    hintColor: ColorConfig.primaryAppColor,
                    fillColor: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: ColorConfig.primaryAppColor,
                  child: Transform.rotate(
                    angle: 3.14159 / 2,
                    child: IconButton(
                        onPressed: () {
                          CustomBottomSheet.taskListBottomSheet(context,
                              addTask: () {
                            errorLens();
                          }, suggestionsCallback: (pattern) async {
                            return await TaskController.getProjectsList();
                          }, onSelected: (val) {
                            setState(() {
                              widget.projectCltr.text = val['ProjectName'];
                              widget.pIdCltr.text = val['ProjectId'];
                            });
                          }, uploadFile: () {
                            CustomBottomSheet.chooseFilebottomSheet(context,
                                documentFile: () async {
                              Get.back();
                              pickFile();
                              // if ((await Permission.storage.isGranted)) {
                              //   print("accepted request");
                              //   pickFile();
                              // } else {
                              //   print("request");
                              //   Permission.storage.request();
                              // }
                            }, takePhoto: () async {
                              Get.back();
                              if ((await Permission.camera.isGranted)) {
                                selectPhoto(ImageSource.camera);
                              } else {
                                Permission.camera.request();
                              }
                            }, gall: () async {
                              Get.back();
                              if ((await Permission.photos.isGranted)) {
                                selectPhoto(ImageSource.gallery);
                                // debugPrint(
                                // "filepick==> ${ImageSource.gallery}");
                              } else {
                                Permission.photos.request();
                              }
                            });
                          }, selectDate: () {
                            Get.back();
                            pickDate1(context, widget.dateCltr)
                                .whenComplete(() => {
                                      CustomBottomSheet.taskListBottomSheet(
                                        context,
                                        addTask: () {
                                          errorLens();
                                        },
                                        suggestionsCallback: (pattern) async {
                                          return await TaskController
                                              .getProjectsList();
                                        },
                                        onSelected: (val) {
                                          setState(() {
                                            widget.projectCltr.text =
                                                val['ProjectName'];
                                            widget.pIdCltr.text =
                                                val['ProjectId'];
                                          });
                                        },
                                        uploadFile: () {
                                          CustomBottomSheet
                                              .chooseFilebottomSheet(context,
                                                  documentFile: () {
                                            Get.back();
                                            pickFile();
                                          }, takePhoto: () {
                                            Get.back();
                                            selectPhoto(ImageSource.camera);
                                          }, gall: () {
                                            Get.back();
                                            selectPhoto(ImageSource.gallery);
                                          });
                                        },
                                        selectDate: () {
                                          Get.back();
                                          pickDate1(context, widget.dateCltr)
                                              .whenComplete(() => {});
                                        },
                                        dateCltr: widget.dateCltr,
                                        planCltr: widget.planCltr,
                                        projectCltr: widget.projectCltr,
                                        taskCltr: widget.taskCltr,
                                        multipleusers: widget.multiple,

                                        // CustomBottomSheet.multipleUsers(
                                        //   context,
                                        //   Container(
                                        //     height: MediaQuery.of(context).size.height /
                                        //         1.3,
                                        //     width: MediaQuery.of(context).size.width,
                                        //     child: FutureBuilder(
                                        //         future:
                                        //             EmployeeController.getMultipleUsers(
                                        //                 context: context,
                                        //                 priority: "1",
                                        //                 taskGiven: "All",
                                        //                 viewFor: "All",
                                        //                 userId:
                                        //                     PrefsConfig.getUserId()),
                                        //         builder: (context, snapshot) {
                                        //           if (snapshot.data == null) {
                                        //             return Center(
                                        //                 child: Center(
                                        //                     child: snapshot
                                        //                                 .connectionState !=
                                        //                             ConnectionState.done
                                        //                         ? CircularProgressIndicator()
                                        //                         : Text(
                                        //                             "No Data Found!")));
                                        //           } else {
                                        //             return Container(
                                        //               width: Get.width / 1.1,
                                        //               child: ListView.builder(
                                        //                   physics:
                                        //                       BouncingScrollPhysics(),
                                        //                   itemCount: snapshot
                                        //                       .data.result.length,
                                        //                   itemBuilder:
                                        //                       (context, index) {
                                        //                     var list = snapshot
                                        //                         .data.result[index];
                                        //                     return InkWell(
                                        //                       onTap: () {
                                        //                         setState(() {
                                        //                           if (_selectedValues
                                        //                               .contains(list
                                        //                                   .empName)) {
                                        //                             _selectedValues
                                        //                                 .remove(list
                                        //                                     .empName);
                                        //                             selectedId.remove(
                                        //                                 list.userId);
                                        //                           } else {
                                        //                             _selectedValues.add(
                                        //                                 list.empName);
                                        //                             selectedId.add(
                                        //                                 list.userId);
                                        //                           }
                                        //                         });
                                        //                       },
                                        //                       child: MultipleUsers(
                                        //                         selectedValues:
                                        //                             _selectedValues,
                                        //                         model: EmpModel(
                                        //                             result: [list]),
                                        //                       ),
                                        //                     );
                                        //                   }),
                                        //             );
                                        //           }
                                        //         }),
                                        //   ),
                                        // );
                                      )
                                    });
                          },
                              dateCltr: widget.dateCltr,
                              planCltr: widget.planCltr,
                              projectCltr: widget.projectCltr,
                              taskCltr: widget.taskCltr,
                              multipleusers: widget.multiple
                              // CustomBottomSheet.multipleUsers(
                              //   context,
                              //   Container(
                              //     height: MediaQuery.of(context).size.height /
                              //         1.3,
                              //     width: MediaQuery.of(context).size.width,
                              //     child: FutureBuilder(
                              //         future:
                              //             EmployeeController.getMultipleUsers(
                              //                 context: context,
                              //                 priority: "1",
                              //                 taskGiven: "All",
                              //                 viewFor: "All",
                              //                 userId:
                              //                     PrefsConfig.getUserId()),
                              //         builder: (context, snapshot) {
                              //           if (snapshot.data == null) {
                              //             return Center(
                              //                 child: Center(
                              //                     child: snapshot
                              //                                 .connectionState !=
                              //                             ConnectionState.done
                              //                         ? CircularProgressIndicator()
                              //                         : Text(
                              //                             "No Data Found!")));
                              //           } else {
                              //             return Container(
                              //               width: Get.width / 1.1,
                              //               child: ListView.builder(
                              //                   physics:
                              //                       BouncingScrollPhysics(),
                              //                   itemCount: snapshot
                              //                       .data.result.length,
                              //                   itemBuilder:
                              //                       (context, index) {
                              //                     var list = snapshot
                              //                         .data.result[index];
                              //                     return InkWell(
                              //                       onTap: () {
                              //                         setState(() {
                              //                           if (_selectedValues
                              //                               .contains(list
                              //                                   .empName)) {
                              //                             _selectedValues
                              //                                 .remove(list
                              //                                     .empName);
                              //                             selectedId.remove(
                              //                                 list.userId);
                              //                           } else {
                              //                             _selectedValues.add(
                              //                                 list.empName);
                              //                             selectedId.add(
                              //                                 list.userId);
                              //                           }
                              //                         });
                              //                       },
                              //                       child: MultipleUsers(
                              //                         selectedValues:
                              //                             _selectedValues,
                              //                         model: EmpModel(
                              //                             result: [list]),
                              //                       ),
                              //                     );
                              //                   }),
                              //             );
                              //           }
                              //         }),
                              //   ),
                              // );
                              );
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: ColorConfig.primaryAppColor,
                  child: IconButton(
                      onPressed: () {
                        errorLens();
                      },
                      iconSize: 20,
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: SearchDropdownWOTitle(
            //       hint: "Select Project",
            //       controller: widget.projectCltr,
            //       title: "",
            //       suggestionsCallback: (v) {},
            //       onSelected: (v) {},
            //       suggestionText: "ProjectName"),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: InkWell(
            //     onTap: () {
            //       pickDate1(context, widget.dateCltr);
            //     },
            //     child: CustomTextFieldWOTitle(
            //         hintText: "Select Target Dt",
            //         controller: widget.dateCltr,
            //         obscureText: false,
            //         isEnabled: false,
            //         fillColor: Colors.white,
            //         hintColor: ColorConfig.primaryAppColor,
            //         title: ""),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: CustomTextFieldWOTitle(
            //       hintText: "How to Plan",
            //       controller: widget.planCltr,
            //       obscureText: false,
            //       fillColor: Colors.white,
            //       hintColor: ColorConfig.primaryAppColor,
            //       title: ""),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     Flexible(
            //       child: Container(
            //         padding: EdgeInsets.all(10),
            //         width: Get.width / 2,
            //         child: CustomLoginButton(
            //           iconData: Icons.attach_file,
            //           press: () {},
            //           bName: "Upload File",
            //         ),
            //       ),
            //     ),
            //     Flexible(
            //       child: Container(
            //         padding: EdgeInsets.all(10),
            //          width: Get.width / 2.5,
            //         child: CustomLoginButton(
            //           iconData: Icons.group,
            //           press: () {},
            //           bName: "Multiple User",
            //         ),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  errorLens() {
    if (widget.taskCltr.text.isEmpty) {
      CustomSnackbar.snackbarNormal(context, "Task is Empty");
    } else if (widget.pIdCltr.text.isEmpty) {
      CustomSnackbar.snackbarNormal(context, "Select Project");
    } else if (widget.dateCltr.text.isEmpty) {
      CustomSnackbar.snackbarNormal(context, "Select Date");
    } else if (widget.planCltr.text.isEmpty) {
      CustomSnackbar.snackbarNormal(context, "How Plan is Empty");
    } else {
      insertTaskAPI(
              givenToUserId: widget.selectedId.length < 1
                  ? widget.userId
                  : widget.selectedId.join(','),
              givenByuserID: PrefsConfig.getUserId(),
              task: widget.taskCltr.text,
              projectID: widget.pIdCltr.text,
              dt: currentDate(),
              targetDt: widget.dateCltr.text.isEmpty
                  ? currentDate()
                  : widget.dateCltr.text,
              howToPlan: widget.planCltr.text,
              deptId: "")
          .then(
        (value) => {
          if (value['status'] == "200")
            {
              Get.back(),
              setState(() {
                widget.dateCltr.clear();
                widget.pIdCltr.clear();
                widget.taskCltr.clear();
                widget.planCltr.clear();
                fileName = "";

                img1 = null;
              })
            }
          else
            {},
        },
      );
    }
  }
}

class MultipleUsers extends StatefulWidget {
  final List<String> selectedValues;
  final List<String> selectedId;
  final VoidCallback backButton;

  const MultipleUsers(
      {Key key, this.selectedValues, this.selectedId, this.backButton})
      : super(key: key);
  @override
  State<MultipleUsers> createState() => _MultipleUsersState();
}

class _MultipleUsersState extends State<MultipleUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
          lead: IconButton(
              onPressed: widget.backButton, icon: Icon(Icons.arrow_back_ios)),
          screenName: "Select Multiple Employee"),
      body: Container(
        child: FutureBuilder(
            future: EmployeeController.getMultipleUsers(
                context: context,
                priority: "1",
                taskGiven: "All",
                viewFor: "All",
                userId: PrefsConfig.getUserId()),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: Center(
                        child: snapshot.connectionState != ConnectionState.done
                            ? CircularProgressIndicator()
                            : Text("No Data Found!")));
              } else {
                return Container(
                    width: Get.width / 1.1,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (context, index) {
                          var list = snapshot.data.result[index];
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  if (widget.selectedValues
                                      .contains(list.empName)) {
                                    widget.selectedValues.remove(list.empName);
                                    widget.selectedId.remove(list.userId);
                                  } else {
                                    widget.selectedValues.add(list.empName);
                                    widget.selectedId.add(list.userId);
                                  }
                                });
                              },
                              child: usersUI(EmpModel(result: [list])));
                        }));
              }
            }),
      ),
      // Done Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(bottom: 20),
        child: CustomLoginButton(
          fcolor: Colors.white,
          press: () {
            // Handle the action when the "Done" button is pressed
          },
          bName: "Done",
        ),
      ),
    );
  }

  Widget usersUI(EmpModel model) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: CustomText(data: model.result[0].empName),
            trailing: Icon(
              widget.selectedValues.contains(model.result[0].empName)
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: widget.selectedValues.contains(model.result[0].empName)
                  ? ColorConfig.primaryAppColor
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
