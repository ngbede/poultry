import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/providers/price_prov.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../layout.dart';

class PriceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change product prices"),
          backgroundColor: Color(0XFF35D4C0),
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            InputField(
              name: "Crate of Egg unit price",
              keyboard: TextInputType.number,
              fieldType: FieldType.crateOfEggPrice,
              rightPadding: 200,
              maxlen: 4,
              fontSize: 17,
            ),
            InputField(
              name: "Chicken unit price",
              keyboard: TextInputType.number,
              fieldType: FieldType.chickenPrice,
              rightPadding: 200,
              maxlen: 4,
              fontSize: 17,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Text(
                prefs.getDouble("chickenUnitPrice") == null
                    ? "1 Chicken ~ ₦..."
                    : "1 Chicken ~ ₦${prefs.getDouble("chickenUnitPrice")}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Text(
                prefs.getDouble("crateOfEggUnitPrice") == null
                    ? "1 Crate of egg ~ ₦..."
                    : "1 Crate of egg ~ ₦${prefs.getDouble("crateOfEggUnitPrice")}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Consumer<PriceProv>(builder: (context, priceData, child) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    int changes = 0;
                    if (priceData.cratePrice > 0) {
                      setEggPrice(priceData.cratePrice);
                      changes += 1;
                    }
                    if (priceData.chickenPrice > 0) {
                      setChickenPrice(priceData.chickenPrice);
                      changes += 1;
                    }
                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: "Summary",
                      desc: changes == 0
                          ? "$changes changes made"
                          : (changes == 1) && (priceData.chickenPrice > 0)
                              ? "$changes change made\n1 Chicken ~ ₦${prefs.getDouble("chickenUnitPrice")}"
                              : (changes == 2)
                                  ? "$changes changes made\n1 Chicken ~ ₦${prefs.getDouble("chickenUnitPrice")}\n1 Crate of egg ~ ₦${prefs.getDouble("crateOfEggUnitPrice")}"
                                  : "$changes change made\n1 Crate of egg ~ ₦${prefs.getDouble("crateOfEggUnitPrice")}",
                      buttons: [
                        DialogButton(
                          color: Color(0XFF35D4C0),
                          child: Text(
                            "Proceed",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            changes = 0;
                            priceData.setChickenPrice(0);
                            priceData.setCrateOfEggPrice(0);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Layout(),
                              ),
                            );
                          },
                          width: 120,
                        ),
                      ],
                    ).show();
                  },
                  child: ActionButton(
                    childWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save prices",
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
