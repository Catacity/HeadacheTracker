import 'package:flutter/material.dart';
import 'package:fluttertest/components/helptofill.dart';
import 'package:fluttertest/components/loginsignupheader.dart';
import 'package:fluttertest/components/text_field.dart';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
import 'package:fluttertest/userdata/userfile.dart';
import 'package:fluttertest/pages/signup_page.dart';
import 'package:fluttertest/pages/Home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var databaseconnect;

  @override
  void initState() {
    super.initState();
    databaseconnect = databaseconnect();
  }

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await databaseconnect.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => MyHomePage()),
                    (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
            print(error);
            alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(userfile user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
    sp.setString("user_gender", user.user_gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginsignupheader('Login'),
              text_field(
                controller: _conUserId,
                icon: Icons.person,
                hintName: 'User ID',
                isObscureText: true,),
              SizedBox(height: 10.0),
              text_field(
                controller: _conPassword,
                icon: Icons.lock,
                hintName: 'Password',
                isObscureText: true,
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: TextButton(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: login,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do not have account? '),
                    TextButton(
                      //textColor: Colors.blue,
                      child: Text('Signup'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => signup_page()));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}