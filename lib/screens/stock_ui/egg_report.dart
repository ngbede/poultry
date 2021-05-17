import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/widgets/inputfield.dart';
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Collection Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "${Provider.of<EggProv>(context).collectionDate}",
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Eggs Collected",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${Provider.of<EggProv>(context).totalEggs}",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Good Eggs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "${Provider.of<EggProv>(context).totalGoodEggs}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Bad Eggs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${Provider.of<EggProv>(context).totalBadEggs}",
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
                        Provider.of<EggProv>(context, listen: false)
                            .resetValues();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 200,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Color(0XFF35D4C0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7.0,
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        String dateFormat = "";
                        dateFormat += today.day.toString();
                        dateFormat += "_0";
                        dateFormat += today.month.toString();
                        dateFormat += "_";
                        dateFormat += today.year.toString();
                        print(dateFormat);
                        DocumentReference documentReference = store
                            .collection('stock_eggs')
                            .doc(auth.currentUser.uid);
                        store.runTransaction((transaction) async {
                          DocumentSnapshot snapshot =
                              await transaction.get(documentReference);
                          if (!snapshot.data().containsKey(dateFormat)) {
                            await store
                                .collection('stock_eggs')
                                .doc(auth.currentUser.uid)
                                .update(
                              {
                                dateFormat: {
                                  "eggsCollected": Provider.of<EggProv>(context,
                                          listen: false)
                                      .totalEggs,
                                  "badEggs": Provider.of<EggProv>(context,
                                          listen: false)
                                      .totalBadEggs,
                                  "goodEggs": Provider.of<EggProv>(context,
                                          listen: false)
                                      .totalGoodEggs,
                                }
                              },
                            );
                            Fluttertoast.showToast(
                              msg: "Stock count recorded",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0XFF35D4C0),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            await Future.delayed(
                              Duration(seconds: 1),
                            );
                            Provider.of<EggProv>(context, listen: false)
                                .resetValues();
                            Provider.of<EggProv>(context, listen: false)
                                .setPercent(1.0);
                            Navigator.pop(context);
                          } else {
                            int newTotalEggsCollected =
                                snapshot.data()[dateFormat]["eggsCollected"] +
                                    Provider.of<EggProv>(context, listen: false)
                                        .totalEggs;
                            int newTotalGoodEggs = snapshot.data()[dateFormat]
                                    ["goodEggs"] +
                                Provider.of<EggProv>(context, listen: false)
                                    .totalGoodEggs;
                            int newTotalBadEggs = snapshot.data()[dateFormat]
                                    ["badEggs"] +
                                Provider.of<EggProv>(context, listen: false)
                                    .totalBadEggs;
                            transaction.update(documentReference, {
                              "$dateFormat.eggsCollected":
                                  newTotalEggsCollected,
                              "$dateFormat.badEggs": newTotalBadEggs,
                              "$dateFormat.goodEggs": newTotalGoodEggs
                            });
                            Fluttertoast.showToast(
                              msg: "Stock count recorded",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0XFF35D4C0),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            await Future.delayed(
                              Duration(seconds: 1),
                            );
                            Provider.of<EggProv>(context, listen: false)
                                .resetValues();
                            Provider.of<EggProv>(context, listen: false)
                                .setPercent(1.0);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Container(
                        width: 200,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Color(0XFF35D4C0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7.0,
                            ),
                            child: Text(
                              "Submit Count",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
