import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final Function function;
  AccountCard({
    @required this.title,
    @required this.hintText,
    @required this.icon,
    this.function,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: function,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Color(0XFF35D4C0),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF35D4C0),
                    ),
                  ),
                  Text(
                    hintText,
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
