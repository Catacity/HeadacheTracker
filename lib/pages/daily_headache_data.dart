import 'dart:convert';
import 'package:fluttertest/databasehandler/headacheForm.dart';
import 'package:fluttertest/databasehandler/dailyForm.dart';

DateTime milisecondsToDatetime(int ms) {
  int ts = ms * 1000;
  var date = DateTime.fromMillisecondsSinceEpoch(ts);
  return date;
}

Future<List<Map<String, dynamic>>>fetchDataHeadache(String userID) async {
  // Fetch relevant record from DB
  // HeadacheFormDBHelper.instance.fetchTableData();
  var Qresult = await HeadacheFormDBHelper.instance.fetchValidEntriesForUser(userID);
  List<Map<String, dynamic>> Result = Qresult ?? [];

  return Result;
}

Future<List<Map<String, dynamic>>>fetchDataDaily(String userID) async {
  // Fetch relevant record from DB
  // HeadacheFormDBHelper.instance.fetchTableData();
  var Qresult = await DailyFormDBHelper.instance.fetchValidEntriesForUser(userID);
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

Future<List<Map<String, dynamic>>> reformatDataDaily(Future<List<Map<String, dynamic>>>? qResult) async {

  // E.g input: {dailyEntryid: 4, userid: 3, TS: 1683215704, TS_DATE: 1683129600, sleepQuality: 72.35254047575981, sleepHours: 10, sleepMinutes: 12, dailyDescription: , stressLV: 4, didExercise: Yes, exerciseType: do ex, exerciseDurationMin: 123, maxTS: 1683215704}
  List<Map<String, dynamic>> Result = await qResult ?? [];

  List<Map<String, dynamic>> data = [];
  for (int i = 0 ; i < Result.length ; i++){
    // print(Result[i]);
    Map<String, dynamic> entry = {};

    DateTime ts1 = milisecondsToDatetime(Result[i]['TS_DATE'] ?? 0);
    entry['TS_DATE'] = ts1.toString();

    entry['sleepQuality'] = Result[i]['sleepQuality'] ?? 0;
    entry['sleepHours'] = Result[i]['sleepHours'] ?? 0;
    entry['sleepMinutes'] = Result[i]['sleepMinutes'] ?? 0;

    entry['dailyDescription'] = Result[i]['dailyDescription'] ?? "";
    entry['stressLV'] = Result[i]['stressLV'] ?? 1;

    entry['didExercise'] = Result[i]['stressLV'] ?? "No";
    entry['exerciseType'] = Result[i]['exerciseType'] ?? "";
    entry['exerciseDuration'] = Result[i]['exerciseDurationMin'] ?? 0;

    // print("Entry ${i}:");
    // print(entry);
    data.add(entry);
  }

  return data;
  //   [
  //
  //   {"TS_DATE": "2020-04-07 23:20:35.345678901", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 40},
  //   {"TS_DATE": "2020-04-10 01:25:40.456789012", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2020-04-16 02:30:45.567890123", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 55},
  //   {"TS_DATE": "2020-04-22 03:35:50.678901234", "sleepQuality": 68, "sleepHours": 5, "sleepMinutes": 35, "dailyDescription": "test", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 50},
  //   {"TS_DATE": "2020-04-26 04:40:55.789012345", "sleepQuality": 84, "sleepHours": 8, "sleepMinutes": 10, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2021-01-05 10:12:35.123456789", "sleepQuality": 73, "sleepHours": 6, "sleepMinutes": 50, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 30},
  //   {"TS_DATE": "2021-01-07 12:30:15.987654321", "sleepQuality": 95, "sleepHours": 9, "sleepMinutes": 5, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
  //   {"TS_DATE": "2021-01-10 14:45:05.246813579", "sleepQuality": 80, "sleepHours": 7, "sleepMinutes": 20, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2021-01-15 16:18:34.135792468", "sleepQuality": 89, "sleepHours": 8, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 50},
  //   {"TS_DATE": "2021-01-17 18:23:12.975310642", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 4, "didExercise": "No","exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2020-02-16 11:30:40.345678901", "sleepQuality": 87, "sleepHours": 7, "sleepMinutes": 50, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 45},
  //   {"TS_DATE": "2020-02-20 12:35:45.456789012", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 40, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2020-02-27 15:40:50.567890123", "sleepQuality": 91, "sleepHours": 8, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 55},
  //   {"TS_DATE": "2020-03-03 16:45:55.678901234", "sleepQuality": 63, "sleepHours": 5, "sleepMinutes": 25, "dailyDescription": "test", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2020-03-08 17:50:05.789012345", "sleepQuality": 85, "sleepHours": 8, "sleepMinutes": 5, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2020-03-11 18:55:10.890123456", "sleepQuality": 72, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 40},
  //   {"TS_DATE": "2020-03-19 19:00:15.901234567", "sleepQuality": 93, "sleepHours": 8, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 50},
  //   {"TS_DATE": "2020-03-23 20:05:20.012345678", "sleepQuality": 77, "sleepHours": 7, "sleepMinutes": 10, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2020-03-29 21:10:25.123456789", "sleepQuality": 82, "sleepHours": 7, "sleepMinutes": 35, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 30},
  //   {"TS_DATE": "2020-04-02 22:15:30.234567890", "sleepQuality": 90, "sleepHours": 8, "sleepMinutes": 20, "dailyDescription": "test", "stressLV": 1, "didExercise": "No", "exerciseType": "Swimming", "exerciseDuration": 30},
  //   {"TS_DATE": "2023-05-18 10:30:00.000000000", "sleepQuality": 90, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 45},
  //   {"TS_DATE": "2023-05-24 14:15:00.000000000", "sleepQuality": 80, "sleepHours": 6, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2023-06-02 16:45:00.000000000", "sleepQuality": 95, "sleepHours": 9, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 60},
  //   {"TS_DATE": "2023-06-08 09:30:00.000000000", "sleepQuality": 60, "sleepHours": 5, "sleepMinutes": 40, "dailyDescription": "test", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 30},
  //   {"TS_DATE": "2023-06-15 12:00:00.000000000", "sleepQuality": 89, "sleepHours": 8, "sleepMinutes": 10, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2023-06-21 15:00:00.000000000", "sleepQuality": 70, "sleepHours": 6, "sleepMinutes": 55, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 40},
  //   {"TS_DATE": "2023-06-28 18:00:00.000000000", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 20, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 90},
  //   {"TS_DATE": "2023-07-05 10:00:00.000000000", "sleepQuality": 75, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2020-02-04 10:20:30.123456789", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2020-02-12 14:25:35.234567890", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
  //   {"TS_DATE": "2021-01-05 10:12:35.123456789", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-01-07 12:30:15.987654321", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-01-10 14:45:05.246813579", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-01-15 16:18:34.135792468", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-01-17 18:23:12.975310642", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-01-22 20:55:43.086421753", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-02-01 08:05:59.012345678", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //   {"TS_DATE": "2021-02-04 10:25:21.987654321", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
  //
  //   {"TS_DATE": "2021-01-05 10:12:35.123456789", "sleepQuality": 75, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Tiring day at work", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 25},
  //   {"TS_DATE": "2021-01-07 12:30:15.987654321", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "Relaxed day, watched a movie", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-01-10 14:45:05.246813579", "sleepQuality": 80, "sleepHours": 6, "sleepMinutes": 15, "dailyDescription": "Spent time with friends", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 60},
  //   {"TS_DATE": "2021-01-15 16:18:34.135792468", "sleepQuality": 90, "sleepHours": 8, "sleepMinutes": 0, "dailyDescription": "Restful day, read a book", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 45},
  //   {"TS_DATE": "2021-01-17 18:23:12.975310642", "sleepQuality": 70, "sleepHours": 5, "sleepMinutes": 30, "dailyDescription": "Stressful day, deadlines at work", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-01-22 20:55:43.086421753", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "Went shopping, cooked a nice meal", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 40},
  //   {"TS_DATE": "2021-02-01 08:05:59.012345678", "sleepQuality": 95, "sleepHours": 9, "sleepMinutes": 0, "dailyDescription": "Had a good night's sleep", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 30},
  //   {"TS_DATE": "2021-02-04 10:25:21.987654321", "sleepQuality": 72, "sleepHours": 6, "sleepMinutes": 0, "dailyDescription": "Busy day running errands", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-02-12 12:15:01.246813579", "sleepQuality": 80, "sleepHours": 7, "sleepMinutes": 0, "dailyDescription": "Had a productive day at work", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 30},
  //   {"TS_DATE": "2021-02-16 14:32:45.135792468", "sleepQuality": 70, "sleepHours": 6, "sleepMinutes": 30, "dailyDescription": "Busy day, family gathering", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-02-20 16:47:38.975310642", "sleepQuality": 90, "sleepHours": 8, "sleepMinutes": 0, "dailyDescription": "Relaxing day, went for a walk", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 45},
  //   {"TS_DATE": "2021-02-27 10:30:45.123456789", "sleepQuality": 85, "sleepHours": 7, "sleepMinutes": 15, "dailyDescription": "Worked from home", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
  //   {"TS_DATE": "2021-03-03 12:15:30.987654321", "sleepQuality": 75, "sleepHours": 5, "sleepMinutes": 45, "dailyDescription": "Stressful day, deadlines approaching", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-03-08 15:45:20.246813579", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 10, "dailyDescription": "Attended a friend's birthday party", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 90},
  //   {"TS_DATE": "2021-03-11 08:30:00.000000000", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 30, "dailyDescription": "Chilled at home, watched a movie", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 50},
  //   {"TS_DATE": "2021-06-02 14:20:00.000000000", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Visited the park with family", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 40},
  //   {"TS_DATE": "2021-06-07 18:05:00.000000000", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 0, "dailyDescription": "Long day at work", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-06-12 22:15:00.000000000", "sleepQuality": 78, "sleepHours": 7, "sleepMinutes": 25, "dailyDescription": "Went shopping with friends", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 45},
  //   {"TS_DATE": "2021-06-18 08:30:00.000000000", "sleepQuality": 87, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "Read a book at the park", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 30},
  //   {"TS_DATE": "2021-06-25 14:20:00.000000000", "sleepQuality": 65, "sleepHours": 5, "sleepMinutes": 30, "dailyDescription": "Attended a conference", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-10-05 10:15:30.000000000", "sleepQuality": 85, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Worked on a project", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
  //   {"TS_DATE": "2021-10-09 15:45:20.000000000", "sleepQuality": 60, "sleepHours": 4, "sleepMinutes": 15, "dailyDescription": "Went to a concert", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 40},
  //   {"TS_DATE": "2021-10-15 18:05:00.000000000", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 10, "dailyDescription": "Spent time with family", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 50},
  //   {"TS_DATE": "2021-10-22 22:15:00.000000000", "sleepQuality": 57, "sleepHours": 4, "sleepMinutes": 45, "dailyDescription": "Busy day at work", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-10-28 11:30:45.000000000", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 35, "dailyDescription": "Went to the movies", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 90},
  //   {"TS_DATE": "2021-11-05 09:45:30.000000000", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 50, "dailyDescription": "Cooked a new recipe", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 45},
  //   {"TS_DATE": "2021-11-11 16:20:15.000000000", "sleepQuality": 75, "sleepHours": 6, "sleepMinutes": 40, "dailyDescription": "Attended a webinar", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2021-11-17 00:12:34.000000000", "sleepQuality": 89, "sleepHours": 8, "sleepMinutes": 5, "dailyDescription": "Spent time gardening", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 60},
  //   {"TS_DATE": "2021-11-23 01:23:45.000000000", "sleepQuality": 63, "sleepHours": 5, "sleepMinutes": 15, "dailyDescription": "Worked overtime", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 80},
  //   {"TS_DATE": "2023-02-02 02:34:56.000000000", "sleepQuality": 82, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Went to a museum", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 45},
  //   {"TS_DATE": "2023-02-08 03:45:57.000000000", "sleepQuality": 61, "sleepHours": 4, "sleepMinutes": 50, "dailyDescription": "Partied with friends", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2023-02-14 04:56:58.000000000", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 55, "dailyDescription": "Went hiking", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 120},
  //   {"TS_DATE": "2023-02-22 05:12:34.000000000", "sleepQuality": 95, "sleepHours": 8, "sleepMinutes": 20, "dailyDescription": "Relaxed at home", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 30},
  //   {"TS_DATE": "2023-03-05 06:23:45.000000000", "sleepQuality": 68, "sleepHours": 5, "sleepMinutes": 45, "dailyDescription": "Attended a networking event", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2023-03-10 07:34:56.000000000", "sleepQuality": 58, "sleepHours": 4, "sleepMinutes": 10, "dailyDescription": "Travelled for a work meeting", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
  //   {"TS_DATE": "2023-03-18 08:45:57.000000000", "sleepQuality": 73, "sleepHours": 6, "sleepMinutes": 35, "dailyDescription": "Went to a book club meeting", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 40},
  //   {"TS_DATE": "2023-03-27 08:30:00.000000000", "sleepQuality": 87, "sleepHours": 7, "sleepMinutes": 50, "dailyDescription": "Had a family gathering", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2023-04-01 12:00:00.000000000", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 25, "dailyDescription": "Went on a day trip to the beach", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 90},
  //   {"TS_DATE": "2023-04-06 15:45:00.000000000", "sleepQuality": 91, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "Attended a concert", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 100},
  //   {"TS_DATE": "2023-04-15 18:20:00.000000000", "sleepQuality": 63, "sleepHours": 5, "sleepMinutes": 20, "dailyDescription": "Completed a big work project", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2023-04-20 21:00:00.000000000", "sleepQuality": 69, "sleepHours": 6, "sleepMinutes": 5, "dailyDescription": "Watched a movie with friends", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 60},
  //   {"TS_DATE": "2023-04-28 09:15:00.000000000", "sleepQuality": 96, "sleepHours": 8, "sleepMinutes": 15, "dailyDescription": "Spent the day relaxing at home", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 45},
  //   {"TS_DATE": "2023-05-04 14:30:00.000000000", "sleepQuality": 79, "sleepHours": 7, "sleepMinutes": 10, "dailyDescription": "Went shopping for new clothes", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
  //   {"TS_DATE": "2023-05-11 16:45:00.000000000", "sleepQuality": 84, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Took a cooking class", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 35},
  //
  // ];
}

// widget.reformattedData.then((qResult) {
// List<Map<String, dynamic>> data = qResult;
// setState(() {
// reformattedStringHeadache = jsonEncode(data);
// });
//
// });


// String DailyAndHeadacheDataToJson() {
//   // New stuff!
//   List<Map<String, dynamic>> dailyData = [
//
//     {"TS_DATE": "2020-04-07 23:20:35.345678901", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 40},
//     {"TS_DATE": "2020-04-10 01:25:40.456789012", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2020-04-16 02:30:45.567890123", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 55},
//     {"TS_DATE": "2020-04-22 03:35:50.678901234", "sleepQuality": 68, "sleepHours": 5, "sleepMinutes": 35, "dailyDescription": "test", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 50},
//     {"TS_DATE": "2020-04-26 04:40:55.789012345", "sleepQuality": 84, "sleepHours": 8, "sleepMinutes": 10, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2021-01-05 10:12:35.123456789", "sleepQuality": 73, "sleepHours": 6, "sleepMinutes": 50, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 30},
//     {"TS_DATE": "2021-01-07 12:30:15.987654321", "sleepQuality": 95, "sleepHours": 9, "sleepMinutes": 5, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
//     {"TS_DATE": "2021-01-10 14:45:05.246813579", "sleepQuality": 80, "sleepHours": 7, "sleepMinutes": 20, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2021-01-15 16:18:34.135792468", "sleepQuality": 89, "sleepHours": 8, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 50},
//     {"TS_DATE": "2021-01-17 18:23:12.975310642", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 4, "didExercise": "No","exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2020-02-16 11:30:40.345678901", "sleepQuality": 87, "sleepHours": 7, "sleepMinutes": 50, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 45},
//     {"TS_DATE": "2020-02-20 12:35:45.456789012", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 40, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2020-02-27 15:40:50.567890123", "sleepQuality": 91, "sleepHours": 8, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 55},
//     {"TS_DATE": "2020-03-03 16:45:55.678901234", "sleepQuality": 63, "sleepHours": 5, "sleepMinutes": 25, "dailyDescription": "test", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2020-03-08 17:50:05.789012345", "sleepQuality": 85, "sleepHours": 8, "sleepMinutes": 5, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2020-03-11 18:55:10.890123456", "sleepQuality": 72, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 40},
//     {"TS_DATE": "2020-03-19 19:00:15.901234567", "sleepQuality": 93, "sleepHours": 8, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 50},
//     {"TS_DATE": "2020-03-23 20:05:20.012345678", "sleepQuality": 77, "sleepHours": 7, "sleepMinutes": 10, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2020-03-29 21:10:25.123456789", "sleepQuality": 82, "sleepHours": 7, "sleepMinutes": 35, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 30},
//     {"TS_DATE": "2020-04-02 22:15:30.234567890", "sleepQuality": 90, "sleepHours": 8, "sleepMinutes": 20, "dailyDescription": "test", "stressLV": 1, "didExercise": "No", "exerciseType": "Swimming", "exerciseDuration": 30},
//     {"TS_DATE": "2023-05-18 10:30:00.000000000", "sleepQuality": 90, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 45},
//     {"TS_DATE": "2023-05-24 14:15:00.000000000", "sleepQuality": 80, "sleepHours": 6, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2023-06-02 16:45:00.000000000", "sleepQuality": 95, "sleepHours": 9, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 60},
//     {"TS_DATE": "2023-06-08 09:30:00.000000000", "sleepQuality": 60, "sleepHours": 5, "sleepMinutes": 40, "dailyDescription": "test", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 30},
//     {"TS_DATE": "2023-06-15 12:00:00.000000000", "sleepQuality": 89, "sleepHours": 8, "sleepMinutes": 10, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2023-06-21 15:00:00.000000000", "sleepQuality": 70, "sleepHours": 6, "sleepMinutes": 55, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 40},
//     {"TS_DATE": "2023-06-28 18:00:00.000000000", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 20, "dailyDescription": "test", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 90},
//     {"TS_DATE": "2023-07-05 10:00:00.000000000", "sleepQuality": 75, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "test", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2020-02-04 10:20:30.123456789", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2020-02-12 14:25:35.234567890", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 15, "dailyDescription": "test", "stressLV": 1, "didExercise": "No", "exerciseType": "", "exerciseDuration": ""},
//     {"TS_DATE": "2021-01-05 10:12:35.123456789", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-01-07 12:30:15.987654321", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-01-10 14:45:05.246813579", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-01-15 16:18:34.135792468", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-01-17 18:23:12.975310642", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-01-22 20:55:43.086421753", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-02-01 08:05:59.012345678", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//     {"TS_DATE": "2021-02-04 10:25:21.987654321", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "test", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 35},
//
//     {"TS_DATE": "2021-01-05 10:12:35.123456789", "sleepQuality": 75, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Tiring day at work", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 25},
//     {"TS_DATE": "2021-01-07 12:30:15.987654321", "sleepQuality": 85, "sleepHours": 6, "sleepMinutes": 45, "dailyDescription": "Relaxed day, watched a movie", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-01-10 14:45:05.246813579", "sleepQuality": 80, "sleepHours": 6, "sleepMinutes": 15, "dailyDescription": "Spent time with friends", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 60},
//     {"TS_DATE": "2021-01-15 16:18:34.135792468", "sleepQuality": 90, "sleepHours": 8, "sleepMinutes": 0, "dailyDescription": "Restful day, read a book", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 45},
//     {"TS_DATE": "2021-01-17 18:23:12.975310642", "sleepQuality": 70, "sleepHours": 5, "sleepMinutes": 30, "dailyDescription": "Stressful day, deadlines at work", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-01-22 20:55:43.086421753", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "Went shopping, cooked a nice meal", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 40},
//     {"TS_DATE": "2021-02-01 08:05:59.012345678", "sleepQuality": 95, "sleepHours": 9, "sleepMinutes": 0, "dailyDescription": "Had a good night's sleep", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 30},
//     {"TS_DATE": "2021-02-04 10:25:21.987654321", "sleepQuality": 72, "sleepHours": 6, "sleepMinutes": 0, "dailyDescription": "Busy day running errands", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-02-12 12:15:01.246813579", "sleepQuality": 80, "sleepHours": 7, "sleepMinutes": 0, "dailyDescription": "Had a productive day at work", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 30},
//     {"TS_DATE": "2021-02-16 14:32:45.135792468", "sleepQuality": 70, "sleepHours": 6, "sleepMinutes": 30, "dailyDescription": "Busy day, family gathering", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-02-20 16:47:38.975310642", "sleepQuality": 90, "sleepHours": 8, "sleepMinutes": 0, "dailyDescription": "Relaxing day, went for a walk", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 45},
//     {"TS_DATE": "2021-02-27 10:30:45.123456789", "sleepQuality": 85, "sleepHours": 7, "sleepMinutes": 15, "dailyDescription": "Worked from home", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
//     {"TS_DATE": "2021-03-03 12:15:30.987654321", "sleepQuality": 75, "sleepHours": 5, "sleepMinutes": 45, "dailyDescription": "Stressful day, deadlines approaching", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-03-08 15:45:20.246813579", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 10, "dailyDescription": "Attended a friend's birthday party", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 90},
//     {"TS_DATE": "2021-03-11 08:30:00.000000000", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 30, "dailyDescription": "Chilled at home, watched a movie", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 50},
//     {"TS_DATE": "2021-06-02 14:20:00.000000000", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Visited the park with family", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 40},
//     {"TS_DATE": "2021-06-07 18:05:00.000000000", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 0, "dailyDescription": "Long day at work", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-06-12 22:15:00.000000000", "sleepQuality": 78, "sleepHours": 7, "sleepMinutes": 25, "dailyDescription": "Went shopping with friends", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 45},
//     {"TS_DATE": "2021-06-18 08:30:00.000000000", "sleepQuality": 87, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "Read a book at the park", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 30},
//     {"TS_DATE": "2021-06-25 14:20:00.000000000", "sleepQuality": 65, "sleepHours": 5, "sleepMinutes": 30, "dailyDescription": "Attended a conference", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-10-05 10:15:30.000000000", "sleepQuality": 85, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Worked on a project", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
//     {"TS_DATE": "2021-10-09 15:45:20.000000000", "sleepQuality": 60, "sleepHours": 4, "sleepMinutes": 15, "dailyDescription": "Went to a concert", "stressLV": 3, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 40},
//     {"TS_DATE": "2021-10-15 18:05:00.000000000", "sleepQuality": 92, "sleepHours": 8, "sleepMinutes": 10, "dailyDescription": "Spent time with family", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 50},
//     {"TS_DATE": "2021-10-22 22:15:00.000000000", "sleepQuality": 57, "sleepHours": 4, "sleepMinutes": 45, "dailyDescription": "Busy day at work", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-10-28 11:30:45.000000000", "sleepQuality": 76, "sleepHours": 6, "sleepMinutes": 35, "dailyDescription": "Went to the movies", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 90},
//     {"TS_DATE": "2021-11-05 09:45:30.000000000", "sleepQuality": 88, "sleepHours": 7, "sleepMinutes": 50, "dailyDescription": "Cooked a new recipe", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 45},
//     {"TS_DATE": "2021-11-11 16:20:15.000000000", "sleepQuality": 75, "sleepHours": 6, "sleepMinutes": 40, "dailyDescription": "Attended a webinar", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2021-11-17 00:12:34.000000000", "sleepQuality": 89, "sleepHours": 8, "sleepMinutes": 5, "dailyDescription": "Spent time gardening", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 60},
//     {"TS_DATE": "2021-11-23 01:23:45.000000000", "sleepQuality": 63, "sleepHours": 5, "sleepMinutes": 15, "dailyDescription": "Worked overtime", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 80},
//     {"TS_DATE": "2023-02-02 02:34:56.000000000", "sleepQuality": 82, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Went to a museum", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 45},
//     {"TS_DATE": "2023-02-08 03:45:57.000000000", "sleepQuality": 61, "sleepHours": 4, "sleepMinutes": 50, "dailyDescription": "Partied with friends", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2023-02-14 04:56:58.000000000", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 55, "dailyDescription": "Went hiking", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 120},
//     {"TS_DATE": "2023-02-22 05:12:34.000000000", "sleepQuality": 95, "sleepHours": 8, "sleepMinutes": 20, "dailyDescription": "Relaxed at home", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 30},
//     {"TS_DATE": "2023-03-05 06:23:45.000000000", "sleepQuality": 68, "sleepHours": 5, "sleepMinutes": 45, "dailyDescription": "Attended a networking event", "stressLV": 3, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2023-03-10 07:34:56.000000000", "sleepQuality": 58, "sleepHours": 4, "sleepMinutes": 10, "dailyDescription": "Travelled for a work meeting", "stressLV": 4, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 60},
//     {"TS_DATE": "2023-03-18 08:45:57.000000000", "sleepQuality": 73, "sleepHours": 6, "sleepMinutes": 35, "dailyDescription": "Went to a book club meeting", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 40},
//     {"TS_DATE": "2023-03-27 08:30:00.000000000", "sleepQuality": 87, "sleepHours": 7, "sleepMinutes": 50, "dailyDescription": "Had a family gathering", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2023-04-01 12:00:00.000000000", "sleepQuality": 78, "sleepHours": 6, "sleepMinutes": 25, "dailyDescription": "Went on a day trip to the beach", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 90},
//     {"TS_DATE": "2023-04-06 15:45:00.000000000", "sleepQuality": 91, "sleepHours": 7, "sleepMinutes": 45, "dailyDescription": "Attended a concert", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Cycling", "exerciseDuration": 100},
//     {"TS_DATE": "2023-04-15 18:20:00.000000000", "sleepQuality": 63, "sleepHours": 5, "sleepMinutes": 20, "dailyDescription": "Completed a big work project", "stressLV": 4, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2023-04-20 21:00:00.000000000", "sleepQuality": 69, "sleepHours": 6, "sleepMinutes": 5, "dailyDescription": "Watched a movie with friends", "stressLV": 2, "didExercise": "Yes", "exerciseType": "Walk", "exerciseDuration": 60},
//     {"TS_DATE": "2023-04-28 09:15:00.000000000", "sleepQuality": 96, "sleepHours": 8, "sleepMinutes": 15, "dailyDescription": "Spent the day relaxing at home", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Swimming", "exerciseDuration": 45},
//     {"TS_DATE": "2023-05-04 14:30:00.000000000", "sleepQuality": 79, "sleepHours": 7, "sleepMinutes": 10, "dailyDescription": "Went shopping for new clothes", "stressLV": 2, "didExercise": "No", "exerciseType": "", "exerciseDuration": 0},
//     {"TS_DATE": "2023-05-11 16:45:00.000000000", "sleepQuality": 84, "sleepHours": 7, "sleepMinutes": 30, "dailyDescription": "Took a cooking class", "stressLV": 1, "didExercise": "Yes", "exerciseType": "Run", "exerciseDuration": 35},
//
//   ];
//
//   // So the 1st function stuff
//   List<Map<String, dynamic>> headacheData = [
//
//     {"headacheEntryid": 86, "TS_DATE": "2023-05-18 10:30:00.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-05-17"},
//     {"headacheEntryid": 87, "TS_DATE": "2023-05-24 14:15:00.000000000", "intensityLevel": 2, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-05-23"},
//     {"headacheEntryid": 88, "TS_DATE": "2023-06-02 16:45:00.000000000", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2023-06-01"},
//     {"headacheEntryid": 89, "TS_DATE": "2023-06-08 09:30:00.000000000", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2023-06-07"},
//     {"headacheEntryid": 90, "TS_DATE": "2023-06-15 12:00:00.000000000", "intensityLevel": 2, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-06-14"},
//     {"headacheEntryid": 91, "TS_DATE": "2023-06-21 15:00:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-06-20"},
//     {"headacheEntryid": 92, "TS_DATE": "2023-06-28 18:00:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2023-06-27"},
//     {"headacheEntryid": 93, "TS_DATE": "2023-07-05 10:00:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-07-04"},
//     {"headacheEntryid": 10, "TS_DATE": "2020-02-04 10:20:30.123456789", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMS": "2020-02-03"},
//     {"headacheEntryid": 11, "TS_DATE": "2020-02-12 14:25:35.234567890", "intensityLevel": 1, "medicineName": "Ibropufen", "Partial": 1, "medicineDateMS": "2020-02-11"},
//     {"headacheEntryid": 12, "TS_DATE": "2020-02-16 11:30:40.345678901", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMS": "2020-02-15"},
//     {"headacheEntryid": 13, "TS_DATE": "2020-02-20 12:35:45.456789012", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMS": "2020-02-19"},
//     {"headacheEntryid": 14, "TS_DATE": "2020-02-27 15:40:50.567890123", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMS": "2020-02-26"},
//     {"headacheEntryid": 15, "TS_DATE": "2020-03-03 16:45:55.678901234", "intensityLevel": 1, "medicineName": "Ibropufen", "Partial": 0, "medicineDateMS": "2020-03-02"},
//     {"headacheEntryid": 16, "TS_DATE": "2020-03-08 17:50:05.789012345", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMS": "2020-03-07"},
//     {"headacheEntryid": 17, "TS_DATE": "2020-03-11 18:55:10.890123456", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMS": "2020-03-10"},
//     {"headacheEntryid": 18, "TS_DATE": "2020-03-19 19:00:15.901234567", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 0, "full": 1, "medicineDateMS": "2020-03-19"},
//     {"headacheEntryid": 19, "TS_DATE": "2020-03-23 20:05:20.012345678", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 1, "full": 0, "medicineDateMS": "2020-03-23"},
//     {"headacheEntryid": 20, "TS_DATE": "2020-03-29 21:10:25.123456789", "intensityLevel": 2, "medicineName": "Naproxen", "Partial": 0, "full": 1, "medicineDateMS": "2020-03-29"},
//     {"headacheEntryid": 21, "TS_DATE": "2020-04-02 22:15:30.234567890", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "full": 1, "medicineDateMS": "2020-04-02"},
//     {"headacheEntryid": 22, "TS_DATE": "2020-04-07 23:20:35.345678901", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 1, "full": 0, "medicineDateMS": "2020-04-07"},
//     {"headacheEntryid": 23, "TS_DATE": "2020-04-10 01:25:40.456789012", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "full": 1, "medicineDateMS": "2020-04-10"},
//     {"headacheEntryid": 24, "TS_DATE": "2020-04-16 02:30:45.567890123", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 1, "full": 0, "medicineDateMS": "2020-04-16"},
//     {"headacheEntryid": 25, "TS_DATE": "2020-04-22 03:35:50.678901234", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "full": 1, "medicineDateMS": "2020-04-22"},
//     {"headacheEntryid": 26, "TS_DATE": "2020-04-26 04:40:55.789012345", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "full": 0, "medicineDateMS": "2020-04-26"},
//     {"headacheEntryid": 27, "TS_DATE": "2021-01-05 10:12:35.123456789", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-01-04"},
//     {"headacheEntryid": 28, "TS_DATE": "2021-01-07 12:30:15.987654321", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-01-06"},
//     {"headacheEntryid": 29, "TS_DATE": "2021-01-10 14:45:05.246813579", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-01-09"},
//     {"headacheEntryid": 30, "TS_DATE": "2021-01-15 16:18:34.135792468", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-01-14"},
//     {"headacheEntryid": 31, "TS_DATE": "2021-01-17 18:23:12.975310642", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-01-16"},
//     {"headacheEntryid": 32, "TS_DATE": "2021-01-22 20:55:43.086421753", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-01-21"},
//     {"headacheEntryid": 33, "TS_DATE": "2021-02-01 08:05:59.012345678", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2021-01-31"},
//     {"headacheEntryid": 34, "TS_DATE": "2021-02-04 10:25:21.987654321", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2021-02-03"},
//     {"headacheEntryid": 35, "TS_DATE": "2021-02-12 12:15:01.246813579", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-02-11"},
//     {"headacheEntryid": 36, "TS_DATE": "2021-02-16 14:32:45.135792468", "intensityLevel": 3, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-02-15"},
//     {"headacheEntryid": 37, "TS_DATE": "2021-02-20 16:47:38.975310642", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-02-19"},
//     {"headacheEntryid": 38, "TS_DATE": "2021-02-27 10:30:45.123456789", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-02-26"},
//     {"headacheEntryid": 39, "TS_DATE": "2021-03-03 12:15:30.987654321", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 1, "medicineDateMs": "2021-03-02"},
//     {"headacheEntryid": 40, "TS_DATE": "2021-03-08 15:45:20.246813579", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-03-07"},
//     {"headacheEntryid": 41, "TS_DATE": "2021-03-11 08:30:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2021-03-19"},
//     {"headacheEntryid": 42, "TS_DATE": "2021-06-02 14:20:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-06-01"},
//     {"headacheEntryid": 43, "TS_DATE": "2021-06-07 18:05:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-06-06"},
//     {"headacheEntryid": 44, "TS_DATE": "2021-06-12 22:15:00.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-06-11"},
//     {"headacheEntryid": 45, "TS_DATE": "2021-06-18 08:30:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-06-17"},
//     {"headacheEntryid": 46, "TS_DATE": "2021-06-25 14:20:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-06-24"},
//     {"headacheEntryid": 47, "TS_DATE": "2021-10-05 10:15:30.000000000", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-10-04"},
//     {"headacheEntryid": 48, "TS_DATE": "2021-10-09 15:45:20.000000000", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2021-10-08"},
//     {"headacheEntryid": 49, "TS_DATE": "2021-10-15 18:05:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2021-10-14"},
//     {"headacheEntryid": 50, "TS_DATE": "2021-10-22 22:15:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-10-21"},
//     {"headacheEntryid": 51, "TS_DATE": "2021-10-28 11:30:45.000000000", "intensityLevel": 1, "medicineName": "Tylex", "Partial": 1, "medicineDateMs": "2021-10-27"},
//     {"headacheEntryid": 52, "TS_DATE": "2021-11-05 09:45:30.000000000", "intensityLevel": 2, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2021-11-04"},
//     {"headacheEntryid": 53, "TS_DATE": "2021-11-11 16:20:15.000000000", "intensityLevel": 1, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2021-11-10"},
//     {"headacheEntryid": 54, "TS_DATE": "2021-11-17 00:12:34.000000000", "intensityLevel": 3, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2021-11-16"},
//     {"headacheEntryid": 55, "TS_DATE": "2021-11-23 01:23:45.000000000", "intensityLevel": 2, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2021-11-22"},
//     {"headacheEntryid": 56, "TS_DATE": "2023-02-02 02:34:56.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-02-01"},
//     {"headacheEntryid": 57, "TS_DATE": "2023-02-08 03:45:57.000000000", "intensityLevel": 3, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2023-02-07"},
//     {"headacheEntryid": 58, "TS_DATE": "2023-02-14 04:56:58.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-02-13"},
//     {"headacheEntryid": 59, "TS_DATE": "2023-02-22 05:12:34.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2023-02-21"},
//     {"headacheEntryid": 60, "TS_DATE": "2023-03-05 06:23:45.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2023-03-04"},
//     {"headacheEntryid": 61, "TS_DATE": "2023-03-10 07:34:56.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-03-09"},
//     {"headacheEntryid": 62, "TS_DATE": "2023-03-18 08:45:57.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2023-03-17"},
//     {"headacheEntryid": 78, "TS_DATE": "2023-03-27 08:30:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-03-26"},
//     {"headacheEntryid": 79, "TS_DATE": "2023-04-01 12:00:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 0, "medicineDateMs": "2023-03-31"},
//     {"headacheEntryid": 80, "TS_DATE": "2023-04-06 15:45:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 1, "medicineDateMs": "2023-04-05"},
//     {"headacheEntryid": 81, "TS_DATE": "2023-04-15 18:20:00.000000000", "intensityLevel": 3, "medicineName": "Tylex", "Partial": 0, "medicineDateMs": "2023-04-14"},
//     {"headacheEntryid": 82, "TS_DATE": "2023-04-20 21:00:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 0, "medicineDateMs": "2023-04-19"},
//     {"headacheEntryid": 83, "TS_DATE": "2023-04-28 09:15:00.000000000", "intensityLevel": 1, "medicineName": "Paracetamol", "Partial": 1, "medicineDateMs": "2023-04-27"},
//     {"headacheEntryid": 84, "TS_DATE": "2023-05-04 14:30:00.000000000", "intensityLevel": 1, "medicineName": "Naproxen", "Partial": 0, "medicineDateMs": "2023-05-03"},
//     {"headacheEntryid": 85, "TS_DATE": "2023-05-11 16:45:00.000000000", "intensityLevel": 2, "medicineName": "Ibuprofen", "Partial": 1, "medicineDateMs": "2023-01-02"}
//
//   ];
//
//   List<Map<String, dynamic>> combinedData = [];
//
//   for (var daily in dailyData) {
//     for (var headache in headacheData) {
//       if (daily['TS_DATE'] == headache['TS_DATE']) {
//         Map<String, dynamic> combined = {...daily, ...headache};
//         combinedData.add(combined);
//       }
//     }
//   }
//
//   return json.encode(combinedData);
// }
