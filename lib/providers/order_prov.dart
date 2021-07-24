import 'package:flutter/foundation.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/models/order.dart';

class OrderProv with ChangeNotifier {
  Order _order = Order();

  // ordering flow from distrbutor end
  void setFarmInfo(
    String name,
    Map data,
  ) {
    int cratePrice = data[name]["crateOfEggPrice"];
    int chickenPrice = data[name]["chickenPrice"];
    _order.farmOwner = data[name]["user"];
    _order.farmName = data[name]["farmName"];
    _order.farmContact = data[name]["contact"];
    _order.farmAddress = data[name]["address"];
    _order.lga = data[name]["LGA"];
    _order.crateOfEggUnitPrice = cratePrice.toDouble();
    _order.chickenUnitPrice = chickenPrice.toDouble();
    notifyListeners();
  }

  void pickFarm(String name) {
    _order.farmName = name;
    notifyListeners();
  }

  void setCustomerName(String name) {
    _order.customerName = name;
    notifyListeners();
  }

  void setCustomerID(String id) {
    _order.customerID = id;
    notifyListeners();
  }

  void setProductCount(int count) {
    _order.productCount = count;
    notifyListeners();
  }

  void setProducts(Map<String, Map<String, int>> products) {
    _order.products = products;
    notifyListeners();
  }

  void setOrderID(String id) {
    _order.orderID = id;
    notifyListeners();
  }

  void setOrderDate(String date) {
    _order.orderDate = date;
    notifyListeners();
  }

  void setCustomerContact(String phoneNum) {
    _order.contact = phoneNum;
    notifyListeners();
  }

  void setCustomerAddress(String address) {
    _order.customerAddress = address;
    notifyListeners();
  }

  void addCratesOfEggs() {
    _order.cratesOfEggs += 1;
    notifyListeners();
  }

  void subtractCratesOfEggs() {
    if (_order.cratesOfEggs > 0) {
      _order.cratesOfEggs -= 1;
      notifyListeners();
    }
  }

  void addChicken() {
    _order.chickenCount += 1;
    notifyListeners();
  }

  void subtractChicken() {
    if (_order.chickenCount > 0) {
      _order.chickenCount -= 1;
      notifyListeners();
    }
  }

  void calculateTotalPrice() {
    if (_order.chickenUnitPrice > 0 || _order.crateOfEggUnitPrice > 0) {
      _order.totalPrice = (_order.chickenUnitPrice * _order.chickenCount) +
          (_order.crateOfEggUnitPrice * _order.cratesOfEggs);
    } else {
      _order.totalPrice =
          (prefs.getDouble("chickenUnitPrice") * _order.chickenCount) +
              (prefs.getDouble("crateOfEggUnitPrice") * _order.cratesOfEggs);
    }
    notifyListeners();
  }

  String get orderID => _order.orderID;
  String get orderDate => _order.orderDate;
  String get customeName => _order.customerName;
  String get customerId => _order.customerID;
  String get customerAddress => _order.customerAddress;
  String get customerContact => _order.contact;
  int get productCount => _order.productCount;
  int get cratesOfEggsCount => _order.cratesOfEggs;
  int get chickenCount => _order.chickenCount;
  double get totalPrice => _order.totalPrice;
  Map<String, Map<String, int>> get products => _order.products;
  // get Farm Info
  String get farmOwner => _order.farmOwner;
  String get farmName => _order.farmName;
  String get farmAddress => _order.farmAddress;
  String get farmContact => _order.farmContact;
  String get farmLga => _order.lga;
  double get crateOfEggPrice => _order.crateOfEggUnitPrice;
  double get chickenPrice => _order.chickenUnitPrice;
}
