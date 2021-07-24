import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/config/id_gen.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/providers/order_prov.dart';
import 'package:poultry/screens/account_ui/card_screens/price_screen.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/product_picker.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';

import '../../config/enumvals.dart';

class OrderForm extends StatelessWidget {
  final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF35D4C0),
          title: Text(
            "Create new order",
          ),
        ),
        body: Consumer<OrderProv>(
          builder: (context, orderData, child) {
            return Form(
              key: _orderFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 19, bottom: 10, top: 10),
                    child: Text(
                      "Customer details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InputField(
                    name: "Name",
                    keyboard: TextInputType.text,
                    fieldType: FieldType.customerName,
                  ),
                  InputField(
                    name: "Address",
                    keyboard: TextInputType.text,
                    fieldType: FieldType.customerAddress,
                  ),
                  InputField(
                    name: "Phone number",
                    keyboard: TextInputType.phone,
                    fieldType: FieldType.customerContact,
                    maxlen: 11,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      bottom: 10,
                      top: 5,
                    ),
                    child: Text(
                      "Crate of egg price ~ ₦${prefs.getDouble("crateOfEggUnitPrice")}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey,
                        //fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          "Price of chicken ~ ₦${prefs.getDouble("chickenUnitPrice")}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey,
                            //fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PriceScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Adjust prices",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                              wordSpacing: 2,
                              letterSpacing: 1,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Total Price = ₦ ${orderData.totalPrice}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (_orderFormKey.currentState.validate()) {
                          DocumentReference docRef = store
                              .collection("orders")
                              .doc(auth.currentUser.uid);
                          String orderID = generateID();
                          Map productData = {};
                          if (orderData.chickenCount > 0) {
                            productData["chickenQty"] = orderData.chickenCount;
                            productData["chickenUnitPrice"] =
                                prefs.getDouble("chickenUnitPrice");
                          }
                          //if ()
                          var data = {
                            orderID: {
                              "name": orderData.customeName,
                              "address": orderData.customerAddress,
                              "contact": orderData.customerContact,
                              "date": orderData.orderDate,
                              "open": true,
                              "orderID": orderID,
                              "products": {
                                "chickenQty": orderData.chickenCount,
                                "crateOfEggQty": orderData.cratesOfEggsCount,
                                "chickenUnitPrice":
                                    prefs.getDouble("chickenUnitPrice"),
                                "cratesOfEggUnitPrice":
                                    prefs.getDouble("crateOfEggUnitPrice"),
                                "totalPrice": orderData.totalPrice,
                                "cancelled": false,
                              }
                            }
                          };
                          await docRef.set(data);
                          print(data);
                        }
                      },
                      child: ActionButton(
                        childWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create order",
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
              ),
            );
          },
        ),
      ),
    );
  }
}
