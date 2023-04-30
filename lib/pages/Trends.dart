import 'package:flutter/material.dart';

class Trends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(

          children: [
            SizedBox(height: 30),
            Text(
              'Trends and insights',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue ,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeadacheTrendsPage(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children:[
                        Image.asset(
                          'lib/images/headache.png',

                          height: 40,
                          color: Colors.white,


                        ),
                   SizedBox(width: 5),
                    Text(
                      'Headache Trends',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                        SizedBox(width: 100),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                ],
                    ),
                    SizedBox(height: 10),
                    Image.asset(
                      'lib/images/plot.png',
                      width: 500,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: 380,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HabitHeadacheRelationPage(),
                    ),
                  );
                },

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.directions_run,
                          color: Colors.white,
                          size: 30,
                        ),

                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),

                        Image.asset(
                          'lib/images/headache.png',

                          height: 40,
                          color: Colors.white,

                        ),
                        SizedBox(width: 10),
                        Text(
                          'Habits and Headache',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),

                        ),

                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),


                    Image.asset(
                      'lib/images/trends.png',
                      width: 500,
                      height: 90,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeadacheTrendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Headache Trends'),
      ),
      body: Center(
        child: Text('This is the Headache Trends Page'),
      ),
    );
  }
}

class HabitHeadacheRelationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Headache Trends'),
      ),
      body: Center(
        child: Text('This is the Headache Trends Page'),
      ),
    );
  }
}
