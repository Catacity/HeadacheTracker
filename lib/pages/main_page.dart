import 'package:flutter/material.dart';
import 'package:fluttertest/pages/symptoms_page.dart';
import 'package:fluttertest/pages/medicine_page.dart';

import 'package:fluttertest/databasehandler/headacheForm.dart';

DateTime now = DateTime.now();
DateTime todayDate = DateTime(now.year,now.month,now.day);
TimeOfDay TODNow = TimeOfDay(hour: now.hour, minute: now.minute);

class HeadacheFormMenu extends StatefulWidget {
  @override
  State<HeadacheFormMenu> createState() => _HeadacheFormState();
}

class _HeadacheFormState extends State<HeadacheFormMenu> {
  DateTime _date = todayDate;
  TimeOfDay _TODHeadache = TODNow;

  var intensityRange = ['Mild','Moderate','Strong','Intense'];
  var pages = [
    SymptomFormMenu(),
    MedicineFormMenu()
  ];
  // 0: Mild, 1: Moderate, 2: Strong, 3: Intense
  int _intensityLevel = 0;

  // Symptom page
  List<String>? _symptomList;

  // Medicine page
  String? _medicineName;
  bool? _ispartial;
  bool? _isfull;
  DateTime? _MedicineDate;
  TimeOfDay? _TODMedicine;

  // For testing
  String? userid = "3";

  void _submitHeadacheForm() async {
    // Form submission
    int dateMS = _date.millisecondsSinceEpoch;
    int dateInSecondsSinceEpoch = (dateMS / 1000).round();

    int TODMinSinceMidnight = _TODHeadache.hour * 60 + _TODHeadache.minute;

    bool isPartial = _ispartial ?? false;
    bool isFull = _isfull?? false;

    int Partial = isPartial ? 1 : 0;
    int Full =  isFull ? 1 : 0;

    // If it would have been null convert to 0 / epoch instead -> signifiying that the value is nulled
    DateTime medDateTime = _MedicineDate ?? DateTime.fromMillisecondsSinceEpoch(0);
    int medicineDateMS = medDateTime.millisecondsSinceEpoch;

    // Whether TODMEDMinSinceMidnight is valid depends on medicineDateMS
    TimeOfDay TODMED =  _TODMedicine ?? TimeOfDay(hour: 0, minute: 0);
    int TODMEDMinSinceMidnight = TODMED.hour * 60 + TODMED.minute;

    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    int nowInSecondsSinceEpoch = (ms / 1000).round();

    var today_ts = todayDate.millisecondsSinceEpoch;
    int TS_DATE = (today_ts / 1000).round();
    // print(dateMS);
    // print(TODMinSinceMidnight);
    //
    // print(_intensityLevel);
    //
    // print(_symptomList);
    //
    // // List<dynamic> result = [_medicine,_ispartial,_isfull,_MedicineDate,_TODMedicine];
    // print(_medicineName);
    // print(_ispartial);
    // print(_isfull);
    // print(_MedicineDate);
    // print(_TODMedicine);

    // print(userid);
    // HeadacheFormDBHelper.instance.rmDatabase();

    // For testing
    DateTime testDate = DateTime(2023,4,30);
    today_ts = testDate.millisecondsSinceEpoch;
    TS_DATE = (today_ts / 1000).round();

    await HeadacheFormDBHelper.instance.add(
        HeadacheFormInput(
            userid:userid,
            TS:nowInSecondsSinceEpoch,
            TS_DATE: TS_DATE,
            dateInSecondsSinceEpoch:dateInSecondsSinceEpoch,
            TODMinSinceMidnight:TODMinSinceMidnight,
            intensityLevel:_intensityLevel,
            medicineName:_medicineName,
            Partial: Partial,
            Full: Full,
            medicineDateMS: medicineDateMS,
            TODMEDMinSinceMidnight: TODMEDMinSinceMidnight)
    );

    List<dynamic>result = await HeadacheFormDBHelper.instance.fetchTableData();
    int entryID = result[0]['headacheEntryid'];
    // HeadacheFormDBHelper.instance.fetchLatestHeadacheFormByUserId("2");
    // HeadacheFormDBHelper.instance.fetchLatestHeadacheFormByUserId("2");
    List<String> Symptoms = _symptomList ?? [];
    if(Symptoms.length > 0){
      for (int i = 0; i < Symptoms.length ; i++){
        await SymptomDBHelper.instance.add(
            HeadacheFormSymptom(
                headacheEntryid: entryID,
                TS:nowInSecondsSinceEpoch,
                symptom:Symptoms[i],
            )
        );
      }
    }

    // HeadacheFormDBHelper.instance.fetchLatestHeadacheFormByUserId("3");
    // HeadacheFormDBHelper.instance.fetchLatestHeadacheFormByUserIdAndDate("3", todayDate);
    // HeadacheFormDBHelper.instance.fetchLatestHeadacheFormByUserIdAndDate("3", testDate);
    // SymptomDBHelper.instance.getEntries(29);


  }




  void _navigateToNextScreen(BuildContext context,int pageIdx) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => pages[pageIdx]));

    if (pageIdx == 0){
      // Received input from Symptom form:
      setState(() {
        _symptomList = result;
      });
    }
    else{
      // Received input from Headache form:
      // Output Structure: [_medicine,_ispartial,_isfull,_MedicineDate,_TODMedicine]
      List<dynamic> resultList = result;

      setState(() {
        _medicineName = resultList[0];
        _ispartial = resultList[1];
        _isfull = resultList[2];
        _MedicineDate = resultList[3];
        _TODMedicine = resultList[4];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.lightBlueAccent
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Row 1
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Describe your headache",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'handrawn',
                  ),
                ),
              ]
          ),

          // Row 2
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                child: Text("What was the date?",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ComicNeue',
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    // Reset date
                                    now = DateTime.now();
                                    todayDate = DateTime(now.year,now.month,now.day);
                                    setState(() => _date = todayDate);
                                  },
                                  icon: Icon(
                                    Icons.loop,
                                    size: 25.0,
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                            ]
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                child: Text("${_date.year}/${_date.month}/${_date.day}",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'ComicNeue',
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: _date,
                                        firstDate: DateTime(2010),  // Is this a reasonable first available year?
                                        lastDate: todayDate,
                                      );

                                      // if the function returns null, it means "Cancel" has been pressed
                                      if (newDate != null){
                                        setState(() => _date = newDate);
                                      }
                                    },
                                      child: Text('Select Date'),
                                  ),
                                ),
                            ],
                        ),
                      ]

                  ),
                ),
              ]
          ),

          //  Row 3
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            child: Icon(
                              Icons.timelapse_rounded,
                              color: Colors.purpleAccent,
                              size: 25.0,
                            ),
                          ),
                          Container(
                              child: Text("Period of the day?",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ComicNeue',
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  // Reset date
                                  now = DateTime.now();
                                  TODNow = TimeOfDay(hour: now.hour, minute: now.minute);
                                  setState(() => _TODHeadache = TODNow);
                                },
                                icon: Icon(
                                  Icons.loop,
                                  size: 25.0,
                                ),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            child: Text("${_TODHeadache.hour}:${_TODHeadache.minute}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'ComicNeue',
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            child: ElevatedButton(
                              onPressed: () async{
                                TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: _TODHeadache,
                                );

                                // if the function returns null, it means "Cancel" has been pressed
                                if (newTime != null){
                                  setState(() => _TODHeadache = newTime);
                                }
                              },
                              child: Text('Select Time'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
          ),

          // Row 4
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                child: Icon(
                                  Icons.speed_sharp,
                                  color: Colors.amber,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                child: Text("Intensity?",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ComicNeue',
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Headache Levels"),
                                        content: Text(
                                            "Mild means .. \n\nModerate means .. \n\nStrong means .. \n\nIntense means ..",
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("OK"),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ],
                                      )
                                    );
                                  },
                                  icon: Icon(
                                    Icons.question_mark,
                                    size: 25.0,
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                            ]
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:
                                Slider(
                                  value: _intensityLevel.toDouble(),
                                  max: 3,
                                  divisions: 4,
                                  label: intensityRange[_intensityLevel.round()],
                                  onChanged: (double value) {
                                    setState(() {
                                      _intensityLevel = value.toInt();
                                    });
                                  },
                                )
                            )
                          ]
                        ),
                      ],
                  )

                ),
              ]
          ),

          // Row 5
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: Colors.white
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          child: Icon(
                            Icons.health_and_safety_outlined,
                            color: Colors.lightGreen,
                            size: 25.0,
                          ),
                        ),
                        Container(
                          child: Text("Any other symptoms?",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ComicNeue',
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              // Goto symptoms page form, retrieve filled in data
                              _navigateToNextScreen(context,0);
                            },
                            icon: Icon(
                              Icons.add,
                              size: 25.0,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ]
                  ),
                ),
              ]
          ),

          //  Row 6
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: Colors.white
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          child: Icon(
                            Icons.medication,
                            color: Colors.red,
                            size: 25.0,
                          ),
                        ),
                        Container(
                          child: Text("Did you take any medicine?",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ComicNeue',
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              // Goto medicine page
                              _navigateToNextScreen(context,1);
                            },
                            icon: Icon(
                              Icons.add,
                              size: 25.0,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ]
                  ),
                ),
              ]
          ),
          //
          //  Row 7
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: Colors.transparent
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          child: ElevatedButton(
                              onPressed: () {
                                // Confirm...
                                _submitHeadacheForm();
                              },
                              child: Text("Confirm",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ComicNeue',
                                    color: Colors.black
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreenAccent),
                              )
                          ),
                        ),

                        Container(
                          // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          child: ElevatedButton(
                              onPressed: () {
                                // Cancel...
                              },
                              child: Text("Cancel",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ComicNeue',
                                    color: Colors.black
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                              )
                          ),
                        ),
                      ]
                  ),


                ),
              ]
          ),

        ],
      ),
    );
  }
}
