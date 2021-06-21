import 'package:flutter/material.dart';
import 'package:poultry/screens/account_ui/account.dart';
import 'package:poultry/screens/analytics_ui/analytics.dart';
import 'package:poultry/screens/home_ui/home.dart';
import 'package:poultry/screens/order_ui/orders.dart';
import 'package:poultry/screens/stock_ui/stock.dart';
import 'package:provider/provider.dart';
import 'package:poultry/providers/layout_index.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> _screens = [
    Home(),
    Stock(),
    Orders(),
    //  Analytics(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: _screens.elementAt(
          Provider.of<LayoutIndexProv>(context).currentScreen,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 28,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp), //FluentIcons.home_20_regular),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: "Stock",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping_sharp),
              label: "Orders",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.bar_chart_sharp),
            //   label: "Analytics",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ],
          selectedItemColor: Color(0XFF35D4C0),
          onTap: Provider.of<LayoutIndexProv>(context, listen: false)
              .onTapChangeScreen,
          currentIndex: Provider.of<LayoutIndexProv>(context).currentScreen,
        ),
      ),
    );
  }
}
