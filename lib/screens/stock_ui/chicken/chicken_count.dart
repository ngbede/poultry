import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/providers/birds_prov.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/stock_fields.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';

class ChickenCount extends StatelessWidget {
  final String name;
  final String birdType;
  final int quantity;
  final String batchID;
  ChickenCount({
    @required this.name,
    @required this.birdType,
    @required this.quantity,
    @required this.batchID,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("$name stock count"),
          backgroundColor: Color(0XFF35D4C0),
        ),
        body: Consumer<BirdsProv>(
          builder: (context, birdData, child) {
            return ListView(
              children: [
                StockFields(
                  rowFields: [
                    Text(
                      "Date",
                      style: stockFieldTitleStyle,
                    ),
                    Text(
                      "$todaysDate",
                      style: stockFieldDateStyle,
                    ),
                  ],
                ),
                StockFields(
                  rowFields: [
                    Text(
                      "Total ${birdType.toLowerCase()}'s before count",
                      style: stockFieldTitleStyle,
                    ),
                    Text(
                      "${birdData.batchQuantity}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                StockFields(
                  rowFields: [
                    Text(
                      "$birdType's left after count",
                      style: stockFieldTitleStyle,
                    ),
                    Text(
                      "${birdData.aliveBirds}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                StockFields(
                  rowFields: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Dead $birdType's",
                        style: stockFieldTitleStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${birdData.deadBirds}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: InputField(
                        keyboard: TextInputType.number,
                        fieldType: FieldType.deadBirds,
                        rightPadding: 0,
                        leftPadding: 50,
                        bottomPadding: 0,
                        topPadding: 5,
                      ),
                    ),
                  ],
                ),
                StockFields(
                  rowFields: [
                    Expanded(
                      child: Text(
                        "Comment",
                        style: stockFieldTitleStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: InputField(
                        keyboard: TextInputType.text,
                        fieldType: FieldType.comment,
                        rightPadding: 0,
                        leftPadding: 50,
                        bottomPadding: 0,
                        topPadding: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            birdData.setDeadBirds(0);
                            birdData.setComment("");
                            Navigator.pop(context);
                          },
                          child: ActionButton(
                            childWidget: Text(
                              "Cancel",
                              style: actionButtonStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            DocumentSnapshot<Map> data = await store
                                .collection("stock_chickens")
                                .doc(auth.currentUser.uid)
                                .get();
                            Map stockMap = data.data()[batchID]["stock"];
                            String date = formatDate();
                            DocumentReference batchRef = store
                                .collection("stock_chickens")
                                .doc(auth.currentUser.uid);
                            print(data.data()[batchID]["stock"]);
                            // check if stock for day doesn't exist
                            if (!stockMap.containsKey(date)) {
                              stockMap[date] = {
                                "date": todaysDate,
                                "deadBirds": birdData.deadBirds,
                                "aliveBirds": birdData.aliveBirds,
                                "comment": birdData.comment,
                              };
                              print(stockMap);
                              await batchRef.update({
                                "$batchID.quantity": birdData.aliveBirds,
                                "$batchID.stock": stockMap,
                              }).whenComplete(() {
                                birdData.setDeadBirds(0);
                                birdData.setComment("");
                                Navigator.pop(context);
                              });
                            } else {
                              // if stock count for day exist, update count
                              int deadBirds = stockMap[date]["deadBirds"] +
                                  birdData.deadBirds;
                              int aliveBirds = stockMap[date]["aliveBirds"] -
                                  birdData.deadBirds;
                              await batchRef.update({
                                "$batchID.quantity": birdData.aliveBirds,
                                "$batchID.stock.$date.deadBirds": deadBirds,
                                "$batchID.stock.$date.comment":
                                    birdData.comment,
                                "$batchID.stock.$date.aliveBirds": aliveBirds,
                              }).whenComplete(() {
                                birdData.setDeadBirds(0);
                                birdData.setComment("");
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: ActionButton(
                            childWidget: Text(
                              "Submit Count",
                              style: actionButtonStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
