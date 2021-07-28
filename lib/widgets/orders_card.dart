import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:poultry/widgets/toast.dart';

class OrderCard extends StatelessWidget {
  final String status;
  final String name; // of distributore
  final int productCount;
  final String contact;
  final String address;
  final String date;
  final String id;
  final bool cancelled;
  final int crateOfEggQty;
  final int chickenQty;
  final double chickenUnitPrice;
  final double crateOfEggUnitPrice;
  final double totalPrice;
  final UserType userRole;
  OrderCard({
    @required this.status,
    @required this.name,
    @required this.productCount,
    @required this.contact,
    @required this.address,
    @required this.date,
    @required this.id,
    @required this.cancelled,
    @required this.userRole,
    this.crateOfEggQty,
    this.chickenQty,
    this.chickenUnitPrice,
    this.crateOfEggUnitPrice,
    this.totalPrice,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("hello");
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "ORDER SUMMARY",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Products",
                            style: orderHeader,
                          ),
                          Text(
                            "Quantity",
                            style: orderHeader,
                          ),
                          Text(
                            "Unit Price (₦)",
                            style: orderHeader,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.black,
                    ),
                    chickenQty != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Chicken",
                                    style: orderSummaryField,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "$chickenQty",
                                    style: orderSummaryField,
                                  ),
                                ),
                                Text(
                                  "$chickenUnitPrice",
                                  style: orderSummaryField,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(height: 0),
                    crateOfEggQty != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Crates of Egg",
                                    style: orderSummaryField,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "$crateOfEggQty",
                                    style: orderSummaryField,
                                  ),
                                ),
                                Text(
                                  "$crateOfEggUnitPrice",
                                  style: orderSummaryField,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(height: 0),
                    Divider(
                      thickness: 0.7,
                      color: Colors.black,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        child: Text(
                          "Total Price = ₦$totalPrice",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    status == "PENDING" && userRole == UserType.farmer
                        ? Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await store
                                        .collection("orders")
                                        .doc(auth.currentUser.uid)
                                        .update({
                                      "$id.cancelled": true,
                                      "$id.open": false,
                                    }).whenComplete(() {
                                      toaster("Order Cancelled",
                                          ToastGravity.BOTTOM);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: ActionButton(
                                    color: Colors.red,
                                    childWidget: Text(
                                      "Cancel Order",
                                      style: actionButtonStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await store
                                        .collection("orders")
                                        .doc(auth.currentUser.uid)
                                        .update({
                                      "$id.open": false,
                                    }).whenComplete(() {
                                      toaster("Order Confirmed",
                                          ToastGravity.BOTTOM);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: ActionButton(
                                    childWidget: Text(
                                      "Confirm Order",
                                      style: actionButtonStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ActionButton(
                              childWidget: Text(
                                "Close",
                                style: actionButtonStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 150,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: 20,
                  color: cancelled
                      ? Colors.red
                      : status == "PENDING"
                          ? Colors.amber
                          : Color(0XFF35D4C0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      cancelled ? "CANCELLED" : status.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "From $name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Products: $productCount"),
                        Text("Contact: $contact"),
                        Text("Address: $address "),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 2,
                      bottom: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$date"),
                        Text("ID: $id")
                        //  Text("Benue")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
