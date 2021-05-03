import 'package:flutter/material.dart';
import 'package:poultry/account.dart';
import 'package:poultry/analytics.dart';
import 'package:poultry/home.dart';
import 'package:poultry/orders.dart';
import 'package:poultry/stock.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedScreen = 0;
  List<Widget> _screens = [
    Home(),
    Stock(),
    Orders(),
    Analytics(),
    Account(),
  ];

  void onTapChangeScreen(int index) {
    setState(
      () {
        _selectedScreen = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFC0F9E3),
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: _screens.elementAt(_selectedScreen),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_sharp),
              label: "Analytics",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ],
          selectedItemColor: Color(0XFF35D4C0),
          onTap: onTapChangeScreen,
          currentIndex: _selectedScreen,
        ),
      ),
    );
  }
}
