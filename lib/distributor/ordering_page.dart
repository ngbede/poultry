import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/config/id_gen.dart';
import 'package:poultry/providers/order_prov.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/picker.dart';
import 'package:poultry/widgets/product_picker.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:poultry/widgets/toast.dart';
import 'package:provider/provider.dart';

class OrderingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF35D4C0),
          title: Text(
            "Book Order",
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  SizedBox(height: 10),
              Text(
                "Select farm",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: store.collection("farmers").snapshots(),
                builder: (context, snapshot) {
                  Map<String, Map> allFarmInfo = {};
                  List<String> farmNames = [];
                  if (snapshot.hasData) {
                    for (var farmData in snapshot.data.docs) {
                      Map data = farmData.data();
                      // print(data);
                      allFarmInfo[data["farmName"]] = data;
                      farmNames.add(data["farmName"]);
                    }
                    print(allFarmInfo);
                  }
                  return Consumer<OrderProv>(
                    builder: (context, orderData, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customPicker(
                            context,
                            farmNames,
                            Color(0XFFEAE9EB),
                            orderData.farmName,
                            (value) {
                              orderData.setFarmInfo(value, allFarmInfo);
                            },
                          ),
                          SizedBox(height: 10),
                          Divider(thickness: 1),
                          Text(
                            "Farm Details",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Farm owner: ${orderData.farmOwner}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Address: ${orderData.farmAddress}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Contact: ${orderData.farmContact}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Local government: ${orderData.farmLga}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Chicken Unit Price: ₦${orderData.chickenPrice}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Crate of Egg Unit Price: ₦${orderData.crateOfEggPrice}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Divider(thickness: 1),
                          //  SizedBox(height: 10),
                          Text(
                            "Products",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          PickProduct(
                            title: "Crates of eggs",
                            additionFunction: () {
                              orderData.addCratesOfEggs();
                              orderData.calculateTotalPrice();
                            },
                            subtractionFunction: () {
                              orderData.subtractCratesOfEggs();
                              orderData.calculateTotalPrice();
                            },
                            adjustedValue: orderData.cratesOfEggsCount,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          PickProduct(
                            title: "Chickens",
                            additionFunction: () {
                              orderData.addChicken();
                              orderData.calculateTotalPrice();
                            },
                            subtractionFunction: () {
                              orderData.subtractChicken();
                              orderData.calculateTotalPrice();
                            },
                            adjustedValue: orderData.chickenCount,
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                          ),
                          Text(
                            "Price summary",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Total Price = ₦${orderData.totalPrice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () async {
                                if (orderData.totalPrice == 0) {
                                  toaster("Pick at least one product",
                                      ToastGravity.CENTER);
                                } else {
                                  Map products = {};
                                  if (orderData.cratesOfEggsCount > 0) {
                                    products["crateOfEggQty"] =
                                        orderData.cratesOfEggsCount;
                                    products["crateOfEggUnitPrice"] =
                                        orderData.crateOfEggPrice;
                                  }
                                  if (orderData.chickenCount > 0) {
                                    products["chickenQty"] =
                                        orderData.chickenCount;
                                    products["chickenUnitPrice"] =
                                        orderData.chickenPrice;
                                  }
                                  products["totalPrice"] = orderData.totalPrice;
                                  String farmID =
                                      allFarmInfo[orderData.farmName]["userId"];
                                  print("ID: $farmID");
                                  DocumentReference docRef =
                                      store.collection("orders").doc(farmID);
                                  DocumentReference userDocRef = store
                                      .collection("users")
                                      .doc(auth.currentUser.uid);
                                  DocumentSnapshot userData =
                                      await userDocRef.get();
                                  DocumentSnapshot snapshot =
                                      await docRef.get();
                                  Map distributorInfo = userData.data();
                                  Map data = snapshot.data();
                                  print(data);
                                  String name = distributorInfo["name"];
                                  String address = distributorInfo["address"];
                                  String contact =
                                      distributorInfo["phoneNumber"];
                                  String orderID = generateID();
                                  if (data == null) {
                                    docRef.set(
                                      {
                                        orderID: {
                                          "customerID": auth.currentUser.uid,
                                          "products": products,
                                          "open": true,
                                          "date": todaysDate,
                                          "orderID": orderID,
                                          "name": name,
                                          "contact": contact,
                                          "productCount":
                                              products.length == 5 ? 2 : 1,
                                          "address": address,
                                          "cancelled": false,
                                        },
                                      },
                                    ).whenComplete(() {
                                      toaster("Order request sent",
                                          ToastGravity.BOTTOM);
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    docRef.update(
                                      {
                                        orderID: {
                                          "customerID": auth.currentUser.uid,
                                          "products": products,
                                          "open": true,
                                          "date": todaysDate,
                                          "orderID": orderID,
                                          "name": name,
                                          "contact": contact,
                                          "productCount":
                                              products.length == 5 ? 2 : 1,
                                          "address": address,
                                          "cancelled": false,
                                        },
                                      },
                                    ).whenComplete(() {
                                      toaster("Order request sent",
                                          ToastGravity.BOTTOM);
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              },
                              child: ActionButton(
                                childWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Book order",
                                      style: actionButtonStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
