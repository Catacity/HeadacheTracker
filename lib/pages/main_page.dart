import 'package:flutter/material.dart';

DateTime now = DateTime.now();
DateTime todayDate = DateTime(now.year,now.month,now.day);
TimeOfDay TODNow = TimeOfDay(hour: now.hour, minute: now.minute);

class HeadacheFormMenu extends StatefulWidget {
  @override
  State<HeadacheFormMenu> createState() => _HeadacheFormState();
}

class _HeadacheFormState extends State<HeadacheFormMenu> {
  // Text field controller:
  TextEditingController _otherSymptomsTextController = TextEditingController();

  DateTime _date = todayDate;
  TimeOfDay _TODHeadache = TODNow;

  var intensityRange = ['Mild','Moderate','Strong','Intense'];
  int _intensityLevel = 0;

  String? _hasOtherSymptoms;
  String _SymptomsDescription= '';

  DateTime _MedicineDate = todayDate;
  TimeOfDay _TODMedicine = TODNow;

  void _submitHeadacheForm() {
    // Form submission.
    // You can access the values of the form inputs using the _sleepQuality,
    // _hours, _minutes, and _image variables.
  }

  @override
  void initState(){
    super.initState();

    // Initializing the controllers with the default values
    _otherSymptomsTextController = TextEditingController(text: "");
    // _medicineDateTextController = TextEditingController(text: );
  }

  @override
  void dispose() {
    // Dtor
    _otherSymptomsTextController.dispose();

    super.dispose();
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
                              child: Text('Select Date'),
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
                              // Impletement goto page here!
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
                              // Impletement goto page here!
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
                                // Confirm...
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
