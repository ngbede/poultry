import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/screens/stock_ui/batch_card.dart';
import 'package:poultry/screens/stock_ui/modal_sheet.dart';

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
                Container(
                  width: 150,
                  child: Card(
                    shadowColor: Colors.red,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color(0XFF35D4C0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                FluentIcons.add_circle_20_regular,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return BatchSheet();
                                    },
                                  );
                                },
                                child: Text(
                                  "New batch",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream: store
                  .collection("stock_chickens")
                  .doc(auth.currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> chickenBatches = [];
                if (snapshot.hasData) {
                  print("check: ${snapshot.data.data() == null}");
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
                        chickenBatches.add(
                          BatchCard(
                            batchName: batchName,
                            birdType: birdType,
                            quantity: quantity,
                            startDate: startDate,
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
