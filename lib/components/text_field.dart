import 'package:flutter/material.dart';
import 'helptofill.dart';

class text_field extends StatelessWidget {
  //const text_field({Key? key}) : super(key: key);
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool enable;
  var validator;
  var decoration;

  text_field(
      { required this.controller,
        required this.hintName,
        required this.icon,
        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.enable = true,
        //required keyboardType,
        this.decoration,
        this.validator
      });

  get isEnable => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: text_field(
        controller: controller,
        isObscureText: isObscureText,
        enable: isEnable,
        inputType: TextInputType.text,
        validator: (value) {
           if (value == null || value.isEmpty) {
             return 'Please enter $hintName';
           }
           if (hintName == "Email" && !validateEmail(value)) {
             return 'Please Enter Valid Email';
           }
             return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
        prefixIcon: Icon(icon),
        hintText: hintName,
        labelText: hintName,
        fillColor: Colors.grey[200],
        filled: true
        ), hintName: '', icon: icon,
      ),
    );
  }
}