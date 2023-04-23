import 'package:flutter/material.dart';
import 'package:fluttertest/components/helptofill.dart';
import 'package:fluttertest/components/loginsignupheader.dart';
import 'login_page.dart';
import 'package:fluttertest/components/text_field.dart';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
import 'package:fluttertest/userdata/userfile.dart';
import 'package:toast/toast.dart';
import 'package:fluttertest/pages/login_page.dart';

class signup_page extends StatefulWidget {
  @override
  _signup_pageState createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  final _conUserGender = TextEditingController();
  var databaseconnect;

  @override
  void initState(){
    super.initState();
    databaseconnect = databaseconnect();
}
  signup() async {
    final form = _formKey.currentState;

    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;
    String ugender = _conUserGender.text;

   // if(form.validate()){

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState?.save();

        userfile uModel = userfile(uid, uname, email, passwd, ugender);
        await databaseconnect.saveData(uModel).then((userData){
          alertDialog(context, "Successfully Saved");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => login_page()));

        }).catchError((error){
          print(error);
          alertDialog(context, "Error: Data Saving Failed");
        });
//          Navigator.push(
    //            context, MaterialPageRoute(builder: (_) => LoginForm()));
    //    }).catchError((error) {
    //    print(error);
    //  alertDialog(context, "Error: Data Save Fail");});
        }
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Login with Signup'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginsignupheader('Signup'),
                    text_field(
                        controller: _conUserId,
                        icon: Icons.person,
                        hintName: 'User ID',),
                    SizedBox(height: 10.0),
                    text_field(
                        controller: _conUserName,
                        icon: Icons.person_outline,
                        inputType: TextInputType.name,
                        hintName: 'User Name',),
                    SizedBox(height: 5.0),
                    text_field(
                        controller: _conEmail,
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        hintName: 'Email',),
                    SizedBox(height: 5.0),
                    text_field(
                      controller: _conPassword,
                      icon: Icons.lock,
                      hintName: 'Password',
                      isObscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    text_field(
                      controller: _conCPassword,
                      icon: Icons.lock,
                      hintName: 'Confirm Password',
                      isObscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    text_field(
                        controller: _conUserGender,
                        icon: Icons.person,
                        inputType: TextInputType.name,
                        hintName: 'Gender'),

                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          'Signup',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: signup(),
                      ), //FlatButton
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text('Have account Already? '),
                      TextButton(
                          //onPressed: onPressed,
                        //textColor: Colors.blue,
                        child: Text('Sign In'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => login_page()));
                        },
                      )
                          ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      );
    }
  }