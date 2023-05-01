import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fluttertest/databasehandler/headacheForm.dart';

Future<Map<String, dynamic>>fetchData(String userID,DateTime date) async {
  // Fetch relevant record from DB
  // HeadacheFormDBHelper.instance.fetchTableData();
  var Qresult = await HeadacheFormDBHelper.instance.fetchLatestHeadacheFormByUserIdAndDate(userID, date);
  // print(Qresult);
  Map<String, dynamic> Result = Qresult ?? {};

  return Result;
}

Future<List<Map<String, dynamic>>> fetchSymptomData(Future<int> id) async {
  // Fetch relevant record from DB
  // SymptomDBHelper.instance.fetchTableData();
  int entryID = await id;

  List<Map<String, dynamic>> Result = [];

  if (entryID != -1){
    List<Map<String, dynamic>> Qresult = await SymptomDBHelper.instance.getEntries(entryID);
    print(Qresult);
    List<Map<String, dynamic>> Result = Qresult ?? [];
  }

  return Result;
}

Future<int> getEntryID(Future<Map<String, dynamic>?> queryResult) async {
  Map<String, dynamic> result = await queryResult ?? {};
  if (result.isNotEmpty) {
    return result?['headacheEntryid'] ?? -1;
  }

  return -1;
}

class HeadacheInfoPage extends StatefulWidget {
  final String userID;
  final DateTime date;
  final Future<Map<String, dynamic>?> headacheQueryResult;
  final Future<List<Map<String, dynamic>>?> headacheSymptomResult;
  HeadacheInfoPage({required Key key, required this.userID, required this.date, required this.headacheQueryResult,required this.headacheSymptomResult}) : super(key: key);

  factory HeadacheInfoPage.async({required Key key, required String userID, required DateTime date}) {
    Future<Map<String, dynamic>> queryResult = fetchData(userID, date);
    Future<int> firstEntry = getEntryID(queryResult);

    return HeadacheInfoPage(
      key: key,
      userID: userID,
      date: date,
      headacheQueryResult: queryResult,
      headacheSymptomResult: fetchSymptomData(firstEntry),
    );
  }

  @override
  _HeadacheInfoPageState createState() => _HeadacheInfoPageState();
}

class _HeadacheInfoPageState extends State<HeadacheInfoPage> {
  Map<String, dynamic>? headacheQueryResult;
  List<Map<String, dynamic>>? headacheSymptomResult;

  @override
  void initState() {
    super.initState();
    // deFuture the furure lists/ maps
    widget.headacheQueryResult.then((qResult) {
      setState(() {
        headacheQueryResult = qResult;
      });
    });

    widget.headacheSymptomResult.then((qResult) {
      setState(() {
        headacheSymptomResult = qResult;
      });
    });

  }

  _returnToDailyFormInfo() {
    Navigator.of(context).pop();
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

  String timeInMinToStr(int input){
    // ~/ : int div
    String hour = (input ~/ 60).toString();
    String minute = (input % 60).toString();

    return hour + " H " + minute + " M";
  }

  List<String> medicineTexts(Map<String, dynamic>? headacheQueryResult){
    String medName = headacheQueryResult?['medicineName'] ?? "";
    String reliefTypeText = "/";
    String dateText = "/";
    String timeConsumedText= "/";

    if (medName != "") {
      int PartialFlag = headacheQueryResult?['Partial'] ?? 0;
      int FullFlag = headacheQueryResult?['Full'] ?? 0;
      if (PartialFlag == 1) {
        reliefTypeText = "Partial";
      }
      if (FullFlag == 1) {
        reliefTypeText = "Full";
      }

      int medicineDateMS = headacheQueryResult?['medicineDateMS'] ?? 0;
      if (medicineDateMS > 0) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(medicineDateMS);
        dateText = DateFormat('MMMM d, y',).format(date);
        int TODMEDMinSinceMidnight = headacheQueryResult?['TODMEDMinSinceMidnight'] ??
            0;
        timeConsumedText = timeInMinToStr(TODMEDMinSinceMidnight);
      }
    }

    return [medName,reliefTypeText,dateText,timeConsumedText];
  }

  @override
  Widget build(BuildContext context) {
    var intensityRange = ['Mild','Moderate','Strong','Intense','/'];

    int TODMinSinceMidnight = headacheQueryResult?['TODMinSinceMidnight'] ?? 0;
    String WhenHappenedText = timeInMinToStr(TODMinSinceMidnight);
    int intensityLV = headacheQueryResult?['intensityLevel'] ?? 4;
    String intensityText = intensityRange[intensityLV];

    // Todo: Other symptoms

    var medText = medicineTexts(headacheQueryResult);

    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Expanded(child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                    Expanded(
                      flex: 1,
                      child:Text(
                        'Headache form record for ${DateFormat('MMMM d, y',).format(
                            widget.date)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'handrawn',
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),),
                    Expanded(
                      flex: 1,
                      child:
                      Row(
                        children: [
                          Text(
                            'Period of the day: ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${WhenHappenedText}',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            'Intensity: ${intensityText}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),),
                    Expanded(
                      flex: 2,
                      child:Row(
                        children: [
                          Text(
                            'Other Symptoms: Todo!',
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
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text('Medicine information:',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),),
                    Expanded(
                      flex : 3,
                      child:
                      Row(
                          children: [
                            if (medText[0] != "")
                              Column(
                                children: [
                                  Row(
                                    children:[
                                      Text('  Medicine name: ',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${medText[0]}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children:[
                                      Text('    Pain Relief: ',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${medText[1]}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children:[
                                      Text('      Date consumed: ',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${medText[2]}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children:[
                                      Text('      Time consumed: ',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${medText[3]}',
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
                                  Text('  You did not use any medicine!',
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
                  onPressed: _returnToDailyFormInfo,
                  child: Text('Daily Form Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  ],
                ),
            ),
          )
        )
    );
  }
}

