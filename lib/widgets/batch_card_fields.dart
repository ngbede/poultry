import 'package:flutter/material.dart';
import 'package:poultry/widgets/styles.dart';

class BatchCardFields extends StatelessWidget {
  final String title;
  final String info;
  BatchCardFields({@required this.title, @required this.info});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: batchCardLeadingText,
          ),
          Text(
            info,
            style: batchCardTrailingText,
          ),
        ],
      ),
    );
  }
}
