import 'package:duke_kanban/Controllers/Notification/NotificationController.dart';

import 'package:duke_kanban/Widgets/Messages/Snackbar.dart';
import 'package:flutter/material.dart';

import '../../Configuration/PrefsConfig.dart';
import '../../Widgets/Appbar/ImageAppbar.dart';
import '../../Widgets/DateTime/DateTime.dart';
import '../../Widgets/Others/CustomTexts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> _initialData = [];
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    getNotificationAPICall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> displayedData = _initialData;

    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
        screenName: "Notifications",
        lead: lead(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //_cardShow(),
            _dataSetUI(displayedData)
          ],
        ),
      ),
    );
  }

  Widget _cardShow() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                data:
                    "#34. Given by : Ankit Bhansali, Target Date : 18-Jul-2023, Task : 33015082-02 new RM to be procured. Material damaged on cnc6.",
                fSize: 16,
                fColor: Colors.black,
                fWeight: FontWeight.w500,
                align: TextAlign.start,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                data: convertDateFormat("7/18/2023 11:15:13 AM",
                    "MM/dd/yyyy hh:mm:ss a", "dd-MMM-yyyy hh:mm:ss a"),
                fSize: 12,
                fColor: Colors.black,
                fWeight: FontWeight.normal,
                align: TextAlign.start,
              ),
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget _dataSetUI(List<dynamic> displayedData) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: displayedData.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomText(
                      data: displayedData[index]['msg'],
                      fSize: 16,
                      fColor: Colors.black,
                      fWeight: FontWeight.w700,
                      align: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        data: convertDateFormat(
                            displayedData[index]['InsertedOn'],
                            "MM/dd/yyyy hh:mm:ss a",
                            "dd-MMM-yyyy hh:mm:ss a"),
                        fSize: 12,
                        fColor: Colors.black,
                        fWeight: FontWeight.normal,
                        align: TextAlign.start,
                      ),
                    ),
                  ),
                  Divider(thickness: 1),
                ],
              ),
            );
          },
        ));
  }

  void getNotificationAPICall() {
    try {
      _initialData = [];

      NotificationController.getNotification(
              context: context,
              userId: PrefsConfig.getUserId() ??
                  "b017ccfe-4dad-42ca-9b66-5c91315e8ef6")
          .then((value) => {
                if (value['status'] == "200")
                  {
                    setState(() {
                      //Map<String, dynamic> map = json.decode(response.body);
                      List<dynamic> jsonData = value["result"];
                      setState(() {
                        _initialData = jsonData;
                        /*for (int i = 0; i < _initialData.length; i++) {
                          if(_initialData[i]['Status'] == 'Pending'){

                          }else if(_initialData[i]['Status'] == 'Working'){

                          }else if(_initialData[i]['Status'] == 'Done'){

                          }
                        }*/
                      });
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
