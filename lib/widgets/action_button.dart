import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget childWidget;
  ActionButton({@required this.childWidget});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0XFF35D4C0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 7.0,
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
