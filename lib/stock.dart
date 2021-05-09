import 'package:flutter/material.dart';
import 'package:poultry/widgets/stock_card.dart';

class Stock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StockCard(
          name: "Chickens",
          itemCount: 2,
        ),
        StockCard(
          name: "Eggs",
          itemCount: 3,
        ),
        StockCard(
          name: "Fertilizer",
          itemCount: 1,
        ),
        // StockCard(
        //   name: "Fertilizer",
        //   itemCount: 1,
        // )
      ],
    );
  }
}
