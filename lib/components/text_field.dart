import 'package:flutter/material.dart';
import 'helptofill.dart';

class text_field extends StatelessWidget {
  //final controller;
  final String hintText;
  final bool obscureText;
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool enable;
  var validator;
  var decoration;

  text_field({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    //required InputDecoration decoration,
    required this.hintName,
    required this.icon,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
    this.enable = true,
    //required keyboardType,
    this.decoration,
    this.validator,
    // required this.obscureText
  });

  get isEnable => null;

  // {
  //TODO: implement TextField
//    throw UnimplementedError();
  // }// {
  //TODO: implement TextField
  //throw UnimplementedError();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
      //    TextField(
          //controller: controller,
      //    obscureText: obscureText,
      //    decoration: InputDecoration(
      //        enabledBorder: const OutlineInputBorder(
      //          borderSide: BorderSide(color: Colors.white),
      //        ),
      //        focusedBorder: OutlineInputBorder(
      //          borderSide: BorderSide(color: Colors.grey.shade400),
      //        ),
      //        fillColor: Colors.grey.shade200,
      //        filled: true,
      //        hintText: hintText,
      //        hintStyle: TextStyle(color: Colors.grey[500]))
        text_field(
          controller: controller,
            //isObscureText: isObscureText,
          obscureText: obscureText,
          hintText: hintText,
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
                filled: true,
                //hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500])
            ),
          hintName: '',
          icon: icon,
        ),
      ),
    );
  }
}
