import 'package:flutter/material.dart';
import 'package:fluttertest/components/drawer_header.dart';

import 'daily_headache_data.dart';
import 'notifications.dart';
import 'privacy_policy.dart';
import 'settings.dart';
import 'userprofile_info.dart';

import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/pages/daily_form.dart';
import 'package:fluttertest/pages/main_page.dart';
import 'Home_page.dart';

import 'notifications.dart';
import 'privacy_policy.dart';
import 'settings.dart';
import 'userprofile_info.dart';

import 'Trends.dart';

class sidebar extends StatefulWidget {
  @override
  _sidebarState createState() => _sidebarState();
  }

  class _sidebarState extends State<sidebar> {
  var currentPage = DrawerSections.Home_page;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.Home_page) {
      container = MyHomePage();
    } else if (currentPage == DrawerSections.daily_form) {
      container = DailyForm();
    } else if (currentPage == DrawerSections.Trends) {
      var HQueryResult;
      Future<List<Map<String, dynamic>>>? DQueryResult;
      container = Trends(userID: userID, headacheQueryResult: HQueryResult,
          reformattedHData: reformatDataHeadache(HQueryResult),
          reformattedDData: reformatDataDaily(DQueryResult));
    } else if (currentPage == DrawerSections.userprofile_info) {
      container = userprofile_info();
    } else if (currentPage == DrawerSections.settings) {
      container = SettingsPage();
    } else if (currentPage == DrawerSections.notifications) {
      container = NotificationsPage();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = PrivacyPolicyPage();
    }

    return Scaffold(
    drawer: Drawer(
        child: SingleChildScrollView(
        child: Container(
        child: Column(
        children: [
          MyHeaderDrawer(),
          MyDrawerList(),
        ],
       ),
      ),
     ),
    ),
    );
  }
}
Widget MyDrawerList() {
  var currentPage;
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      // shows the list of menu drawer
      children: [
        menuItem(1, "Home", Icons.home,
            currentPage == DrawerSections.Home_page ? true : false),
        menuItem(2, "Daily Form", Icons.file_copy_outlined,
            currentPage == DrawerSections.daily_form ? true : false),
        menuItem(3, "Trends", Icons.event,
            currentPage == DrawerSections.Trends ? true : false),
        menuItem(4, "Profile", Icons.person,
            currentPage == DrawerSections.userprofile_info ? true : false),
        Divider(),
        menuItem(5, "Settings", Icons.settings_outlined,
            currentPage == DrawerSections.settings ? true : false),
        menuItem(6, "Notifications", Icons.notifications_outlined,
            currentPage == DrawerSections.notifications ? true : false),
        Divider(),
        menuItem(7, "Privacy Policy", Icons.privacy_tip_outlined,
            currentPage == DrawerSections.privacy_policy ? true : false),
      ],
    ),
  );
}
Widget menuItem(int id, String title, IconData icon, bool selected) {
  return Material(
    color: selected ? Colors.grey[300] : Colors.transparent,
    child: InkWell(
      onTap: () {
        //Navigator.canPop(context);

        setState(() {
          if (id == 1) {
            var currentPage = DrawerSections.Home_page;
          } else if (id == 2) {
            var currentPage = DrawerSections.daily_form;
          } else if (id == 3) {
            var currentPage = DrawerSections.Trends;
          } else if (id == 4) {
            var currentPage = DrawerSections.userprofile_info;
          } else if (id == 5) {
            var currentPage = DrawerSections.settings;
          } else if (id == 6) {
            var currentPage = DrawerSections.notifications;
          } else if (id == 7) {
            var currentPage = DrawerSections.privacy_policy;
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void setState(Null Function() param0) {
}

enum DrawerSections {
  Home_page,
  daily_form,
  Trends,
  userprofile_info,
  settings,
  notifications,
  privacy_policy,
}