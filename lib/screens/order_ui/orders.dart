import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/screens/order_ui/tabview.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0XFF35D4C0),
          bottom: TabBar(
            indicatorColor: Color(0XFF0D2C54),
            indicatorWeight: 3,
            tabs: [
              Tab(
                text: "OPEN",
              ),
              Tab(
                text: "CLOSED",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderTabView(
              orderStatus: OrderStatus.open,
            ),
            OrderTabView(
              orderStatus: OrderStatus.closed,
            ),
          ],
        ),
      ),
    );
  }
}
