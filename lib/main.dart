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
            title: Text("Headache Form"),
            centerTitle: true,
            backgroundColor: Colors.white
        ),

        body:
        Center(
          // Child : child property
          // child: Text(
          //   "Hello world!",
          //   style: TextStyle(
          //     fontSize: 45.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.amber,
          //     // To add a font, go to pubspecs.yaml!
          //     fontFamily: 'handrawn',
          //   ),
          // ),
          child: Image.asset("assets/tuturu.jpg"),
          // child: Icon(
          //     Icons.access_alarm_rounded,
          //     color: Colors.lightBlue,
          //     size: 150.0,
          // ),
          // child: ElevatedButton.icon(
          //   onPressed: () {
          //     print("Good morning");
          //   },
          //     icon: Icon(
          //       Icons.add
          //     ),
          //   label: Text("Click mii"),
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          //   )
          // ),
          // child: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.add),
          //   color: Colors.grey,
          // )
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Text("Click"),
          backgroundColor:Colors.red,
        ),
      );
  }
}