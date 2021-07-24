import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/screens/account_ui/account_cards.dart';
import 'package:poultry/screens/onboarding_ui/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: CircleAvatar(
                    backgroundColor: Color(0XFF35D4C0),
                    radius: 50,
                    child: Icon(
                      FluentIcons.person_16_regular,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                Text(
                  "Name: ${prefs.getString("name")}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  "Email: ${prefs.getString("email")}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  "Phone Number: ${prefs.getString("phoneNumber")}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  "Address: ${prefs.getString("address")}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
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
                      prefs.remove("name");
                      prefs.remove("email");
                      prefs.remove("phoneNumber");
                      prefs.remove("address");
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
      ),
    );
  }
}
