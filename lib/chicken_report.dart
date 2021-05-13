import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/constants.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/providers/birds_prov.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/picker.dart';
import 'package:provider/provider.dart';

class ChickenReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          actions: [],
          backgroundColor: Color(0XFF35D4C0),
          title: Text("Chicken Report"),
        ),
        body: ListView(
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
                                      return Container(
                                        height: 500,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListView(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Start date",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    customPicker(
                                                      context,
                                                      days,
                                                      Provider.of<BirdsProv>(
                                                              context)
                                                          .startDay,
                                                      (value) {
                                                        Provider.of<BirdsProv>(
                                                          context,
                                                          listen: false,
                                                        ).setDay(value);
                                                      },
                                                    ),
                                                    customPicker(
                                                      context,
                                                      months,
                                                      Provider.of<BirdsProv>(
                                                              context)
                                                          .startMonth,
                                                      (value) {
                                                        Provider.of<BirdsProv>(
                                                          context,
                                                          listen: false,
                                                        ).setMonth(value);
                                                      },
                                                    ),
                                                    customPicker(
                                                      context,
                                                      years,
                                                      Provider.of<BirdsProv>(
                                                              context)
                                                          .startYear,
                                                      (value) {
                                                        Provider.of<BirdsProv>(
                                                          context,
                                                          listen: false,
                                                        ).setYear(value);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Batch name",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: InputField(
                                                        keyboard:
                                                            TextInputType.text,
                                                        fieldType:
                                                            FieldType.batchName,
                                                        maxlen: 20,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Bird type",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    customPicker(
                                                      context,
                                                      birdTypes,
                                                      Provider.of<BirdsProv>(
                                                              context)
                                                          .birdType,
                                                      (value) {
                                                        Provider.of<BirdsProv>(
                                                                context,
                                                                listen: false)
                                                            .setBirdType(
                                                          value,
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Quantity",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: InputField(
                                                        keyboard: TextInputType
                                                            .number,
                                                        fieldType: FieldType
                                                            .batchQuantity,
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
                                                        Provider.of<BirdsProv>(
                                                                context,
                                                                listen: false)
                                                            .resetValues();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 200,
                                                        child: Card(
                                                          elevation: 5,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          color:
                                                              Color(0XFF35D4C0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 7.0,
                                                            ),
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 17,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: 200,
                                                      child: Card(
                                                        elevation: 5,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        color:
                                                            Color(0XFF35D4C0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 7.0,
                                                          ),
                                                          child: Text(
                                                            "Create Batch",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
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
          ],
        ),
      ),
    );
  }
}
