import 'package:flutter/material.dart';
import 'package:fluttertest/components/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertest/userdata/userfile.dart';
import 'package:fluttertest/components/helptofill.dart';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
import 'package:fluttertest/pages/login_page.dart';

class userprofile_info extends StatefulWidget {
  @override
  userprofile_infoState createState() => userprofile_infoState();
}

class userprofile_infoState extends State<userprofile_info> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();
  late databaseconnect dbhelp;

  final _conUserId = TextEditingController();
  final _condelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conUserGender = TextEditingController();

  @override
  void initState(){
    super.initState();
    getUserData();

    dbhelp = databaseconnect();
  }

  Future<void> getUserData()async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text= sp.getString('user_id')!;
      _condelUserId.text= sp.getString("user_id")!;
      _condelUserId.text= sp.getString("user_id")!;
      _conUserName.text= sp.getString("user_name")!;
      _conEmail.text= sp.getString("email")!;
      _conPassword.text= sp.getString("password")!;
      _conUserGender.text= sp.getString("user_gender")!;
    });
  }

  update() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String ugender = _conUserGender.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      userfile user = userfile(uid, uname, email, passwd, ugender);
      await dbhelp.updateUser(user).then((value) {
        if (value == 1) {
          alertDialog(context, "Successfully Updated");

          updateSP(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => login_page()),
                    (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error Update");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error");
      });
    }
  }

  delete() async {
    String delUserID = _condelUserId.text;

    await dbhelp.deleteUser(delUserID).then((value) {
      if (value == 1) {
        alertDialog(context, "Successfully Deleted");

        updateSP(delUserID as userfile, false).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => login_page()),
                  (Route<dynamic> route) => false);
        });
      }
    });
  }

  Future updateSP(userfile user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("user_name", user.user_name);
      sp.setString("email", user.email);
      sp.setString("password", user.password);
    } else {
      sp.remove('user_id');
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
      sp.remove('user_gender');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Info'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //  Update
                  text_field(
                      controller: _conUserId,
                      enable: true,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  SizedBox(height: 10.0),
                  text_field(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  SizedBox(height: 10.0),
                  text_field(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  text_field(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  text_field(
                    controller: _conUserGender,
                    icon: Icons.person,
                    inputType: TextInputType.name,
                    hintName: 'Gender',
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: update,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),

                  //Delete

                  text_field(
                      controller: _condelUserId,
                      enable: false,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextButton(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: delete,
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