import 'package:poultry/config/enumvals.dart';

class Order {
  String orderID;
  String contact;
  String orderDate;
  String customerName;
  String customerID;
  String customerAddress;
  OrderStatus status;
  int productCount;
  Map<String, Map<String, int>> products;

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
  });
}
