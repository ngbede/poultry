import 'package:flutter/foundation.dart';
import 'package:poultry/models/order.dart';
import 'package:poultry/screens/stock_ui/chicken/chicken_count.dart';

class OrderProv with ChangeNotifier {
  Order _order = Order();

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
    _order.totalPrice = (_order.chickenUnitPrice * _order.chickenCount) +
        (_order.cratesOfEggs * _order.crateOfEggUnitPrice);
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
}
