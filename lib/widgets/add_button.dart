import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Function function;
  AddButton({
    @required this.title,
    @required this.function,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Card(
        shadowColor: Colors.red,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0XFF35D4C0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    FluentIcons.add_circle_20_regular,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: function,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
