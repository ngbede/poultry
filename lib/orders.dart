import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/tabview.dart';
import 'package:poultry/widgets/orders_card.dart';

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
                //icon: Icon(FluentIcons.open_20_filled),
              ),
              Tab(
                text: "CLOSED",
                // icon: Icon(FluentIcons.closed_caption_off_20_regular),
              ),
            ],
          ),
        ),
        // TODO: Stream all orders into the open and closed tab menu
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
