import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fluttertest/databasehandler/dailyForm.dart';

Future<Map<String, dynamic>>fetchData(String userID,DateTime date) async {
  // Fetch relevant record from DB
  // DailyFormDBHelper.instance.fetchTableData();
  var Qresult = await DailyFormDBHelper.instance.fetchLatestDailyFormByUserIdAndDate(userID, date);
  // print(Qresult);
  Map<String, dynamic> Result = Qresult ?? {};

  return Result;
}

class DetailedInfoPage extends StatefulWidget {
  final String userID;
  final DateTime date;
  final Future<Map<String, dynamic>?> queryResult;

  DetailedInfoPage({required Key key, required this.userID, required this.date, required this.queryResult}) : super(key: key);

  factory DetailedInfoPage.async({required Key key, required String userID, required DateTime date}) {
    return DetailedInfoPage(
      key: key,
      userID: userID,
      date: date,
      queryResult: fetchData(userID, date),
    );
  }

  @override
  _DetailedInfoPageState createState() => _DetailedInfoPageState();
}

class _DetailedInfoPageState extends State<DetailedInfoPage> {
  Map<String, dynamic>? result;

  @override
  void initState() {
    super.initState();
    widget.queryResult.then((qResult) {
      setState(() {
        result = qResult;
      });
    });
  }

  _gotoHeadacheFormInfo() {
    //

  }

  AppBar buildAppBar() {
    return AppBar(
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
                color: Colors.black,
              ),
            ),

            Container(
              child: Text("Hi Kimmie!",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'handrawn',
                  color: Colors.black,
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
                color: Colors.black,
              ),
            ),


          ],
        ),

        backgroundColor: Colors.lightBlueAccent
    );
  }

  String intToStr(int input) {
    if (input == -1) {
      return "/";
    }
    else {
      return input.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double sleepQ = result?['sleepQuality'] ?? -1;
    String sleepQualityText = intToStr(sleepQ.round());

    int sleepH = result?['sleepHours'] ?? -1;
    String sleepHText = intToStr(sleepH);

    int sleepMin = result?['sleepMinutes'] ?? -1;
    String sleepMinText = intToStr(sleepMin);

    String dailyDesc = result?['dailyDescription'] ?? "";

    int stressLv = result?['stressLV'] ?? -1;
    String stressLvText = intToStr(stressLv);

    String didExercise = result?['didExercise'] ?? "NA";
    String exerciseType = result?['exerciseType'] ?? "";
    String exerciseDuration = result?['exerciseDuration'] ?? "";

    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child:Text(
                  'Daily form record for ${DateFormat('MMMM d, y',).format(
                      widget.date)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'handrawn',
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),),
                Expanded(child:
                  Column(
                    children:[
                      Row(
                        children: [
                          Text(
                            'Your sleep quality: ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                          Text(
                            '${sleepQualityText}',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:10),
                      Row(
                        children: [
                          Text(
                            'Sleep duration: ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${sleepHText} H ${sleepMinText} M',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
                Expanded(child:Row(
                  children: [
                    Text(
                      'Food eaten: Todo!',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    // Expanded(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: getImage,
                    //         child: Container(
                    //           height: 50,
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //             color: Colors.grey.shade300,
                    //             border: Border.all(color: Colors.black),
                    //           ),
                    //           child: _image == null
                    //               ? Icon(Icons.image)
                    //               : Image.file(_image!),
                    //         ),
                    //       ),
                    //       SizedBox(height: 10),
                    //
                    //     ],
                    //   ),
                    // ),
                  ],
                ),),
                Expanded(child: Row(
                  children: [
                    Text(
                      'What happened that day:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),),
                SizedBox(width: 5),
                Text(
                  '${dailyDesc}',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(child: Row(
                  children: [
                    Text('Exercise information:',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                ),
                Expanded(child:
                Row(
                    children: [
                      if (didExercise == "Yes")
                        Column(
                          children: [
                            Row(
                              children:[
                                Text('Exercise type: ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${exerciseType}',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children:[
                                Text('Duration: ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${exerciseDuration}',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            Text('  You did not do any exercise...',
                              style: TextStyle(
                                fontSize: 22,
                              ),),
                            SizedBox(width: 10),
                          ],
                        )
                    ]
                )
                  ,
                ),
                ElevatedButton(
                  onPressed: _gotoHeadacheFormInfo,
                  child: Text('Headache Form Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

