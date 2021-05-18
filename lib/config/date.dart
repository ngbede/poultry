import 'package:intl/intl.dart';

DateTime now = DateTime.now();
DateFormat formatter = DateFormat("dd/MM/y");
DateTime today = DateTime(now.year, now.month, now.day);
String todaysDate = formatter.format(today);

String formatDate() {
  String dateFormat = "";
  dateFormat += today.day.toString();
  dateFormat += "_0";
  dateFormat += today.month.toString();
  dateFormat += "_";
  dateFormat += today.year.toString();
  return dateFormat;
}

String customDateFormat(String day, String month, String year) {
  String dateFormat = day + " " + month + ", " + year;
  return dateFormat;
}
