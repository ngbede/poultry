import 'package:flutter/material.dart';
import 'package:poultry/distributor/account_screen.dart';
import 'package:poultry/distributor/order_view.dart';

class DistributorHome extends StatefulWidget {
  @override
  _DistributorHomeState createState() => _DistributorHomeState();
}

class _DistributorHomeState extends State<DistributorHome> {
  List<Widget> _screens = [
    OrderView(),
    AccountScreen(),
  ];

  int _index = 0;

  void changeScreen(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens.elementAt(_index),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 28,
          selectedItemColor: Color(0XFF35D4C0),
          onTap: changeScreen,
          currentIndex: _index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping_sharp),
              label: "Order",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}
