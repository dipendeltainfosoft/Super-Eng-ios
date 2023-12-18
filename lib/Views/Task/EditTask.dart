import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Configuration/PrefsConfig.dart';
import 'package:duke_kanban/Controllers/Employee/EmployeeController.dart';
import 'package:duke_kanban/Controllers/TaskApproval/TaskController.dart';
import 'package:duke_kanban/Widgets/Appbar/ImageAppbar.dart';
import 'package:duke_kanban/Widgets/Buttons/LoginButton.dart';
import 'package:duke_kanban/Widgets/Dropdown/SearchDropdown.dart';
import 'package:duke_kanban/Widgets/TextFields/TextFields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskEditScreen extends StatefulWidget {
  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  TextEditingController projectCltr = TextEditingController();
  TextEditingController mainPointCltr = TextEditingController();
  TextEditingController planCltr = TextEditingController();
  TextEditingController dateCltr = TextEditingController();
  TextEditingController reamrkCltr = TextEditingController();
  TextEditingController giveCltr = TextEditingController();
  TextEditingController statusCltr = TextEditingController();
  // SuggestionsBoxController _suggestionsBoxController =
  //     SuggestionsBoxController();

  String pId = "";
  String eId = "";
  String sId = "";

  var taskArg = Get.arguments;
  @override
  void initState() {
    super.initState();
    projectCltr.text = taskArg[1];
    mainPointCltr.text = taskArg[3];
    dateCltr.text = taskArg[4];
    reamrkCltr.text = taskArg[5];
    giveCltr.text = taskArg[6];
    statusCltr.text = taskArg[8];
    planCltr.text = taskArg[12];
  }

  Future<void> pickDate(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
        lead: lead(),
        screenName: "Task Edit",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchDropdown(
                suggestionsCallback: (pattern) async {
                  return await TaskController.getProjectsList();
                },
                onSelected: (val) {
                  setState(() {
                    projectCltr.text = val['ProjectName'];
                    pId = val['ProjectId'];
                  });
                },
                title: "Project",
                hint: "Select Project",
                controller: projectCltr,
                suggestionText: 'ProjectName',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              hintText: "",
              title: "Main Point",
              controller: mainPointCltr,
              obscureText: false,
              fillColor: ColorConfig.primaryLightAppColor,
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              hintText: "",
              title: "How to Plan",
              controller: planCltr,
              obscureText: false,
              fillColor: ColorConfig.primaryLightAppColor,
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                pickDate(context, dateCltr);
              },
              child: CustomTextField(
                hintText: "",
                title: "Target Date",
                controller: dateCltr,
                obscureText: false,
                isEnabled: false,
                fillColor: ColorConfig.primaryLightAppColor,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            CustomTextField(
              hintText: "",
              title: "Remarks",
              controller: reamrkCltr,
              obscureText: false,
              fillColor: ColorConfig.primaryLightAppColor,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchDropdown(
                suggestionsCallback: (pattern) async {
                  return await EmployeeController.getEmployeeListDropdown(
                      userId: PrefsConfig.getUserId());
                },
                onSelected: (val) {
                  setState(() {
                    giveCltr.text = val['EmpName'];
                    eId = val['DefaultProjectId'];
                  });
                },
                title: "Given to",
                hint: "Select Employee",
                controller: giveCltr,
                suggestionText: 'EmpName',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SearchDropdown(
                suggestionsCallback: (pattern) async {
                  return await EmployeeController.getStatusDropdown();
                },
                onSelected: (val) {
                  setState(() {
                    statusCltr.text = val['Text'];
                    sId = val['TextListId'];
                  });
                },
                title: "Status",
                hint: "Select Status",
                controller: statusCltr,
                suggestionText: 'Text',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomLoginButton(
                  press: () {
                    TaskController.updateTaskDetailAPI(
                            dDid: taskArg[0],
                            mainPoint: mainPointCltr.text,
                            howToPlan: planCltr.text,
                            deptId: taskArg[11],
                            projectTextListId: pId == "" ? taskArg[2] : pId,
                            statusTextListId: sId == "" ? taskArg[9] : sId,
                            pointGivenUserId: eId == "" ? taskArg[7] : eId,
                            remark: reamrkCltr.text,
                            context: context,
                            pDCA: "",
                            userId: PrefsConfig.getUserId())
                        .then(
                      (value) => {
                        if (value['status'] == "200") {Get.back()},
                      },
                    );
                  },
                  bName: "Update"),
            )
          ],
        ),
      ),
    );
  }
}
