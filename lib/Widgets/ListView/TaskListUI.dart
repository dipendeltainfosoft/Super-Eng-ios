import 'package:duke_kanban/Configuration/ImageConfig.dart';
import 'package:duke_kanban/Configuration/PrefsConfig.dart';
import 'package:duke_kanban/Controllers/Employee/EmployeeController.dart';
import 'package:duke_kanban/Controllers/TaskApproval/TaskController.dart';
import 'package:duke_kanban/Model/TaskModel.dart';
import 'package:duke_kanban/Widgets/Buttons/LoginButton.dart';
import 'package:duke_kanban/Widgets/DateTime/DateTime.dart';
import 'package:duke_kanban/Widgets/DialogBox/BottomSheet.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Configuration/ColorConfig.dart';
import '../DialogBox/DialogBox.dart';
import '../Dropdown/SearchDropdown.dart';

class TaskListUI extends StatefulWidget {
  final TaskModel model;
  final Function refresh;

  const TaskListUI({Key key, this.model, this.refresh}) : super(key: key);

  @override
  State<TaskListUI> createState() => _TaskListUIState();
}

class _TaskListUIState extends State<TaskListUI> {
  String dynamicIcon;
  bool isDynamicIcon = true;

  bool isCardExpand = false;
  bool showStatus = true;
  bool showStatus1 = false;

  String remarkValue = '';
  TextEditingController edtRemarks = TextEditingController();
  TextEditingController targetDtCltr = TextEditingController();
  TextEditingController statusCltr = TextEditingController();
  TextEditingController remarksCltr = TextEditingController();
  TextEditingController howCltr = TextEditingController();

  String sId = '';
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
              primary: ColorConfig.primaryAppColor, //! <-- SEE HERE
              onPrimary: Colors.white, //! <-- SEE HERE
              onSurface: ColorConfig.primaryAppColor, //! <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    ColorConfig.primaryAppColor, //! button text color
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
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isCardExpand = !isCardExpand;
                });
              },
              child: _cardUIShow(),
            ),
            //! _cardUIShow(),
            _expandedContainUI(),
          ],
        ),
      ),
    );
  }

  Widget _cardUIShow() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConfig.primaryAppColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              padding: EdgeInsets.all(8.0),
              child: CustomText(
                data: widget.model.result[0].no.toString(),
                fSize: 16,
                fColor: Colors.white,
                fWeight: FontWeight.bold,
                align: TextAlign.start,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Visibility(
                visible: isDynamicIcon,
                child: ImageConfig.fromAsset(
                    color: Colors.green,
                    fit: BoxFit.fill,
                    imagePath: greenDotIcon,
                    size: 15)),
            Spacer(),
            CustomText(
              data: convertDateFormat(widget.model.result[0].date.toString(),
                  "M/dd/yyyy hh:mm:ss a", "dd-MMM-yyyy"),
              fSize: 14,
              fColor: Colors.black,
              fWeight: FontWeight.w200,
              align: TextAlign.start,
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                CustomDialogBox.taskListMenuDialog(
                  context,
                  remarkHistory: () {
                    Get.back();
                    // Navigator.pop(context);
                  },
                  deleteTask: () {
                    // Navigator.pop(context);
                    TaskController.deleteTask(
                            context: context,
                            dId: widget.model.result[0].ddId,
                            userId: PrefsConfig.getUserId())
                        .whenComplete(() => {widget.refresh(), Get.back()});
                  },
                  editTask: () {
                    TaskController.getTaskDetail(
                            id: widget.model.result[0].ddId)
                        .then(
                      (value) => {
                        if (value.status == "200")
                          {
                            Get.toNamed('/taskEdit', arguments: [
                              widget.model.result[0].ddId,
                              value.result[0].projectName,
                              value.result[0].projectId,
                              value.result[0].mainPoint,
                              value.result[0].targetDt,
                              value.result[0].remarks,
                              value.result[0].givenTo,
                              value.result[0].pointGivenUserId,
                              value.result[0].statusName,
                              value.result[0].statusTextListId,
                              value.result[0].pDCA,
                              value.result[0].deptId,
                              value.result[0].howToPlan,
                            ])
                          }
                      },
                    );

                    // Get.back();

                    // Navigator.pop(context);
                  },
                  // id: widget.model.result[0].ddId,
                  id: widget.model.result[0].ddId,
                );
              },
              child: Transform.rotate(
                angle: 90 * 3.1415927 / 180,
                child: ImageConfig.fromAsset(
                    color: ColorConfig.primaryAppColor,
                    fit: BoxFit.fill,
                    imagePath: moreIcon,
                    size: 18),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            data: widget.model.result[0].project.toString(),
            fSize: 16,
            fColor: ColorConfig.primaryAppColor,
            fWeight: FontWeight.bold,
            align: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(
            data: widget.model.result[0].mainPoint,
            fSize: 16,
            fColor: Colors.black,
            fWeight: FontWeight.bold,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }

  void launchLink(url) async {
    if (!await launch(url)) ;
  }

  Widget _expandedContainUI() {
    return Visibility(
        visible: isCardExpand,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 0.5,
                    margin: EdgeInsets.only(top: 2),
                    color: ColorConfig.primaryAppColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        padding: EdgeInsets.all(2.0),
                        color: Color(0xFFF8F4F4),
                        child: CustomText(
                          data: "Given By",
                          fSize: 14,
                          fColor: Colors.black,
                          align: TextAlign.start,
                        ), // Replace with your color
                      ),
                      CustomText(
                        data: "-",
                        fSize: 16,
                        fColor: Colors.black,
                        fWeight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        padding: EdgeInsets.all(2.0),
                        child: CustomText(
                          data: widget.model.result[0].pointGivenByName,
                          fSize: 14,
                          fColor: ColorConfig.primaryAppColor,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      CustomDialogBox.howToPlan(
                        context,
                        how: howCltr,
                        text: 'Given By',
                        yes: () {
                          TaskController.updateHowtoPlan(
                              context: context,
                              how: howCltr.text,
                              ddid: widget.model.result[0].ddId,
                              userId: PrefsConfig.getUserId());
                          Get.back();
                          setState(() {
                            howCltr.clear();
                          });
                        },
                        iText: widget.model.result[0].no,
                      );
                    },
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              padding: EdgeInsets.all(2.0),
                              color: Color(0xFFF8F4F4),
                              child: CustomText(
                                // ! Not getting in Task List API
                                data: "How To Plan" + " - ",
                                // widget.model.result[0].mainPoint,

                                fSize: 14,
                                fColor: Colors.black,
                                align: TextAlign.start,
                              ), // Replace with your color
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                widget.model.result[0].mainPoint,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorConfig.primaryAppColor,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            CustomDialogBox.howToPlan(
                              context,
                              text: "How To Plan",
                              how: howCltr,
                              yes: () {
                                TaskController.updateHowtoPlan(
                                    context: context,
                                    type: "HowToPlan",
                                    how: howCltr.text,
                                    ddid: widget.model.result[0].ddId,
                                    userId: PrefsConfig.getUserId());
                                Get.back();
                                setState(() {
                                  howCltr.clear();
                                });
                              },
                              iText: widget.model.result[0].no,
                            );
                          },
                          child: Container(
                            width: 25,
                            margin: EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              color: ColorConfig.primaryAppColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        padding: EdgeInsets.all(2.0),
                        color: Color(0xFFF8F4F4),
                        child: CustomText(
                          data: "Task Generate On",
                          fSize: 14,
                          fColor: Colors.black,
                          align: TextAlign.start,
                        ), // Replace with your color
                      ),
                      CustomText(
                        data: "-",
                        fSize: 16,
                        fColor: Colors.black,
                        fWeight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        padding: EdgeInsets.all(2.0),
                        child: CustomText(
                          data: convertDateFormat(
                              widget.model.result[0].taskGeneratedDate
                                  .toString(),
                              "M/dd/yyyy hh:mm:ss a",
                              "dd-MMM-yyyy"),
                          fSize: 14,
                          fColor: ColorConfig.primaryAppColor,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        padding: EdgeInsets.all(2.0),
                        color: Color(0xFFF8F4F4),
                        child: CustomText(
                          data: "Target Date Revise Count",
                          fSize: 14,
                          fColor: Colors.black,
                          align: TextAlign.start,
                        ), // Replace with your color
                      ),
                      CustomText(
                        data: "-",
                        fSize: 16,
                        fColor: Colors.black,
                        fWeight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        padding: EdgeInsets.all(2.0),
                        child: CustomText(
                          data: widget.model.result[0].requisitionCount,
                          fSize: 14,
                          fColor: ColorConfig.primaryAppColor,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            padding: EdgeInsets.all(2.0),
                            color: Color(0xFFF8F4F4),
                            child: CustomText(
                              data: "Target Date",
                              fSize: 14,
                              fColor: Colors.black,
                              align: TextAlign.start,
                            ), // Replace with your color
                          ),
                          CustomText(
                            data: "-",
                            fSize: 16,
                            fColor: Colors.black,
                            fWeight: FontWeight.bold,
                            align: TextAlign.start,
                          ),
                          GestureDetector(
                            onTap: () {
                              CustomBottomSheet.updateTargetDate(context,
                                  controller: targetDtCltr,
                                  remarksCltr: remarksCltr, updateFunction: () {
                                TaskController.updateTargetDate(
                                        context: context,
                                        dId: widget.model.result[0].ddId,
                                        dt: targetDtCltr.text,
                                        remarks: remarksCltr.text,
                                        sId: widget
                                            .model.result[0].statusTextListId,
                                        userId: PrefsConfig.getUserId())
                                    .whenComplete(() => {
                                          if (mounted)
                                            setState(() {
                                              targetDtCltr.clear();
                                              remarksCltr.clear();
                                            }),
                                          Get.back()
                                        });
                              }, selectDateFunction: () {
                                pickDate(context, targetDtCltr);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0),
                              padding: EdgeInsets.all(2.0),
                              child: CustomText(
                                data: convertDateFormat(
                                    widget.model.result[0].targetDt.toString(),
                                    "M/dd/yyyy hh:mm:ss a",
                                    "dd-MMM-yyyy"),
                                fSize: 14,
                                fColor: ColorConfig.primaryAppColor,
                                align: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          CustomBottomSheet.updateTargetDate(context,
                              remarksCltr: remarksCltr,
                              controller: targetDtCltr, updateFunction: () {
                            TaskController.updateTargetDate(
                                    context: context,
                                    dId: widget.model.result[0].ddId,
                                    dt: targetDtCltr.text,
                                    remarks: remarksCltr.text,
                                    sId:
                                        widget.model.result[0].statusTextListId,
                                    userId: PrefsConfig.getUserId())
                                .whenComplete(() => {
                                      // if (mounted) widget.refresh(),
                                      if (mounted)
                                        setState(() {
                                          targetDtCltr.clear();
                                          remarksCltr.clear();
                                        }),
                                      Get.back()
                                    });
                          }, selectDateFunction: () {
                            pickDate(context, targetDtCltr);
                          });
                        },
                        child: Container(
                          width: 25,
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.date_range,
                            color: ColorConfig.primaryAppColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            padding: EdgeInsets.all(2.0),
                            color: Color(0xFFF8F4F4),
                            child: CustomText(
                              data: "Remarks",
                              fSize: 14,
                              fColor: Colors.black,
                              align: TextAlign.start,
                            ), // Replace with your color
                          ),
                          CustomText(
                            data: "-",
                            fSize: 16,
                            fColor: Colors.black,
                            fWeight: FontWeight.bold,
                            align: TextAlign.start,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            padding: EdgeInsets.all(2.0),
                            child: CustomText(
                              data: widget.model.result[0].remarks,
                              fSize: 14,
                              fColor: ColorConfig.primaryAppColor,
                              align: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                          width: 25,
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              CustomDialogBox.howToPlan(context,
                                  text: "Remarks", how: remarksCltr, yes: () {
                                TaskController.updateRemarks(
                                    context: context,
                                    type: "",
                                    remark: remarksCltr.text,
                                    ddid: widget.model.result[0].ddId,
                                    userId: PrefsConfig.getUserId());
                                Get.back();
                                setState(() {
                                  remarksCltr.clear();
                                });
                              }, iText: widget.model.result[0].no);
                            },
                            child: Icon(Icons.add,
                                color: ColorConfig.primaryAppColor),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      widget.model.result[0].approvedDisapproved == "D"
                          ? Container(
                              margin: EdgeInsets.only(right: 5.0),
                              padding: EdgeInsets.all(2.0),
                              color: Color(0xFFF8F4F4),
                              child: CustomText(
                                data: "Disapproved By",
                                fSize: 14,
                                fColor: Colors.black,
                                align: TextAlign.start,
                              ), // Replace with your color
                            )
                          : Container(
                              margin: EdgeInsets.only(right: 5.0),
                              padding: EdgeInsets.all(2.0),
                              color: Color(0xFFF8F4F4),
                              child: CustomText(
                                data: "Approved By",
                                fSize: 14,
                                fColor: Colors.black,
                                align: TextAlign.start,
                              ), // Replace with your color
                            ),
                      CustomText(
                        data: "-",
                        fSize: 16,
                        fColor: Colors.black,
                        fWeight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        padding: EdgeInsets.all(2.0),
                        child: CustomText(
                          data: widget.model.result[0].approvedBY,
                          fSize: 14,
                          fColor: ColorConfig.primaryAppColor,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    visible: showStatus,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.model.result[0].fileName != "")
                          InkWell(
                            onTap: () {
                              launchLink(widget.model.result[0].fileName
                                  .toString()
                                  .replaceAll(
                                      'E:/Publish/DeltaWRLite3.0/UploadedPhotos',
                                      'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/'));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: ColorConfig.primaryDarkAppColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Transform.rotate(
                                    angle: 45 * 3.1415927 / 180,
                                    child: Icon(
                                      Icons.attach_file,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                        if (widget.model.result[0].status != "Done")
                          GestureDetector(
                            onTap: () {
                              if (widget.model.result[0].approvedBY.isEmpty) {
                                setState(() {
                                  showStatus = false;
                                  showStatus1 = true;
                                });
                              }
                            },
                            child: Container(
                              //margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConfig.primaryDarkAppColor,
                                // Use your desired color
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Visibility(
                                visible: showStatus,
                                child: CustomText(
                                  data:
                                      widget.model.result[0].approvedBY.isEmpty
                                          ? widget.model.result[0].status +
                                              " - " +
                                              "Change Task Status ?"
                                          : widget.model.result[0].status,
                                  fSize: 12,
                                  fColor: Colors.white,
                                  fWeight: FontWeight.bold,
                                  align: TextAlign.start,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: showStatus1,
                    child: SearchDropdown(
                      isHide: false,
                      suggestionsCallback: (pattern) async {
                        return await EmployeeController.getStatusDropdown();
                      },
                      onSelected: (val) {
                        setState(() {
                          statusCltr.text = val['Text'];
                          sId = val['TextListId'];
                        });
                      },
                      title: "",
                      hint: "Select Status",
                      controller: statusCltr,
                      suggestionText: 'Text',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      visible: showStatus1,
                      child: CustomLoginButton(
                          press: () {
                            TaskController.updateStatus(
                                    context: context,
                                    dId: widget.model.result[0].ddId,
                                    sId: sId,
                                    userId: PrefsConfig.getUserId())
                                .whenComplete(() => {widget.refresh()});
                            setState(() {
                              showStatus = true;
                              showStatus1 = false;
                            });
                          },
                          bName: "Update"))
                ],
              ),
            ),
          ],
        ));
  }

  void showDisApproveAlertDialog(BuildContext context) async {
    await CustomDialogBox.alertDialogBoxRemarks(
      context,
      titleText: 'Update',
      msgText: 'Are you sure you want to disapprove this task ?',
      controllerTxt: edtRemarks,
      copyFunc: () {
        remarkValue = edtRemarks.text;
      },
    );
  }
}
