import 'package:flutter/material.dart';
import 'package:fluttertest/pages/Home_page.dart';
import 'package:fluttertest/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MyHomePage(),
    );
  }
}