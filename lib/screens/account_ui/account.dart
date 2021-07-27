import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/screens/account_ui/account_cards.dart';
import 'package:poultry/screens/account_ui/card_screens/price_screen.dart';
import 'package:poultry/screens/onboarding_ui/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          function: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PriceScreen(),
            ),
          ),
        ),
        AccountCard(
          title: "Settings",
          hintText: "Edit account details",
          icon: FluentIcons.settings_20_regular,
        ),
        // AccountCard(
        //   title: "Customers",
        //   hintText: "Store customer information",
        //   icon: FluentIcons.person_add_20_regular,
        // ),
        AccountCard(
          title: "Sign Out",
          hintText: "Log off from your account",
          icon: FluentIcons.sign_out_20_regular,
          function: () {
            Alert(
              context: context,
              type: AlertType.none,
              title: "Sign out",
              desc: "Do you wish to continue with this action?",
              buttons: [
                DialogButton(
                  color: Color(0XFF35D4C0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                ),
                DialogButton(
                  color: Colors.red,
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    auth.signOut();
                    prefs.remove("userID");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  width: 120,
                ),
              ],
            ).show();
          },
        ),
      ],
    );
  }
}
