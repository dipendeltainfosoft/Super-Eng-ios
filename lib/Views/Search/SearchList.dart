import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Controllers/Department/DepartmentController.dart';
import 'package:duke_kanban/Controllers/Employee/EmployeeController.dart';
import 'package:duke_kanban/Model/DeptModel.dart';
import 'package:duke_kanban/Model/EmpModel.dart';
import 'package:duke_kanban/Widgets/TextFields/TextFields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Configuration/ImageConfig.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Widgets/ListView/ListUI.dart';
import '../../Widgets/Others/CustomTexts.dart';

class SearchUI extends StatefulWidget {
  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  TextEditingController findCltr = TextEditingController();
  List<EmpModel> itemList = [];
  List<DepartmentModel> deptList = [];
  String _searchText = '';
  @override
  void initState() {
    // EmployeeController.getEmployeeListSearch(
    //         context: context,
    //         priority: "1",
    //         taskGiven: "All",
    //         viewFor: "Company",
    //         userId: PrefsConfig.getUserId())
    //     .then((value) => {
    //           if (value.status == "200")
    //             {
    //               setState(() {
    //                 itemList = value.result[];
    //               }),
    //             }
    //           else
    //             {print(value.status)}
    //         });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConfig.primaryAppColor,
        title: CustomTextFieldWOTitle(
            onChange: (v) {
              setState(() {
                _searchText = v;
              });
            },
            hintText: "Search",
            hintColor: ColorConfig.primaryAppColor,
            controller: findCltr,
            context: context,
            fillColor: Colors.white,
            suffix: IconButton(
              onPressed: () {
                findCltr.clear();
                setState(() {
                  _searchText = "";
                });
              },
              icon: Icon(
                Icons.close,
                color: ColorConfig.primaryAppColor,
              ),
            ),
            obscureText: false,
            title: ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height / 22,
              color: ColorConfig.stripColor,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      data: "Employee",
                      fWeight: FontWeight.bold,
                      fColor: Colors.black,
                      fSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<EmpModel>(
                    future: EmployeeController.getEmployeeListSearch(
                        context: context,
                        priority: "1",
                        taskGiven: "All",
                        viewFor: "Company",
                        userId: PrefsConfig.getUserId()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('No data found!'));
                      } else if (snapshot.data == null ||
                          snapshot.data.result.isEmpty) {
                        return Center(child: Text('No data found'));
                      } else {
                        itemList = snapshot.data.result
                            .map((e) => EmpModel(result: [e]))
                            .toList();
                        return Container(
                          width: Get.width / 1.1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemList.length,
                            itemBuilder: (context, index) {
                              final companyName = itemList[index]
                                  .result[0]
                                  .empName
                                  .toLowerCase();
                              if (companyName
                                  .contains(_searchText.toLowerCase())) {
                                return SearchListUI(model: itemList[index]);
                              } else {
                                return SizedBox.shrink(); // T
                              }
                            },
                          ),
                        );
                      }
                    })),
            Container(
              width: Get.width,
              height: Get.height / 22,
              color: ColorConfig.stripColor,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      data: "Department",
                      fWeight: FontWeight.bold,
                      fColor: Colors.black,
                      fSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<DepartmentModel>(
                    future: DepartmentController.getDepartmentListByEmpAPI(
                        pri: "1",
                        taskGiven: "All",
                        viewFor: "Company",
                        userId: PrefsConfig.getUserId()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('No data found!'));
                      } else if (snapshot.data == null ||
                          snapshot.data.result.isEmpty) {
                        return Center(child: Text('No data found'));
                      } else {
                        deptList = snapshot.data.result
                            .map((e) => DepartmentModel(result: [e]))
                            .toList();
                        return Container(
                          width: Get.width / 1.1,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: deptList.length,
                            itemBuilder: (context, index) {
                              final companyName = deptList[index]
                                  .result[0]
                                  .deptName
                                  .toLowerCase();
                              if (companyName
                                  .contains(_searchText.toLowerCase())) {
                                return DeptListUI(model: deptList[index]);
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }
}

class SearchListUI extends StatefulWidget {
  final EmpModel model;

  const SearchListUI({
    this.model,
  });

  @override
  State<SearchListUI> createState() => _SearchListUIState();
}

class _SearchListUIState extends State<SearchListUI> {
  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.toNamed('/taskList', arguments: widget.model.result[0].userId);
          },
          leading: CircleAvatar(
            backgroundColor: ColorConfig.dukeLightColor,
            backgroundImage: NetworkImage(widget.model.result[0].photoLink != ""
                ? widget.model.result[0].photoLink.toString().replaceAll(
                    'E:/Publish/DeltaWRLite3.0/UploadedPhotos/',
                    'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/')
                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
            radius: 20,
          ),
          title: CustomText(
            data: widget.model.result[0].empName +
                "            " +
                widget.model.result[0].empStatus,
            fColor: Colors.black,
            fWeight: FontWeight.w700,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallCustomContainer(
                status: "P",
                counts: widget.model.result[0].pendingCnt,
                secColor: ColorConfig.listBlue,
              ),
              SizedBox(
                width: 15,
              ),
              Visibility(
                // visible: widget.isPriority,
                child: SmallCustomContainer(
                  secColor: ColorConfig.listOrange,
                  status: "W",
                  counts: widget.model.result[0].workingCnt,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SmallCustomContainer(
                status: "D",
                counts: widget.model.result[0].doneCnt,
                secColor: ColorConfig.listGreen,
              ),
              SizedBox(
                width: 15,
              ),
              // SmallCustomContainer(
              //   status: "",
              //   trailIcon: ImageConfig.fromAsset(
              //       imagePath: teamIcon, color: ColorConfig.primaryAppColor),
              //   // counts: widget.model.result[0].empcount,
              //   secColor: Colors.white,
              //   border: Border.all(color: ColorConfig.dukeLightColor, width: 0),
              //   countColor: ColorConfig.primaryDarkAppColor,
              // ),
            ],
          ),
        ),
        Divider(
          height: 10,
          indent: 40,
          endIndent: 10,
          thickness: 2,
        ),

        // isExpanded
        //     ? Padding(
        //         padding: EdgeInsets.only(left: 12.0),
        //         child: EmpListUI(),
        //       )
        //     : Text("")
      ],
    );
  }
}

class DeptListUI extends StatefulWidget {
  final DepartmentModel model;

  const DeptListUI({
    this.model,
  });

  @override
  State<DeptListUI> createState() => _DeptListUIState();
}

class _DeptListUIState extends State<DeptListUI> {
  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        ListTile(
          onTap: toggleExpansion,
          leading: CircleAvatar(
            backgroundColor: ColorConfig.dukeLightColor,
            backgroundImage: NetworkImage(widget.model.result[0].photolink != ""
                ? widget.model.result[0].photolink.toString().replaceAll(
                    'E:/Publish/DeltaWRLite3.0/UploadedPhotos/',
                    'http://192.168.5.22:808/DeltaWRLite3.0/UploadedPhotos/')
                : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
            radius: 20,
          ),
          title: CustomText(
            data: widget.model.result[0].deptName,
            fColor: Colors.black,
            fWeight: FontWeight.w700,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallCustomContainer(
                status: "P",
                counts: widget.model.result[0].pendingCnt,
                secColor: ColorConfig.listBlue,
              ),
              SizedBox(
                width: 15,
              ),
              Visibility(
                // visible: widget.isPriority,
                child: SmallCustomContainer(
                  secColor: ColorConfig.listOrange,
                  status: "W",
                  counts: widget.model.result[0].workingCnt,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SmallCustomContainer(
                status: "D",
                counts: widget.model.result[0].doneCnt,
                secColor: ColorConfig.listGreen,
              ),
              SizedBox(
                width: 15,
              ),
              SmallCustomContainer(
                status: "",
                trailIcon: ImageConfig.fromAsset(
                    imagePath: teamIcon,
                    color: ColorConfig.primaryAppColor,
                    size: 14),
                counts: widget.model.result[0].empcount,
                secColor: Colors.white,
                border: Border.all(color: ColorConfig.dukeLightColor, width: 0),
                countColor: ColorConfig.primaryDarkAppColor,
              ),
            ],
          ),
        ),
        Divider(
          height: 10,
          indent: 40,
          endIndent: 10,
          thickness: 2,
        ),

        // isExpanded
        //     ? Padding(
        //         padding: EdgeInsets.only(left: 12.0),
        //         child: EmpListUI(),
        //       )
        //     : Text("")
      ],
    );
  }
}
