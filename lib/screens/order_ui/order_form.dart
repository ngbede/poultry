import 'package:flutter/material.dart';
import 'package:poultry/providers/order_prov.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/product_picker.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';

import '../../config/enumvals.dart';

// TODO: show total price of product value dynamically
class OrderForm extends StatelessWidget {
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
        body: ListView(
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
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).addCratesOfEggs();
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).calculateTotalPrice();
              },
              subtractionFunction: () {
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).subtractCratesOfEggs();
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).calculateTotalPrice();
              },
              adjustedValue: Provider.of<OrderProv>(
                context,
              ).cratesOfEggsCount,
            ),
            SizedBox(
              height: 5,
            ),
            PickProduct(
              title: "Chickens",
              additionFunction: () {
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).addChicken();
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).calculateTotalPrice();
              },
              subtractionFunction: () {
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).subtractChicken();
                Provider.of<OrderProv>(
                  context,
                  listen: false,
                ).calculateTotalPrice();
              },
              adjustedValue: Provider.of<OrderProv>(
                context,
              ).chickenCount,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                bottom: 10,
                top: 5,
              ),
              child: Text(
                "Crate of egg price ~ ₦900",
                style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey,
                  //fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Price of chicken ~ ₦3500",
                style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey,
                  //fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Total Price = ₦ ${Provider.of<OrderProv>(context).totalPrice}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: GestureDetector(
                onTap: () {
                  print(Provider.of<OrderProv>(context, listen: false)
                      .customeName);
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
      ),
    );
  }
}
