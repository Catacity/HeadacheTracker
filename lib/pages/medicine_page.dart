import 'dart:ffi';

import 'package:flutter/material.dart';

DateTime now = DateTime.now();
DateTime todayDate = DateTime(now.year,now.month,now.day);
TimeOfDay TODNow = TimeOfDay(hour: now.hour, minute: now.minute);
List<Color> colors = [Colors.lightBlueAccent, Colors.blueAccent];

class MedicineFormMenu extends StatefulWidget {
  @override
  State<MedicineFormMenu> createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineFormMenu> {
  TextEditingController _medicineTextController = TextEditingController();

  String _medicine = "";
  DateTime _MedicineDate = todayDate;
  TimeOfDay _TODMedicine = TODNow;

  // Meaning the partial / full mutually exclusive buttons are clickable
  bool _ispartial = false;
  bool _isfull = false;

  void initState() {
    // Ctor
    super.initState();

    // Initializing the controllers with the default values
    _medicineTextController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    // Dtor
    _medicineTextController.dispose();

    super.dispose();
  }

  AppBar buildAppBar(){
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

        backgroundColor: Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: Container(
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
                                  Icons.medication,
                                  color: Colors.redAccent,
                                  size: 25.0,
                                ),
                              ),
                              Container(
                                child: Text("Name of medicine taken?",
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
                                    setState(() => _MedicineDate = todayDate);
                                  },
                                  icon: Icon(
                                    Icons.clear,
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
                              // Wrapping the text box with a fixed height and width is necessary
                              width: 340,
                              height: 40,
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                              child: TextField(
                                controller: _medicineTextController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Please list out the medicine taken..'
                                ),
                              ),
                            ),
                          ]
                        ),
                      ]
                  ),
                )
              ]

            ),

            // Row 3
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 350,
                    child: SizedBox(
                      height: 100,
                      child: Container(
                        decoration:BoxDecoration(
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
                                        Icons.percent_outlined,
                                        color: Colors.orange,
                                        size: 25.0,
                                      ),
                                    ),
                                    Container(
                                      child: Text("Pain relief?",
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
                                                  "Partial relief:.. \n\nFull relief:.. \n\n",
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
                                          Icons.question_mark_outlined,
                                          size: 25.0,
                                        ),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      width: 350,
                                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
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
                                                    setState(() => _ispartial = true);
                                                    setState(() => _isfull = false);
                                                  },
                                                  child: Text("Partial",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'ComicNeue',
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(colors[(_ispartial)? 1 : 0]),
                                                  )
                                              ),
                                            ),

                                            Container(
                                              // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() => _ispartial = false);
                                                    setState(() => _isfull = true);
                                                  },
                                                  child: Text("  Full  ",
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'ComicNeue',
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(colors[(_isfull)? 1 : 0]),
                                                  )
                                              ),
                                            ),
                                          ]
                                      ),


                                    ),
                                  ]
                              ),
                            ]
                        ),
                      )
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
                                      setState(() => _MedicineDate = todayDate);
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
                                child: Text("${_MedicineDate.year}/${_MedicineDate.month}/${_MedicineDate.day}",
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
                                      initialDate: _MedicineDate,
                                      firstDate: DateTime(2010),  // Is this a reasonable first available year?
                                      lastDate: todayDate,
                                    );

                                    // if the function returns null, it means "Cancel" has been pressed
                                    if (newDate != null){
                                      setState(() => _MedicineDate = newDate);
                                    }
                                  },
                                  child: Text('Select Date'),
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),

                  )
                ]
            ),

            // Row 5
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
                              setState(() => _TODMedicine = TODNow);
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
                          child: Text("${_TODMedicine.hour}:${_TODMedicine.minute}",
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
                                initialTime: _TODMedicine,
                              );

                              // if the function returns null, it means "Cancel" has been pressed
                              if (newTime != null){
                                setState(() => _TODMedicine = newTime);
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

            // Row 6
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
                                  // Confirm... Need to pass value back to the headache form
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
                                  // Cancel
                                  Navigator.of(context).pop();
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
        ]
      )
     )
    );
  }
}

