import 'package:flutter/foundation.dart';
import 'package:poultry/models/prices.dart';

class PriceProv with ChangeNotifier {
  final Prices _prices = Prices();

  void setCrateOfEggPrice(double value) {
    _prices.crateOfEggUnitPrice = value;
  }

  void setChickenPrice(double value) {
    _prices.chickenUnitPrice = value;
  }

  double get cratePrice => _prices.crateOfEggUnitPrice;
  double get chickenPrice => _prices.chickenUnitPrice;
}
