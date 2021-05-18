import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/widgets/toast.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/stock_fields.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';
import 'package:poultry/providers/egg_prov.dart';
import 'package:poultry/config/firebase.dart';

class EggReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0XFF35D4C0),
          title: Text("Egg stock count"),
        ),
        body: Consumer<EggProv>(
          builder: (context, eggData, child) {
            return Column(
              children: [
                StockFields(
                  rowFields: [
                    Text(
                      "Collection Date",
                      style: stockFieldTitleStyle,
                    ),
                    Text(
                      "${eggData.collectionDate}",
                      style: TextStyle(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                StockFields(
                  rowFields: [
                    Expanded(
                      child: Text(
                        "Eggs Collected",
                        style: stockFieldTitleStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${eggData.totalEggs}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InputField(
                        keyboard: TextInputType.number,
                        fieldType: FieldType.eggsCollected,
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
                        "Good Eggs",
                        style: stockFieldTitleStyle,
                      ),
                    ),
                    Text(
                      "${eggData.totalGoodEggs}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                StockFields(
                  rowFields: [
                    Expanded(
                      child: Text(
                        "Bad Eggs",
                        style: stockFieldTitleStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${eggData.totalBadEggs}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InputField(
                        keyboard: TextInputType.number,
                        fieldType: FieldType.badEggs,
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
                            eggData.resetValues();
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
                            DocumentReference documentReference = store
                                .collection('stock_eggs')
                                .doc(auth.currentUser.uid);
                            store.runTransaction((transaction) async {
                              DocumentSnapshot snapshot =
                                  await transaction.get(documentReference);
                              // check if user doc exist
                              if (snapshot.data() == null) {
                                await store
                                    .collection('stock_eggs')
                                    .doc(auth.currentUser.uid)
                                    .set(
                                  {
                                    formatDate(): {
                                      "eggsCollected": eggData.totalEggs,
                                      "badEggs": eggData.totalBadEggs,
                                      "goodEggs": eggData.totalGoodEggs,
                                      "date": eggData.collectionDate,
                                    }
                                  },
                                );
                              } else {
                                if (!snapshot
                                    .data()
                                    .containsKey(formatDate())) {
                                  await store
                                      .collection('stock_eggs')
                                      .doc(auth.currentUser.uid)
                                      .update(
                                    {
                                      formatDate(): {
                                        "eggsCollected": eggData.totalEggs,
                                        "badEggs": eggData.totalBadEggs,
                                        "goodEggs": eggData.totalGoodEggs,
                                        "date": eggData.collectionDate,
                                      }
                                    },
                                  );
                                } else {
                                  int newTotalEggsCollected =
                                      snapshot.data()[formatDate()]
                                              ["eggsCollected"] +
                                          eggData.totalEggs;
                                  int newTotalGoodEggs = snapshot
                                          .data()[formatDate()]["goodEggs"] +
                                      eggData.totalGoodEggs;
                                  int newTotalBadEggs =
                                      snapshot.data()[formatDate()]["badEggs"] +
                                          eggData.totalBadEggs;
                                  transaction.update(documentReference, {
                                    "${formatDate()}.eggsCollected":
                                        newTotalEggsCollected,
                                    "${formatDate()}.badEggs": newTotalBadEggs,
                                    "${formatDate()}.goodEggs":
                                        newTotalGoodEggs,
                                    "${formatDate()}.date":
                                        eggData.collectionDate,
                                  });
                                }
                              }
                            }).whenComplete(() async {
                              toaster("Stock count recorded");
                              await Future.delayed(
                                Duration(seconds: 1),
                              );
                              eggData.resetValues();
                              eggData.setPercent(1.0);
                              Navigator.pop(context);
                            });
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