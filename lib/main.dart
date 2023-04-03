import 'package:flutter/material.dart';

void main() {
  // const MyApp() is the root widget of our app (Widgets are just classes)
  // Note: Widget functions all start with CAPITAL letters

  // We are nesting widgets -> widget tree!
  runApp(MaterialApp(
    // Scaffold widget:
    //  Allows us to implement basic layout for our app
    home: HeadacheFormMenu(),
  ));
}

// Enables Hot Reload
class HeadacheFormMenu extends StatelessWidget{
  // State of the widget cannot change overtime
  // vs Stateful widget (with changing data overtime)

  // Overriding ancestor's build()
  @override
  Widget build(BuildContext context){
    return Scaffold(

        appBar: AppBar(
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
          // Text("Headache Form"),
            // centerTitle: true,
            backgroundColor: Colors.white
        ),

        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.lightBlueAccent, Colors.blueAccent])
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

                //  Row 5
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
        ),
      );
  }
}

// Cool reference codes:

// child: Scaffold(
//   // By defaut, Scaffold background is white
//     backgroundColor: Colors.transparent,
//     body: Center(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//         color: Colors.white,
//         child : Text("Hello"),
//       ),

// Center(
//   // Child : child property
//   // child: Text(
//   //   "Hello world!",
//   //   style: TextStyle(
//   //     fontSize: 45.0,
//   //     fontWeight: FontWeight.bold,
//   //     color: Colors.amber,
//   //     // To add a font, go to pubspecs.yaml!
//   //     fontFamily: 'handrawn',
//   //   ),
//   // ),
//   // child: Image.asset("assets/tuturu.jpg"),
//   // child: Icon(
//   //     Icons.access_alarm_rounded,
//   //     color: Colors.lightBlue,
//   //     size: 150.0,
//   // ),
//   // child: ElevatedButton.icon(
//   //   onPressed: () {
//   //     print("Good morning");
//   //   },
//   //     icon: Icon(
//   //       Icons.add
//   //     ),
//   //   label: Text("Click mii"),
//   //   style: ButtonStyle(
//   //     backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
//   //   )
//   // ),
//   // child: IconButton(
//   //   onPressed: () {},
//   //   icon: Icon(Icons.add),
//   //   color: Colors.grey,
//   // )
// ),
