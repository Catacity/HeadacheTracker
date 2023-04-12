import 'package:flutter/material.dart';

class HeadacheFormMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.lightBlueAccent
      ),

      // Row 1
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
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

          //  Row 3
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

          // Row 4
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
