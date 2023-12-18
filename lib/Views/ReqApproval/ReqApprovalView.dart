import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:duke_kanban/Controllers/ReqApproval/ReqController.dart';
import 'package:duke_kanban/Widgets/DateTime/DateTime.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:flutter/material.dart';
import '../../Configuration/PrefsConfig.dart';
import '../../Widgets/Appbar/ImageAppbar.dart';
import '../../Widgets/DialogBox/DialogBox.dart';
import '../../Widgets/Messages/Snackbar.dart';

class ReqApprovalScreen extends StatefulWidget {
  const ReqApprovalScreen({Key key}) : super(key: key);

  @override
  _ReqApprovalScreenState createState() => _ReqApprovalScreenState();
}

class _ReqApprovalScreenState extends State<ReqApprovalScreen> {
  List<dynamic> _initialData = [];
  List<dynamic> _searchResults = [];

  String remarkValue = '';
  TextEditingController edtRemarks = TextEditingController();

  @override
  void initState() {
    getReqTaskApprovalListAPICall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedData =
        _searchResults.isNotEmpty ? _searchResults : _initialData;

    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
        screenName: "Request Approval",
        lead: lead(),
      ),
      body: _dataSetUI(displayedData),
    );
  }

  Widget _cardShow() {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: ColorConfig.dukeLightColor,
              child: Row(
                children: [
                  CustomText(
                    data: 'Task No :',
                    fSize: 16,
                    fColor: Colors.white,
                    fWeight: FontWeight.bold,
                    align: TextAlign.start,
                  ),
                  Expanded(
                    child: CustomText(
                      data: '1234',
                      fSize: 14,
                      fColor: Colors.white,
                      fWeight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Row(
                children: [
                  CustomText(
                    data: 'Project Name : ',
                    fSize: 14,
                    fColor: Colors.black,
                    fWeight: FontWeight.bold,
                    align: TextAlign.start,
                  ),
                  Expanded(
                    child: CustomText(
                      data: '1234',
                      fSize: 12,
                      fColor: ColorConfig.dukeLightColor,
                      fWeight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            CustomText(
              data: 'Main Point',
              fSize: 14,
              fColor: Colors.grey[700],
              fWeight: FontWeight.bold,
              align: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  CustomText(
                    data: 'Given To : ',
                    fSize: 14,
                    fColor: Colors.black,
                    fWeight: FontWeight.bold,
                    align: TextAlign.start,
                  ),
                  Expanded(
                    child: CustomText(
                      data: '1234',
                      fSize: 12,
                      fColor: ColorConfig.dukeLightColor,
                      fWeight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
              padding: EdgeInsets.all(8.0),
              color: Colors.grey[200],
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        data: 'Target Date : ',
                        fSize: 14,
                        fColor: Colors.black,
                        fWeight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      Expanded(
                        child: CustomText(
                          data: '1234',
                          fSize: 12,
                          fColor: ColorConfig.dukeLightColor,
                          fWeight: FontWeight.bold,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      CustomText(
                        data: 'Req Target Date : ',
                        fSize: 14,
                        fColor: Colors.black,
                        fWeight: FontWeight.bold,
                        align: TextAlign.start,
                      ),
                      Expanded(
                        child: CustomText(
                          data: '1234',
                          fSize: 12,
                          fColor: ColorConfig.dukeLightColor,
                          fWeight: FontWeight.bold,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Row(
                children: [
                  CustomText(
                    data: 'Remarks : ',
                    fSize: 14,
                    fColor: Colors.black,
                    fWeight: FontWeight.bold,
                    align: TextAlign.start,
                  ),
                  Expanded(
                    child: CustomText(
                      data: '1234',
                      fSize: 12,
                      fColor: ColorConfig.dukeLightColor,
                      fWeight: FontWeight.bold,
                      align: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    showDisApproveAlertDialog(context, _initialData, 0);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: ColorConfig.dukeLightColor,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: ColorConfig.dukeLightColor,
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
                SizedBox(width: 8.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataSetUI(List<dynamic> displayedData) {
    ScrollController scrollController = ScrollController();
    return displayedData.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('No Request For Approval'),
              ),
            ],
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 1.25,
            child: Scrollbar(
              interactive: true,
              radius: Radius.circular(50),
              showTrackOnHover: true,
              thumbVisibility: true,
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                itemCount: displayedData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        elevation: 4.0,
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                color: ColorConfig.dukeLightColor,
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: 'Task No :',
                                      fSize: 16,
                                      fColor: Colors.white,
                                      fWeight: FontWeight.bold,
                                      align: TextAlign.start,
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        data: displayedData[index]['No'],
                                        fSize: 14,
                                        fColor: Colors.white,
                                        fWeight: FontWeight.bold,
                                        align: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: 'Project Name : ',
                                      fSize: 14,
                                      fColor: Colors.black,
                                      fWeight: FontWeight.bold,
                                      align: TextAlign.start,
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        data: displayedData[index]
                                            ['ProjectName'],
                                        fSize: 12,
                                        fColor: ColorConfig.dukeLightColor,
                                        fWeight: FontWeight.bold,
                                        align: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    data: '  Task Description : ',
                                    fSize: 14,
                                    fColor: Colors.black,
                                    fWeight: FontWeight.bold,
                                    align: TextAlign.start,
                                  ),
                                  CustomText(
                                    data: displayedData[index]['MainPoint'],
                                    fSize: 14,
                                    fColor: ColorConfig.dukeLightColor,
                                    fWeight: FontWeight.bold,
                                    align: TextAlign.center,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: 'Given To : ',
                                      fSize: 14,
                                      fColor: Colors.black,
                                      fWeight: FontWeight.bold,
                                      align: TextAlign.start,
                                    ),
                                    Expanded(
                                      child: CustomText(
                                          data: displayedData[index]
                                              ['PointGivenFirstLast'],
                                          fSize: 12,
                                          fColor: ColorConfig.dukeLightColor,
                                          fWeight: FontWeight.bold,
                                          align: TextAlign.start),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
                                padding: EdgeInsets.all(8.0),
                                color: Colors.grey[200],
                                child: Column(
                                  children: [
                                    Row(children: [
                                      CustomText(
                                        data: 'Target Date : ',
                                        fSize: 14,
                                        fColor: Colors.black,
                                        fWeight: FontWeight.bold,
                                        align: TextAlign.start,
                                      ),
                                      Expanded(
                                          child: CustomText(
                                        data: convertDateFormat(
                                            displayedData[index]['TargetDt'],
                                            'MM/dd/yyyy hh:mm:ss a',
                                            'dd-MMM-yyyy'),
                                        fSize: 12,
                                        fColor: ColorConfig.dukeLightColor,
                                        fWeight: FontWeight.bold,
                                        align: TextAlign.start,
                                      ))
                                    ]),
                                    SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        CustomText(
                                          data: 'Req Target Date : ',
                                          fSize: 14,
                                          fColor: Colors.black,
                                          fWeight: FontWeight.bold,
                                          align: TextAlign.start,
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            data: convertDateFormat(
                                                displayedData[index]
                                                    ['NewTargetDate'],
                                                'MM/dd/yyyy hh:mm:ss a',
                                                'dd-MMM-yyyy'),
                                            fSize: 12,
                                            fColor: ColorConfig.dukeLightColor,
                                            fWeight: FontWeight.bold,
                                            align: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: 'Remarks : ',
                                      fSize: 14,
                                      fColor: Colors.black,
                                      fWeight: FontWeight.bold,
                                      align: TextAlign.start,
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        data: displayedData[index]['Remarks'],
                                        fSize: 12,
                                        fColor: ColorConfig.dukeLightColor,
                                        fWeight: FontWeight.bold,
                                        align: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
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
                                        color: ColorConfig.dukeLightColor,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
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
                                      showApproveAlertDialog(
                                          context, displayedData, index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: ColorConfig.dukeLightColor,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
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
                                  SizedBox(width: 8.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ));
  }

  void showApproveAlertDialog(
      BuildContext context, List<dynamic> displayedData, int index) async {
    await CustomDialogBox.alertDialogBox(
      context,
      titleText: 'Update',
      msgText: 'Are you sure you want to approve this requsition task ?',
      copyFunc: () {
        // Perform some action when "Ok" is pressed
        updateReqTaskApprovalAPICall(displayedData[index]['DDId'], 'A', '',
            displayedData[index]['TargetDateRequisitionId']);
      },
    );
  }

  void showDisApproveAlertDialog(
      BuildContext context, List<dynamic> displayedData, int index) async {
    await CustomDialogBox.alertDialogBoxRemarks(
      context,
      titleText: 'Update',
      msgText: 'Are you sure you want to disapprove this requsition task ?',
      controllerTxt: edtRemarks,
      copyFunc: () {
        remarkValue = edtRemarks.text;
        updateReqTaskApprovalAPICall(
          displayedData[index]['DDId'],
          'D',
          remarkValue,
          displayedData[index]['TargetDateRequisitionId'],
        );
      },
    );
  }

  void getReqTaskApprovalListAPICall() {
    try {
      _initialData = [];

      ReqController.getReqApprovalList(
        userId: PrefsConfig.getUserId() ?? "",
        context: context,
      ).then((value) => {
            if (value['status'] == "200")
              {
                setState(() {
                  //! Map<String, dynamic> map = json.decode(response.body);
                  List<dynamic> jsonData = value["result"];
                  setState(() {
                    _initialData = jsonData;
                  });
                  print(value['message']);
                  CustomSnackbar.snackbarNormal(context, value['message']);
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

  void updateReqTaskApprovalAPICall(
      String id, String status, String remarks, String targetId) {
    try {
      ReqController.getUpdateReqTaskApprovalList(
              userId: PrefsConfig.getUserId(),
              dDid: id,
              adStatus: status,
              remarks: remarks,
              targetDateRequisitionId: targetId,
              context: context)
          .then((value) => {
                if (value['status'] == "200")
                  {
                    setState(() {
                      remarkValue = '';
                      edtRemarks.text = '';

                      Navigator.pop(context);
                      CustomSnackbar.snackbarNormal(context, value['message']);
                      getReqTaskApprovalListAPICall();
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
}
