import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/distributor/ordering_page.dart';
import 'package:poultry/screens/order_ui/order_form.dart';
import 'package:poultry/widgets/add_button.dart';

import '../../config/firebase.dart';
import '../../widgets/orders_card.dart';

class OrderTabView extends StatelessWidget {
  final OrderStatus orderStatus;
  final String buttonText;
  final UserType user;
  OrderTabView({
    @required this.orderStatus,
    @required this.user,
    this.buttonText = "Add order",
  });
  @override
  Widget build(BuildContext context) {
    return auth.currentUser != null
        ? Column(
            children: <Widget>[
              orderStatus == OrderStatus.closed
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: AddButton(
                          title: "$buttonText",
                          function: () {
                            user == UserType.farmer
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderForm(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderingPage(),
                                    ),
                                  );
                            print("Navigate to order form field");
                          },
                        ),
                      ),
                    ),
              StreamBuilder<DocumentSnapshot<Map>>(
                stream: store
                    .collection("orders")
                    .doc(auth.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Widget> farmOrders = [];
                  if (snapshot.hasData) {
                    // print("ME: ${snapshot.data.data()}");
                    if (snapshot.data.data() == null ||
                        snapshot.data.data().isEmpty) {
                      farmOrders.add(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Text(
                              OrderStatus.open == orderStatus
                                  ? "You have no open orders..."
                                  : "You have no closed orders...",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                      prefs.setInt("openOrders", 0);
                    } else {
                      final orderList = snapshot.data.data().values;
                      int openOrders = 0;
                      for (var data in orderList) {
                        print(data);
                        if (orderStatus == OrderStatus.open
                            ? data["open"]
                            : !data["open"]) {
                          openOrders += 1;
                          final bool open = data["open"];
                          final String name = data["name"];
                          final String address = data["address"];
                          final String contact = data["contact"];
                          final String id = data["orderID"];
                          final String status = open ? "PENDING" : "DELIVERED";
                          final String date = data["date"];
                          final Map products = data["products"];
                          final int productCount = data["productCount"];
                          final bool cancelled = data["cancelled"];
                          print(products);
                          farmOrders.add(
                            OrderCard(
                              status: status,
                              name: name,
                              productCount: productCount,
                              contact: contact,
                              address: address,
                              date: date,
                              id: id,
                              totalPrice: products["totalPrice"],
                              crateOfEggQty: products["crateOfEggQty"],
                              crateOfEggUnitPrice:
                                  products["crateOfEggUnitPrice"],
                              chickenQty: products["chickenQty"],
                              chickenUnitPrice: products["chickenUnitPrice"],
                              cancelled: cancelled,
                            ),
                          );
                        }
                      }
                      prefs.setInt("openOrders", openOrders);
                    }
                  } else {
                    return CircularProgressIndicator(
                      color: Color(0XFF35D4C0),
                    );
                  }
                  return Expanded(
                    child: ListView(
                      children: farmOrders,
                    ),
                  );
                },
              ),
            ],
          )
        : Center(
            child: Text(
              "No data to show at this time...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          );
  }
}
