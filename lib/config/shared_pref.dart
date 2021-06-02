import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

void setEggPrice(double price) {
  prefs.setDouble("crateOfEggUnitPrice", price);
}

void setChickenPrice(double price) {
  prefs.setDouble("chickenUnitPrice", price);
}
