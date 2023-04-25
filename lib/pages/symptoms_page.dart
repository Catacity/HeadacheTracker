import 'dart:ffi';

import 'package:flutter/material.dart';

DateTime now = DateTime.now();
DateTime todayDate = DateTime(now.year,now.month,now.day);
TimeOfDay TODNow = TimeOfDay(hour: now.hour, minute: now.minute);
List<Color> colors = [Colors.lightBlueAccent, Colors.blueAccent];

class SymptomFormMenu extends StatefulWidget {
  @override
  State<SymptomFormMenu> createState() => _SymptomFormState();
}

class _SymptomFormState extends State<SymptomFormMenu> {
  // Storing controllers
  List<TextEditingController> _controllers = [];
  // Storing fields generated
  List<TextField> _fields = [];

  @override
  void dispose() {
    // Dtor
    if (_controllers.isNotEmpty) {
      for (final controller in _controllers) {
        // Disposing all controllers generated
        controller.dispose();
      }
    }
    super.dispose();
  }

  // Generate text box button
  Widget _addTile() {
    return IconButton(
      onPressed: () {
        // Fix it to 6 max atm because the screen only fits 6...
        if ((_fields.length) < 6){
          final controller = TextEditingController();
          // Generate a text field
          final field = TextField(
            // Linking the controller we just created to this text field
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Symptom ${_controllers.length + 1}",
            ),
          );

          setState(() {
          // Update the lists
          _controllers.add(controller);
          _fields.add(field);
          });
        }

      },
        icon: Icon(
          Icons.add,
          size: 25.0,
        ),
      color: Colors.grey,
    );
  }

  Widget _listView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(10)
          ),
          color: Colors.white
      ),
      width: 350,
      height:420,
      child:ListView.builder(
        itemCount: _fields.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            child: _fields[index],
          );
        },
      )
    );
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
                          // height: 50,
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
                                        child: _addTile(),
                                      ),
                                    ]

                                ),
                              ]
                          ),
                        )
                      ]

                  ),

                  _listView(),

                  // Row 3
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
                                        // 1. Prepare String array to pass back to headache form:
                                        List<String> result = [];
                                        for (int i = 0; i < _controllers.length; i++){
                                          result.add(_controllers[i].text);
                                        }

                                        // 2. Pass value back
                                        Navigator.of(context).pop(result);
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

