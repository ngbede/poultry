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
    return Column(
      children: <Widget>[
        StreamBuilder<DocumentSnapshot>(
          stream: store
              .collection("orders")
              .doc("1234") // auth.currentUser.uid
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
                  final int fertilizer = data["bagsOfFertilizer"];
                  final int chickens = data["chickens"];
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
    );
  }
}
