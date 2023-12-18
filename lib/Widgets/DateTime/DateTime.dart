import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String currentDate() {
  DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
  String currentDate = dateFormat.format(DateTime.now());
  return currentDate;
}

String convertDateFormat(
    String inputDate, String inputDateFormat, String outputDateFormat) {
  DateFormat inputParser = DateFormat(inputDateFormat);
  DateFormat outputParser = DateFormat(outputDateFormat);
  var date = inputParser.parse(inputDate);
  String outPutData = outputParser.format(date);
  return outPutData;
}

String dateMMMForm(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('dd-MMM-yyyy');
  return formatter.format(date);
}

Future<DateTime> pickDate(
    BuildContext context, TextEditingController controller) async {
  final DateTime currentDate = DateTime.now();

  final DateTime selectedDate = await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: DateTime(currentDate.year - 1),
    lastDate: DateTime(currentDate.year + 1),
  );

  return selectedDate;
}
