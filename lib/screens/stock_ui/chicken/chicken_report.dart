import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/screens/stock_ui/chicken/batch_card.dart';
import 'package:poultry/screens/stock_ui/chicken/modal_sheet.dart';
import 'package:poultry/widgets/add_button.dart';

import 'chicken_count.dart';

class ChickenReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Color(0XFF35D4C0),
          title: Text("Chicken Report"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "All Batches",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AddButton(
                  title: "New batch",
                  function: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BatchSheet();
                      },
                    );
                  },
                ),
              ],
            ),
            StreamBuilder<DocumentSnapshot<Map>>(
              stream: store
                  .collection("stock_chickens")
                  .doc(auth.currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> chickenBatches = [];
                if (snapshot.hasData) {
                  if (snapshot.data.data() == null) {
                    chickenBatches.add(
                      Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Text(
                            "Tap on \"New batch\" to add new batch of chickens...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Map data = snapshot.data.data();
                    if (data.isNotEmpty) {
                      final batchList = snapshot.data.data().values;
                      for (var batch in batchList) {
                        final String batchName = batch["batchName"];
                        final String birdType = batch["birdType"];
                        final int quantity = batch["quantity"];
                        final String startDate = batch["startDate"];
                        print(batchName);
                        chickenBatches.add(
                          BatchCard(
                            batchName: batchName,
                            birdType: birdType,
                            quantity: quantity,
                            startDate: startDate,
                            function: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChickenCount(
                                    name: batchName,
                                    birdType: birdType,
                                    quantity: quantity,
                                    startDate: startDate,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      chickenBatches.add(
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Text(
                              "Tap on \"New batch\" to add new batch of chickens...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }
                return Expanded(
                  child: ListView(
                    children: chickenBatches,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}