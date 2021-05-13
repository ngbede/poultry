import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/widgets/stock_card.dart';

class Stock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StockCard(
          name: "Chickens",
          itemCount: 2,
          reportCategory: StockReport.chickens,
        ),
        StockCard(
          name: "Eggs",
          itemCount: 1,
          reportCategory: StockReport.eggs,
        ),
        StockCard(
          name: "Feed/Fertilizer",
          itemCount: 2,
          reportCategory: StockReport.fertilizer,
        ),
      ],
    );
  }
}
