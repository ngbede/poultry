import 'package:flutter/material.dart';
import 'package:poultry/widgets/batch_card_fields.dart';

class BatchCard extends StatelessWidget {
  final String batchName;
  final String birdType;
  final int quantity;
  final String startDate;
  final String batchID;
  final Function function;
  BatchCard({
    @required this.batchName,
    @required this.birdType,
    @required this.quantity,
    @required this.startDate,
    @required this.batchID,
    @required this.function,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: function,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          color: Color(0XFFEFF4F5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0XFF35D4C0),
                width: double.infinity,
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              BatchCardFields(title: "Batch Name:", info: batchName),
              SizedBox(
                height: 5,
              ),
              BatchCardFields(title: "Bird Type:", info: birdType),
              SizedBox(
                height: 5,
              ),
              BatchCardFields(title: "Quantity:", info: "$quantity"),
              SizedBox(
                height: 5,
              ),
              BatchCardFields(title: "Start Date:", info: startDate),
              SizedBox(
                height: 5,
              ),
              BatchCardFields(title: "Batch ID:", info: batchID),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
