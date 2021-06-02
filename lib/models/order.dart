import 'package:poultry/config/enumvals.dart';

class Order {
  String orderID;
  String contact;
  String orderDate;
  String customerName;
  String customerID;
  String customerAddress;
  OrderStatus status;
  Map<String, Map<String, int>> products;
  int productCount;
  int cratesOfEggs;
  int chickenCount;
  double crateOfEggUnitPrice;
  double chickenUnitPrice;
  double totalPrice;

  Order({
    this.orderID,
    this.contact,
    this.customerAddress,
    this.customerID,
    this.customerName,
    this.orderDate,
    this.productCount,
    this.products,
    this.status,
    this.cratesOfEggs = 0,
    this.chickenCount = 0,
    this.chickenUnitPrice = 3500,
    this.crateOfEggUnitPrice = 900,
    this.totalPrice = 0,
  });
}
