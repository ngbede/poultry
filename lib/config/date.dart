import 'package:intl/intl.dart';

DateTime now = DateTime.now();
DateFormat formatter = DateFormat("dd/MM/y");
DateTime today = DateTime(now.year, now.month, now.day);
String todaysDate = formatter.format(today);
