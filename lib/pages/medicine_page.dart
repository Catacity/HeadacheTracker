import 'package:flutter/material.dart';

DateTime now = DateTime.now();
DateTime todayDate = DateTime(now.year,now.month,now.day);
TimeOfDay TODNow = TimeOfDay(hour: now.hour, minute: now.minute);

class MedicineFormMenu extends StatefulWidget {
  @override
  State<MedicineFormMenu> createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineFormMenu> {
  TextEditingController _medicineTextController = TextEditingController();

  String _medicine = "";
  DateTime _MedicineDate = todayDate;
  TimeOfDay _TODMedicine = TODNow;

  @override
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Container(
                        //       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        //       child:
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        //         child: TextFormField(
                        //           decoration: const InputDecoration(
                        //             border: UnderlineInputBorder(),
                        //             labelText: 'Please type in the medicine you have taken..'
                        //           ),
                        //         ),
                        //       ),
                        //       ),
                        //     ]
                        // ),
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
        ]
      )
     )
    );
  }
}

