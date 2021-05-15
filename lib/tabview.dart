import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';

import 'config/firebase.dart';
import 'widgets/orders_card.dart';

class OrderTabView extends StatelessWidget {
  final OrderStatus orderStatus;
  OrderTabView({@required this.orderStatus});
  @override
  Widget build(BuildContext context) {
    return auth.currentUser != null
        ? Column(
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                stream: store
                    .collection("orders")
                    .doc(auth.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<OrderCard> farmOrders = [];
                  if (snapshot.hasData) {
                    final orderList = snapshot.data.data().values;
                    for (var data in orderList) {
                      if (orderStatus == OrderStatus.open
                          ? data["open"]
                          : !data["open"]) {
                        final bool open = data["open"];
                        final String name = data["name"];
                        final String address = data["address"];
                        final String contact = data["contact"];
                        final String id = data["ID"];
                        final String status = open ? "PENDING" : "DELIVERED";
                        final String date = data["date"];
                        // ignore: unused_local_variable
                        final int fertilizer = data["bagsOfFertilizer"];
                        // ignore: unused_local_variable
                        final int chickens = data["chickens"];
                        // ignore: unused_local_variable
                        final int eggCrates = data["cratesOfEggs"];
                        final int productCount = data["products"];
                        farmOrders.add(
                          OrderCard(
                            status: status,
                            name: name,
                            productCount: productCount,
                            contact: contact,
                            address: address,
                            date: date,
                            id: id,
                          ),
                        );
                      }
                    }
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
