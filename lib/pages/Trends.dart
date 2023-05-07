import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertest/pages/headache_intensity_page.dart';
import 'package:fluttertest/pages/headache_medicine_page.dart';
import 'package:fluttertest/pages/symptoms_intesity_page.dart';
import 'package:fluttertest/pages/daily_headache_data.dart';
import 'package:fluttertest/pages/sleep_page.dart';

import 'package:fluttertest/databasehandler/headacheForm.dart';

// Helper functions // // // // // // // // // // // // // // // // // // // // // // // // //
Future<List<Map<String, dynamic>>>fetchDataHeadache(String userID) async {
  // Fetch relevant record from DB
  // HeadacheFormDBHelper.instance.fetchTableData();
  var Qresult = await HeadacheFormDBHelper.instance.fetchValidEntriesForUser(userID);
  List<Map<String, dynamic>> Result = Qresult ?? [];

  return Result;
}

Future<List<Map<String, dynamic>>> reformatDataHeadache(Future<List<Map<String, dynamic>>>? qResult) async{
  List<Map<String, dynamic>> Result = await qResult ?? [];
  // print("query input in reformatData():");
  // print(qResult);
  List<Map<String, dynamic>> data = [];
  for (int i = 0 ; i < Result.length ; i++){
    Map<String, dynamic> entry = {};
    entry['headacheEntryid'] = Result[i]['headacheEntryid'] ?? -1;

    DateTime ts1 = milisecondsToDatetime(Result[i]['TS_DATE'] ?? 0);
    entry['TS_DATE'] = ts1.toString();

    entry['intensityLevel'] = Result[i]['intensityLevel'] ?? 0;
    entry['medicineName'] = Result[i]['medicineName'] ?? "";

    // Assume partial if somehow null
    entry['Partial'] = Result[i]['Partial'] ?? 1;

    DateTime ts2 = DateTime.fromMillisecondsSinceEpoch(Result[i]['medicineDateMS'] ?? 0);
    entry['medicineDateMs'] = ts2.toString().substring(0,10);

    // print("Entry ${i}");
    // print(entry);

    data.add(entry);
  }

  // print("ReformatData: In function ");
  // print(data);
  return data;
}

DateTime milisecondsToDatetime(int ms) {
  int ts = ms * 1000;
  var date = DateTime.fromMillisecondsSinceEpoch(ts);
  return date;
}

// Trends' main page // // // // // // // // // // // // // // // // // // // // // // // // //
class Trends extends StatefulWidget {
  // Initial data fetching all preformed in this page, so I made this stateful
  final String userID;
  final Future<List<Map<String, dynamic>>> headacheQueryResult;
  final Future<List<Map<String, dynamic>>> reformattedData;

  const Trends({Key? key, required this.userID, required this.headacheQueryResult, required this.reformattedData}) : super(key: key);

  factory Trends.async({required Key key, required String userID}) {
    Future<List<Map<String, dynamic>>> HQueryResult = fetchDataHeadache(userID);

    return Trends(
      key: key,
      userID: userID,
      headacheQueryResult: HQueryResult,
      reformattedData: reformatDataHeadache(HQueryResult),
    );
  }

  @override
  _TrendsPageState createState() => _TrendsPageState();
}

class _TrendsPageState extends State<Trends> {
  // Future<String> HeadacheDataToJson() async{
  //   List<Map<String, dynamic>> data = await widget.reformattedData;
  //   // print(data);
  //   // List<Map<String, dynamic>> data = [
  //   //
  //   //   {"headacheEntryid": 86, "TS_DATE": "2023-05-18 10:30:00.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-05-17"},
  //   //   {"headacheEntryid": 87, "TS_DATE": "2023-05-24 14:15:00.000000000", "intensityLevel": 2, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-05-23"},
  //   //   {"headacheEntryid": 88, "TS_DATE": "2023-06-02 16:45:00.000000000", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2023-06-01"},
  //   //   {"headacheEntryid": 89, "TS_DATE": "2023-06-08 09:30:00.000000000", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2023-06-07"},
  //   //   {"headacheEntryid": 90, "TS_DATE": "2023-06-15 12:00:00.000000000", "intensityLevel": 2, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-06-14"},
  //   //   {"headacheEntryid": 91, "TS_DATE": "2023-06-21 15:00:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-06-20"},
  //   //   {"headacheEntryid": 92, "TS_DATE": "2023-06-28 18:00:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2023-06-27"},
  //   //   {"headacheEntryid": 93, "TS_DATE": "2023-07-05 10:00:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-07-04"},
  //   //   {"headacheEntryid": 10, "TS_DATE": "2020-02-04 10:20:30.123456789", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMS": "2020-02-03"},
  //   //     {"headacheEntryid": 11, "TS_DATE": "2020-02-12 14:25:35.234567890", "intensityLevel": 1, "medicineName": "Ibropufen", "Partial": 1, "medicineDateMS": "2020-02-11"},
  //   //     {"headacheEntryid": 12, "TS_DATE": "2020-02-16 11:30:40.345678901", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMS": "2020-02-15"},
  //   //     {"headacheEntryid": 13, "TS_DATE": "2020-02-20 12:35:45.456789012", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMS": "2020-02-19"},
  //   //     {"headacheEntryid": 14, "TS_DATE": "2020-02-27 15:40:50.567890123", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMS": "2020-02-26"},
  //   //     {"headacheEntryid": 15, "TS_DATE": "2020-03-03 16:45:55.678901234", "intensityLevel": 1, "medicineName": "Ibropufen", "Partial": 0, "medicineDateMS": "2020-03-02"},
  //   //     {"headacheEntryid": 16, "TS_DATE": "2020-03-08 17:50:05.789012345", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMS": "2020-03-07"},
  //   //     {"headacheEntryid": 17, "TS_DATE": "2020-03-11 18:55:10.890123456", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMS": "2020-03-10"},
  //   // {"headacheEntryid": 18, "TS_DATE": "2020-03-19 19:00:15.901234567", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 0, "full": 1, "medicineDateMS": "2020-03-19"},
  //   // {"headacheEntryid": 19, "TS_DATE": "2020-03-23 20:05:20.012345678", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 1, "full": 0, "medicineDateMS": "2020-03-23"},
  //   // {"headacheEntryid": 20, "TS_DATE": "2020-03-29 21:10:25.123456789", "intensityLevel": 2, "medicineName": "Naproxen", "Partial": 0, "full": 1, "medicineDateMS": "2020-03-29"},
  //   // {"headacheEntryid": 21, "TS_DATE": "2020-04-02 22:15:30.234567890", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "full": 1, "medicineDateMS": "2020-04-02"},
  //   // {"headacheEntryid": 22, "TS_DATE": "2020-04-07 23:20:35.345678901", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 1, "full": 0, "medicineDateMS": "2020-04-07"},
  //   // {"headacheEntryid": 23, "TS_DATE": "2020-04-10 01:25:40.456789012", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "full": 1, "medicineDateMS": "2020-04-10"},
  //   // {"headacheEntryid": 24, "TS_DATE": "2020-04-16 02:30:45.567890123", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 1, "full": 0, "medicineDateMS": "2020-04-16"},
  //   // {"headacheEntryid": 25, "TS_DATE": "2020-04-22 03:35:50.678901234", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "full": 1, "medicineDateMS": "2020-04-22"},
  //   // {"headacheEntryid": 26, "TS_DATE": "2020-04-26 04:40:55.789012345", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "full": 0, "medicineDateMS": "2020-04-26"},
  //   // {"headacheEntryid": 27, "TS_DATE": "2021-01-05 10:12:35.123456789", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-01-04"},
  //   // {"headacheEntryid": 28, "TS_DATE": "2021-01-07 12:30:15.987654321", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-01-06"},
  //   // {"headacheEntryid": 29, "TS_DATE": "2021-01-10 14:45:05.246813579", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-01-09"},
  //   // {"headacheEntryid": 30, "TS_DATE": "2021-01-15 16:18:34.135792468", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-01-14"},
  //   // {"headacheEntryid": 31, "TS_DATE": "2021-01-17 18:23:12.975310642", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-01-16"},
  //   // {"headacheEntryid": 32, "TS_DATE": "2021-01-22 20:55:43.086421753", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-01-21"},
  //   // {"headacheEntryid": 33, "TS_DATE": "2021-02-01 08:05:59.012345678", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2021-01-31"},
  //   // {"headacheEntryid": 34, "TS_DATE": "2021-02-04 10:25:21.987654321", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2021-02-03"},
  //   // {"headacheEntryid": 35, "TS_DATE": "2021-02-12 12:15:01.246813579", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-02-11"},
  //   // {"headacheEntryid": 36, "TS_DATE": "2021-02-16 14:32:45.135792468", "intensityLevel": 3, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-02-15"},
  //   // {"headacheEntryid": 37, "TS_DATE": "2021-02-20 16:47:38.975310642", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-02-19"},
  //   //   {"headacheEntryid": 38, "TS_DATE": "2021-02-27 10:30:45.123456789", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-02-26"},
  //   //   {"headacheEntryid": 39, "TS_DATE": "2021-03-03 12:15:30.987654321", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 1, "medicineDateMs": "2021-03-02"},
  //   //   {"headacheEntryid": 40, "TS_DATE": "2021-03-08 15:45:20.246813579", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-03-07"},
  //   //   {"headacheEntryid": 41, "TS_DATE": "2021-03-11 08:30:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2021-03-19"},
  //   //   {"headacheEntryid": 42, "TS_DATE": "2021-06-02 14:20:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-06-01"},
  //   //   {"headacheEntryid": 43, "TS_DATE": "2021-06-07 18:05:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-06-06"},
  //   //   {"headacheEntryid": 44, "TS_DATE": "2021-06-12 22:15:00.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-06-11"},
  //   //   {"headacheEntryid": 45, "TS_DATE": "2021-06-18 08:30:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-06-17"},
  //   //   {"headacheEntryid": 46, "TS_DATE": "2021-06-25 14:20:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-06-24"},
  //   //   {"headacheEntryid": 47, "TS_DATE": "2021-10-05 10:15:30.000000000", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-10-04"},
  //   //   {"headacheEntryid": 48, "TS_DATE": "2021-10-09 15:45:20.000000000", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-10-08"},
  //   //   {"headacheEntryid": 49, "TS_DATE": "2021-10-15 18:05:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-10-14"},
  //   //   {"headacheEntryid": 50, "TS_DATE": "2021-10-22 22:15:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-10-21"},
  //   //   {"headacheEntryid": 51, "TS_DATE": "2021-10-28 11:30:45.000000000", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 1, "medicineDateMs": "2021-10-27"},
  //   //   {"headacheEntryid": 52, "TS_DATE": "2021-11-05 09:45:30.000000000", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2021-11-04"},
  //   //   {"headacheEntryid": 53, "TS_DATE": "2021-11-11 16:20:15.000000000", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-11-10"},
  //   //   {"headacheEntryid": 54, "TS_DATE": "2021-11-17 00:12:34.000000000", "intensityLevel": 3, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-11-16"},
  //   //   {"headacheEntryid": 55, "TS_DATE": "2021-11-23 01:23:45.000000000", "intensityLevel": 2, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-11-22"},
  //   //   {"headacheEntryid": 56, "TS_DATE": "2023-02-02 02:34:56.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-02-01"},
  //   //   {"headacheEntryid": 57, "TS_DATE": "2023-02-08 03:45:57.000000000", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2023-02-07"},
  //   //   {"headacheEntryid": 58, "TS_DATE": "2023-02-14 04:56:58.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-02-13"},
  //   //   {"headacheEntryid": 59, "TS_DATE": "2023-02-22 05:12:34.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2023-02-21"},
  //   //   {"headacheEntryid": 60, "TS_DATE": "2023-03-05 06:23:45.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2023-03-04"},
  //   //   {"headacheEntryid": 61, "TS_DATE": "2023-03-10 07:34:56.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-03-09"},
  //   //   {"headacheEntryid": 62, "TS_DATE": "2023-03-18 08:45:57.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2023-03-17"},
  //   //   {"headacheEntryid": 78, "TS_DATE": "2023-03-27 08:30:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-03-26"},
  //   //   {"headacheEntryid": 79, "TS_DATE": "2023-04-01 12:00:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2023-03-31"},
  //   //   {"headacheEntryid": 80, "TS_DATE": "2023-04-06 15:45:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-04-05"},
  //   //   {"headacheEntryid": 81, "TS_DATE": "2023-04-15 18:20:00.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-04-14"},
  //   //   {"headacheEntryid": 82, "TS_DATE": "2023-04-20 21:00:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2023-04-19"},
  //   //   {"headacheEntryid": 83, "TS_DATE": "2023-04-28 09:15:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2023-04-27"},
  //   //   {"headacheEntryid": 84, "TS_DATE": "2023-05-04 14:30:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2023-05-03"},
  //   //   {"headacheEntryid": 85, "TS_DATE": "2023-05-11 16:45:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-01-02"}
  //   //
  //   //
  //   // ];
  //
  //   setState(() {
  //     reformattedStringHeadache = jsonEncode(data);
  //   });
  //
  //   return jsonEncode(data);
  // }

  List<Map<String, dynamic>>? headacheQueryResult;
  String? reformattedStringHeadache;

  @override
  void initState() {
    super.initState();

    widget.headacheQueryResult.then((qResult) {
      setState(() {
        headacheQueryResult = qResult;
      });
    });

    widget.reformattedData.then((qResult) {
      List<Map<String, dynamic>> data = qResult;
      setState(() {
        reformattedStringHeadache = jsonEncode(data);
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(

          children: [
            SizedBox(height: 30),
            Text(
              'Trends and insights',
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue ,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeadacheTrendsPage.async(key: ValueKey(now), headacheJsonString: reformattedStringHeadache ?? "{}"),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children:[
                        Image.asset(
                          'lib/images/headache.png',

                          height: 40,
                          color: Colors.white,


                        ),
                        SizedBox(width: 5),
                        Text(
                          'Headache Trends',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 100),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'lib/images/plot.png',
                      width: 500,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HabitHeadacheRelationPage(headacheJsonString: reformattedStringHeadache ?? "{}"),
                    ),
                  );
                },

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.directions_run,
                          color: Colors.white,
                          size: 30,
                        ),

                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),

                        Image.asset(
                          'lib/images/headache.png',

                          height: 40,
                          color: Colors.white,

                        ),
                        SizedBox(width: 10),
                        Text(
                          'Habits and Headache',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),

                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),


                    Image.asset(
                      'lib/images/trends.png',
                      width: 500,
                      height: 90,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Habit relation page // // // // // // // // // // // // // // // // // // // // // Trying to merge
class HabitHeadacheRelationPage extends StatefulWidget {
  final String headacheJsonString;

  const HabitHeadacheRelationPage({Key? key, required this.headacheJsonString}) : super(key: key);

  factory HabitHeadacheRelationPage.async({required Key key, required String headacheJsonString}) {

    return HabitHeadacheRelationPage(
        key: key,
        headacheJsonString: headacheJsonString
    );
  }

  @override
  _HabitHeadacheRelationPageState createState() => _HabitHeadacheRelationPageState();
}

class _HabitHeadacheRelationPageState extends State<HabitHeadacheRelationPage> {
  String? _tempHtmlFilePath;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _loadHtmlFromAssets().then((File file) {
      setState(() {
        _tempHtmlFilePath = file.uri.toString();
      });
    });
  }

  Future<File> _loadHtmlFromAssets() async {
    // Replace 'assets/html/sample.html' with the path to your HTML file
    String fileText = await rootBundle.loadString('assets/vega_lite5.html');

    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/temp.html');
    await tempFile.writeAsString(
      fileText.replaceAll('{{data}}', dataToJson1()), // Replace {{data}} with JSON data
      flush: true,
    );
    return tempFile;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Headache and Habit Analysis'),
      ),
      body: _tempHtmlFilePath == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Flexible(
            child: Container(
              height: 500, // set the height as needed
              child: WebView(
                initialUrl: _tempHtmlFilePath,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                onPageFinished: (String url) {
                  _controller?.evaluateJavascript('updateChart()');
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'See more visualizations and insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(context, 'Sleep', 'lib/images/sleep.png',  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SleepPage()));
              }),
              customButton(context, 'Stress', 'lib/images/stress.png',  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HeadacheMedicinePage(jsonData:widget.headacheJsonString)));
              }),
              customButton(context, 'Exercise', 'lib/images/exercise.png',  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SymptomsIntensityPage(jsonData:widget.headacheJsonString)));
              }),
            ],
          ),



        ],
      ),
    );

  }

  Widget customButton(BuildContext context, String text, String imagePath,  void Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 3 - 20,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 40,

              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

// Headache trends page
class HeadacheTrendsPage extends StatefulWidget {
  final String headacheJsonString;

  const HeadacheTrendsPage({Key? key, required this.headacheJsonString}) : super(key: key);

  factory HeadacheTrendsPage.async({required Key key, required String headacheJsonString}) {

    return HeadacheTrendsPage(
      key: key,
      headacheJsonString: headacheJsonString
    );
  }

  @override
  _HeadacheTrendsPageState createState() => _HeadacheTrendsPageState();
}

class _HeadacheTrendsPageState extends State<HeadacheTrendsPage> {

  String? _tempHtmlFilePath;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _loadHtmlFromAssets().then((File file) {
      setState(() {
        _tempHtmlFilePath = file.uri.toString();
      });
    });

  }

  Future<File> _loadHtmlFromAssets() async {
    // Replace 'assets/html/sample.html' with the path to your HTML file
    String fileText = await rootBundle.loadString('assets/vega_lite0.html');

    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/temp.html');
    await tempFile.writeAsString(
      fileText.replaceAll('{{data}}', widget.headacheJsonString), // Replace {{data}} with JSON data
      flush: true,
    );
    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Headache Relation'),
      ),
      body: _tempHtmlFilePath == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Flexible(
            child: Container(
              height: 500, // set the height as needed
              child: WebView(
                initialUrl: _tempHtmlFilePath,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                onPageFinished: (String url) {
                  _controller?.evaluateJavascript('updateChart()');
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'See more visualizations and insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(context, 'Intensity', 'lib/images/intensity.png',  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HeadacheIntensityPage(jsonData:widget.headacheJsonString)));
              }),

              customButton(context, 'Medicine', 'lib/images/pill.png',  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HeadacheMedicinePage(jsonData:widget.headacheJsonString)));
              }),
              customButton(context, 'Symptom', 'lib/images/symptom.png',  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SymptomsIntensityPage(jsonData:widget.headacheJsonString)));
              }),
            ],
          ),



        ],
      ),
    );

  }
  Widget customButton(BuildContext context, String text, String imagePath,  void Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 3 - 20,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 40,

              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
