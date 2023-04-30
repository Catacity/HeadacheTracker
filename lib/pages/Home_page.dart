import 'package:flutter/material.dart';
import 'package:fluttertest/pages/daily_form.dart';
import 'package:fluttertest/pages/calendar.dart';
import 'package:fluttertest/pages/main_page.dart';
// import 'package:fluttertest/pages/login_page.dart';
import 'package:fluttertest/components/button.dart';
import 'package:fluttertest/components/text_field.dart';
import 'package:fluttertest/components/square_tile.dart';
import 'Trends.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List pages = [
    DailyForm(),
    HeadacheFormMenu(),
    HeadTrackerPage(),
    Trends()
  ];
  List<Color> colors1 = [Colors.white, Colors.black, Colors.white, Colors.white];
  List<Color> colors2 = [Colors.lightBlueAccent, Colors.white, Colors.lightBlueAccent, Colors.lightBlueAccent];


  int currentIndex = 0;
  void OnTap(int index) {
    setState(() {
      currentIndex= index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: IconButton(
                  onPressed: () {
                    // Impletement goto page here!
                  },
                  icon: Icon(
                    Icons.person_pin,
                    size: 25.0,
                  ),
                  color: colors1[currentIndex],
                ),
              ),

              Container(
                child: Text("Hi Kimmie!",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'handrawn',
                    color: colors1[currentIndex],
                  ),
                ),
              ),

              Container(
                child: IconButton(
                  onPressed: () {
                    // Impletement goto page here!
                  },
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    size: 25.0,
                  ),
                  color: colors1[currentIndex],
                ),
              ),


            ],
          ),
          // Text("Headache Form"),
          // centerTitle: true,
          backgroundColor: colors2[currentIndex]
      ),
      body: currentIndex == 0
          ? SingleChildScrollView(child: pages[currentIndex])
          : pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: colors2[currentIndex],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Daily Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headset_mic_outlined),
            label: 'Headache',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined,
                ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph,
            ),
            label: 'Trends',
          ),
        ],
        selectedItemColor: colors1[currentIndex],
        onTap: OnTap,
        type: BottomNavigationBarType.fixed,
      ),


    );
  }
}
