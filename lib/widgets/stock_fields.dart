import 'package:flutter/material.dart';

class StockFields extends StatelessWidget {
  final List<Widget> rowFields;
  StockFields({
    @required this.rowFields,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowFields,
      ),
    );
  }
}
