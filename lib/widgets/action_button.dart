import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget childWidget;
  final Color color;
  ActionButton({
    @required this.childWidget,
    this.color = const Color(0XFF35D4C0),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
