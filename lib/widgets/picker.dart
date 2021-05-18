import 'package:flutter/material.dart';

Container customPicker(
  BuildContext context,
  List items,
  String chosenValue,
  Function changeFunct,
) {
  List<DropdownMenuItem> itemList = [];
  for (var item in items) {
    var option = DropdownMenuItem(
      child: Text(
        " $item",
      ),
      value: item,
    );
    itemList.add(option);
  }

  return Container(
    color: Color(0XFFEAE9EB),
    child: DropdownButton(
      underline: Container(),
      items: itemList,
      value: chosenValue,
      onChanged: changeFunct,
    ),
  );
}
