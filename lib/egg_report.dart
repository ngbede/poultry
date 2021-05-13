import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/models/eggs.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:provider/provider.dart';
import 'package:poultry/providers/egg_prov.dart';

class EggReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF35D4C0),
          title: Text("Eggs Collected"),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
