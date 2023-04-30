import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fluttertest/databasehandler/dailyForm.dart';

class DailyForm extends StatefulWidget {
  @override
  State<DailyForm> createState() => _DailyFormState();
}

class _DailyFormState extends State<DailyForm> {
  final _formKey = GlobalKey<FormState>();

  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Question: How do we store the image to db?
  double _sleepQuality = 50;
  int _hours = 0;
  int _minutes = 0;
  TextEditingController _textController = TextEditingController();
  int _stressLevel = 1;
  // So pre fill-in for _didExercise == null
  String? _didExercise;
  String _exerciseType = '';
  String _exerciseDuration = '';

  // For testing
  String? userid = "3";

  void _submitForm() async{
    // This is where you would handle the form submission.
    // You can access the values of the form inputs using the _sleepQuality,
    // _hours, _minutes, and _image variables.

    // For sleep quality, should we round it at the end?
    // print("Sleep quality:" +_sleepQuality.toString());
    //
    // print("Sleep hours:" +_hours.toString());
    // print("Sleep minutes:" +_minutes.toString());
    // // How do we store the img?
    //
    // print("WDYD:" +_textController.text);
    // print("Stress lv:" +_stressLevel.toString());
    // print("did exercise:" + _didExercise.toString());
    // print("exercise type:" + _exerciseType);
    //
    // // What is the input format expected for this?
    // print("exercise dura:" + _exerciseDuration);

    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    int nowInSecondsSinceEpoch = (ms / 1000).round();

    var today_ts = todayDate.millisecondsSinceEpoch;
    int TS_DATE = (today_ts / 1000).round();

    // For testing
    // print(userid);
    // var testDate = DateTime(2023,5,2);
    // nowInSecondsSinceEpoch = (testDate.millisecondsSinceEpoch/1000).round() + 4;
    // TS_DATE = (testDate.millisecondsSinceEpoch/1000).round();

    await DailyFormDBHelper.instance.add(
        DailyFormInput(
          userid:userid,
          TS:nowInSecondsSinceEpoch,
          TS_DATE: TS_DATE,
          sleepQuality:_sleepQuality,
          sleepHours:_hours,
          sleepMinutes:_minutes,
          dailyDescription:_textController.text,
          stressLV: _stressLevel,
          didExercise: _didExercise,
          exerciseType: _exerciseType,
          exerciseDuration: _exerciseDuration)
    );

    // Clear text
    setState(() {
      _textController.clear();
    });

    // DailyFormDBHelper.instance.fetchValidEntriesForUser("2");
    // DailyFormDBHelper.instance.fetchValidEntriesForUser("3");
    // DailyFormDBHelper.instance.fetchLatestDailyFormByUserId("3");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How did you sleep?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Sleep quality:',
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Slider(
                    value: _sleepQuality,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        _sleepQuality = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Sleep duration:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _hours = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'H',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                SizedBox(
                  width: 70.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _minutes = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'M',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'What did you eat?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: getImage,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(color: Colors.black),
                          ),
                          child: _image == null
                              ? Icon(Icons.image)
                              : Image.file(_image!),
                        ),
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'What happened today?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            TextField(
              maxLength: 50,
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter your text here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stress level:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Slider(
                    value: _stressLevel.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    onChanged: (double value) {
                      setState(() {
                        _stressLevel = value.round();
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  _stressLevel.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Did you exercise today?'),
                SizedBox(width: 10),
                Radio(
                  value: 'Yes',
                  groupValue: _didExercise,
                  onChanged: (value) {
                    setState(() {
                      _didExercise = value;
                      if (value == 'No') {
                        _exerciseType = '';
                        _exerciseDuration = '';
                      }
                    });
                  },
                ),
                Text('Yes'),
                SizedBox(width: 10),
                Radio(
                  value: 'No',
                  groupValue: _didExercise,
                  onChanged: (value) {
                    setState(() {
                      _didExercise = value;
                      if (value == 'No') {
                        _exerciseType = '';
                        _exerciseDuration = '';
                      }
                    });
                  },
                ),
                Text('No'),
              ],
            ),
            if (_didExercise == 'Yes')
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Exercise type',
                    ),
                    onChanged: (value) {
                      _exerciseType = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Exercise duration',
                    ),
                    onChanged: (value) {
                      _exerciseDuration = value;
                    },
                  ),
                ],
              ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}