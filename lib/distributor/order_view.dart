import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/distributor/ordering_page.dart';
import 'package:poultry/screens/order_ui/tabview.dart';
import 'package:poultry/widgets/add_button.dart';
import 'package:poultry/widgets/orders_card.dart';

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF35D4C0),
        automaticallyImplyLeading: false,
        title: Text("Welcome, ${prefs.getString("name")}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: AddButton(
                title: "Book Order",
                function: () {
                  Navigator.push(
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
          StreamBuilder<QuerySnapshot<Map>>(
              stream: store.collection("orders").snapshots(),
              builder: (context, snapshot) {
                List<Widget> distributorOrders = [];
                if (snapshot.hasData) {
                  for (var data in snapshot.data.docs) {
                    Map orderData = data.data();
                    List keys = orderData.keys.toList();
                    for (String key in keys) {
                      Map order = orderData[key];
                      if (order["customerID"] == auth.currentUser.uid) {
                        final bool open = order["open"];
                        final String name = order["name"];
                        final String address = order["address"];
                        final String contact = order["contact"];
                        final String id = order["orderID"];
                        final String status = open ? "PENDING" : "DELIVERED";
                        final String date = order["date"];
                        final Map products = order["products"];
                        final int productCount = order["productCount"];
                        final bool cancelled = order["cancelled"];
                        distributorOrders.add(
                          OrderCard(
                            userRole: UserType.distributor,
                            status: status,
                            name: name,
                            productCount: productCount,
                            contact: contact,
                            address: address,
                            date: date,
                            id: id,
                            cancelled: cancelled,
                            totalPrice: products["totalPrice"],
                            crateOfEggQty: products["crateOfEggQty"],
                            crateOfEggUnitPrice:
                                products["CrateOfEggUnitPrice"],
                            chickenQty: products["chickenQty"],
                            chickenUnitPrice: products["chickenUnitPrice"],
                          ),
                        );
                      }
                    }
                  }
                  if (distributorOrders.isEmpty) {
                    distributorOrders.add(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Text(
                            "You haven't booked any order",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Expanded(
                  child: ListView(
                    children: distributorOrders,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
