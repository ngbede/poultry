import 'package:flutter/material.dart';
import 'package:poultry/providers/farm_prov.dart';
import 'package:provider/provider.dart';

final List<String> _nigerianStates = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara",
  "FCT",
];

Column statePicker(BuildContext context) {
  List<DropdownMenuItem<String>> states = [];
  for (var state in _nigerianStates) {
    var option = DropdownMenuItem(
      child: Text(
        "  $state",
      ),
      value: state,
    );
    states.add(option);
  }

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "State",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            //textAlign: TextAlign.left,`
          ),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 5, bottom: 20, right: 20.0),
          child: Container(
            color: Color(0XFFEAE9EB),
            child: DropdownButton(
              items: states,
              value: Provider.of<FarmProv>(context).state,
              onChanged: (value) {
                Provider.of<FarmProv>(context, listen: false).setState(
                  value,
                );
              },
            ),
          ),
        ),
      ),
    ],
  );
}
