import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

alertDialog(BuildContext context, String msg) {
  Fluttertoast.showToast(toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, msg: 'Enter Valid Mail');
}
validateEmail(String email) {
  final emailReg = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}