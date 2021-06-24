import 'package:flutter/material.dart';
import 'package:poultry/providers/layout_index.dart';
import 'package:provider/provider.dart';

class QuickOptionCard extends StatelessWidget {
  final int navToScreen;
  final String imagePath;
  final String title;
  final String infoText;
  QuickOptionCard({
    @required this.navToScreen,
    @required this.imagePath,
    @required this.title,
    @required this.infoText,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Provider.of<LayoutIndexProv>(context, listen: false)
              .onTapChangeScreen(navToScreen);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0XFFEFF4F5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          height: 200,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                scale: 2.5,
                color: Colors.black,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(infoText),
            ],
          ),
        ),
      ),
    );
  }
}
