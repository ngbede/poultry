import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/widgets/toast.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/stock_fields.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';
import 'package:poultry/providers/egg_prov.dart';
import 'package:poultry/config/firebase.dart';

// TODO: sort egg stock count by month of collection
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
                      "Date",
                      style: stockFieldTitleStyle,
                    ),
                    Text(
                      "${eggData.collectionDate}",
                      style: stockFieldDateStyle,
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
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InputField(
                        keyboard: TextInputType.number,
                        fieldType: FieldType.eggsCollected,
                        name: "eggs collected",
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
                        fontSize: 18,
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
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InputField(
                        keyboard: TextInputType.number,
                        fieldType: FieldType.badEggs,
                        name: "bad eggs",
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
                              DocumentSnapshot<Map> snapshot =
                                  await transaction.get(documentReference);
                              // check if user doc exist
                              if (snapshot.data() == null) {
                                transaction.set(
                                  documentReference,
                                  {
                                    formatDate(): {
                                      "eggsCollected": eggData.totalEggs,
                                      "badEggs": eggData.totalBadEggs,
                                      "goodEggs": eggData.totalGoodEggs,
                                      "date": eggData.collectionDate,
                                    }
                                  },
                                );
                                prefs.setInt(
                                  "eggsCollected",
                                  eggData.totalEggs,
                                );
                              }
                              // check if stock count has been done for the day
                              else if (!snapshot
                                  .data()
                                  .containsKey(formatDate())) {
                                transaction.update(
                                  documentReference,
                                  {
                                    formatDate(): {
                                      "eggsCollected": eggData.totalEggs,
                                      "badEggs": eggData.totalBadEggs,
                                      "goodEggs": eggData.totalGoodEggs,
                                      "date": eggData.collectionDate,
                                    }
                                  },
                                );
                                prefs.setInt(
                                  "eggsCollected",
                                  eggData.totalEggs,
                                );
                              }
                              // check if stock count for the day is done, then update values
                              else {
                                int newTotalEggsCollected = snapshot
                                        .data()[formatDate()]["eggsCollected"] +
                                    eggData.totalEggs;
                                int newTotalGoodEggs =
                                    snapshot.data()[formatDate()]["goodEggs"] +
                                        eggData.totalGoodEggs;
                                int newTotalBadEggs =
                                    snapshot.data()[formatDate()]["badEggs"] +
                                        eggData.totalBadEggs;
                                transaction.update(documentReference, {
                                  "${formatDate()}.eggsCollected":
                                      newTotalEggsCollected,
                                  "${formatDate()}.badEggs": newTotalBadEggs,
                                  "${formatDate()}.goodEggs": newTotalGoodEggs,
                                  "${formatDate()}.date":
                                      eggData.collectionDate,
                                });
                                prefs.setInt(
                                  "eggsCollected",
                                  newTotalEggsCollected,
                                );
                              }
                            }).whenComplete(() async {
                              toaster(
                                  "Stock count recorded", ToastGravity.BOTTOM);
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
