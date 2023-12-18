import 'package:duke_kanban/Controllers/TaskApproval/TaskController.dart';
import 'package:duke_kanban/Model/RemarkModel.dart';
import 'package:duke_kanban/Widgets/Appbar/ImageAppbar.dart';
import 'package:duke_kanban/Widgets/DateTime/DateTime.dart';
import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemarksListUI extends StatefulWidget {
  @override
  State<RemarksListUI> createState() => _RemarksListUIState();
}

class _RemarksListUIState extends State<RemarksListUI> {
  var id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.materialAppbar(
          lead: lead(), screenName: "Remarks History List"),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: TaskController.getRemarksHistory(id: id),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: Center(
                        child: snapshot.connectionState != ConnectionState.done
                            ? CircularProgressIndicator()
                            : Text("NO Data Found!")));
              } else {
                return Container(
                  width: Get.width / 1.1,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.result.length,
                      itemBuilder: (context, index) {
                        var list = snapshot.data.result[index];
                        return RemarkUI(
                          model: RemarkModel(result: [list]),
                        );
                      }),
                );
              }
            }),
      ),
    );
  }
}

class RemarkUI extends StatelessWidget {
  final RemarkModel model;

  const RemarkUI({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: ListTile(
              
          horizontalTitleGap: 0,
          title: CustomText(
            data: convertDateFormat(model.result[0].startDate,
                "M/dd/yyyy hh:mm:ss a", "dd-MMM-yyyy"),
            fColor: Colors.black,
            fWeight: FontWeight.bold,
          ),
          subtitle: CustomText(
            data: model.result[0].description,
            fColor: Colors.black,
            fWeight: FontWeight.bold,
          ),
        )),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
