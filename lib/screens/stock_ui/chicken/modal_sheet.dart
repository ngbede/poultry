import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/constants.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/config/id_gen.dart';
import 'package:poultry/providers/birds_prov.dart';
import 'package:poultry/widgets/action_button.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/picker.dart';
import 'package:poultry/widgets/styles.dart';
import 'package:provider/provider.dart';

class BatchSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<BirdsProv>(
          builder: (context, birdData, child) {
            return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        customPicker(
                          context,
                          days,
                          Color(0XFFEAE9EB),
                          birdData.startDay,
                          (value) {
                            birdData.setDay(value);
                          },
                        ),
                        customPicker(
                          context,
                          months,
                          Color(0XFFEAE9EB),
                          birdData.startMonth,
                          (value) {
                            birdData.setMonth(value);
                          },
                        ),
                        customPicker(
                          context,
                          years,
                          Color(0XFFEAE9EB),
                          birdData.startYear,
                          (value) {
                            birdData.setYear(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Batch name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InputField(
                            keyboard: TextInputType.text,
                            fieldType: FieldType.batchName,
                            maxlen: 15,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bird type",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        customPicker(
                          context,
                          birdTypes,
                          Color(0XFFEAE9EB),
                          birdData.birdType,
                          (value) {
                            birdData.setBirdType(
                              value,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Quantity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InputField(
                            keyboard: TextInputType.number,
                            fieldType: FieldType.batchQuantity,
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
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            birdData.resetValues();
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
                            String id = generateID();
                            int batchCount =
                                Provider.of<BirdsProv>(context, listen: false)
                                    .batchCount;
                            DocumentReference documentReference = store
                                .collection('stock_chickens')
                                .doc(auth.currentUser.uid);
                            store.runTransaction(
                              (transaction) async {
                                DocumentSnapshot snapshot =
                                    await transaction.get(documentReference);
                                // check if user doc exist
                                if (snapshot.data() == null) {
                                  print("1");
                                  transaction.set(
                                    documentReference,
                                    {
                                      id: {
                                        "batchName": birdData.birdBatchName,
                                        "birdType": birdData.birdType,
                                        "quantity": birdData.batchQuantity,
                                        "startDate": customDateFormat(
                                          birdData.startDay,
                                          birdData.startMonth,
                                          birdData.startYear,
                                        ),
                                        "stock": {}
                                      }
                                    },
                                  );
                                } else {
                                  print("1");
                                  transaction.update(
                                    documentReference,
                                    {
                                      id: {
                                        "batchName": birdData.birdBatchName,
                                        "birdType": birdData.birdType,
                                        "quantity": birdData.batchQuantity,
                                        "startDate": customDateFormat(
                                          birdData.startDay,
                                          birdData.startMonth,
                                          birdData.startYear,
                                        ),
                                        "stock": {}
                                      }
                                    },
                                  );
                                }
                              },
                            ).whenComplete(
                              () {
                                Provider.of<BirdsProv>(context, listen: false)
                                    .setNumberOfbatches(
                                  batchCount + 1,
                                );
                                print("Batch Added");
                                birdData.resetValues();
                                Navigator.pop(
                                  context,
                                );
                              },
                            );
                          },
                          child: ActionButton(
                            childWidget: Text(
                              "Create Batch",
                              style: actionButtonStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
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
