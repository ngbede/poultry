import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toaster(String message, ToastGravity position) async {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: position,
    timeInSecForIosWeb: 1,
    backgroundColor: Color(0XFF35D4C0),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
