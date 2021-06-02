import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poultry/screens/account_ui/account_cards.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AccountCard(
          title: "Prices",
          hintText: "Adjust product prices",
          icon: FluentIcons.money_20_regular,
        ),
        AccountCard(
          title: "Settings",
          hintText: "Edit account deatils",
          icon: FluentIcons.settings_20_regular,
        ),
        AccountCard(
          title: "Customers",
          hintText: "Store customer information",
          icon: FluentIcons.person_add_20_regular,
        ),
        AccountCard(
          title: "Sign Out",
          hintText: "Log off from account",
          icon: FluentIcons.sign_out_20_regular,
        ),
      ],
    );
  }
}
