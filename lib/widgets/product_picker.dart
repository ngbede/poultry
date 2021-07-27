import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class PickProduct extends StatelessWidget {
  final String title;
  final Function additionFunction;
  final Function subtractionFunction;
  final int adjustedValue;
  PickProduct({
    @required this.title,
    @required this.additionFunction,
    @required this.subtractionFunction,
    @required this.adjustedValue,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              bottom: 10,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: subtractionFunction,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.red,
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      FluentIcons.subtract_16_regular,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                "$adjustedValue",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: additionFunction,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green,
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      FluentIcons.add_16_regular,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
