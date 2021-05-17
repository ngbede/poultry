import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/screens/layout.dart';
import 'package:poultry/providers/farm_prov.dart';
import 'package:poultry/widgets/inputfield.dart';
import 'package:poultry/widgets/state_picker.dart';
import 'package:poultry/config/firebase.dart';
import 'package:provider/provider.dart';

class FarmForm extends StatefulWidget {
  @override
  _FarmFormState createState() => _FarmFormState();
}

class _FarmFormState extends State<FarmForm> {
  final _farmFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(
            builder: (context) => Form(
              key: _farmFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                    child: Text(
                      "Setup your poultry farm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  InputField(
                    name: "Farm name",
                    keyboard: TextInputType.text,
                    fieldType: FieldType.farmName,
                  ),
                  InputField(
                    name: "Address",
                    keyboard: TextInputType.text,
                    fieldType: FieldType.address,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: InputField(
                            name: "LGA",
                            keyboard: TextInputType.text,
                            fieldType: FieldType.lga),
                      ),
                      Expanded(
                        flex: 2,
                        child: statePicker(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          name: "Number of Broilers",
                          maxlen: 5,
                          keyboard: TextInputType.number,
                          fieldType: FieldType.numberOfBroilers,
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          name: "Number of Layers",
                          maxlen: 5,
                          keyboard: TextInputType.number,
                          fieldType: FieldType.numberOfLayers,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      final _progress = ProgressHUD.of(context);
                      if (_farmFormKey.currentState.validate()) {
                        _progress.showWithText("Registering farm...");
                        try {
                          await Future.delayed(
                            Duration(seconds: 3),
                          ); // simulate progress
                          await store
                              .collection("farmers")
                              .doc(auth.currentUser.uid)
                              .set(
                            {
                              "ownerID": auth.currentUser.uid,
                              "farmName": Provider.of<FarmProv>(
                                context,
                                listen: false,
                              ).farmName,
                              "address": Provider.of<FarmProv>(
                                context,
                                listen: false,
                              ).address,
                              "LGA": Provider.of<FarmProv>(
                                context,
                                listen: false,
                              ).lga,
                              "State": Provider.of<FarmProv>(
                                context,
                                listen: false,
                              ).state,
                              "numberOfBroilers": int.parse(
                                Provider.of<FarmProv>(
                                  context,
                                  listen: false,
                                ).broilersCount,
                              ),
                              "numberOfLayers": int.parse(
                                Provider.of<FarmProv>(
                                  context,
                                  listen: false,
                                ).layersCount,
                              ),
                            },
                          );
                          _progress.dismiss();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Layout(),
                            ),
                          );
                        } catch (e) {
                          _progress.dismiss();
                          Fluttertoast.showToast(
                            msg: "${e.code}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.teal,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Card(
                        color: Colors.green[400],
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Create Farm",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
