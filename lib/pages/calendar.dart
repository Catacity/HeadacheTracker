import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fluttertest/pages/calendar_detailed_page.dart';

// For testing
String userID = "3";

Future<Map<DateTime, int>> fetchHeadacheIntensity(String userId) async{
  List<Map<String, dynamic>>? resultList = await HeadacheFormDBHelper.instance.fetchValidEntriesForUser(userId);
  print(resultList);

  Map<DateTime, int> mappedIntensity = {};
  if (resultList != null){
    if (resultList.length > 0){
      for (int i = 0 ; i < resultList.length ; i++){
        DateTime date = DateTime.fromMillisecondsSinceEpoch(resultList[i]['TS_DATE'] * 1000);
        date = DateTime(date.year,date.month,date.day);
        mappedIntensity[date] = int.parse(resultList[i]['intensityLevel']);
      }
    }
  }

  // Dummy
  // Map<DateTime, int> mappedIntensity = {
  //   DateTime(2023, 4, 1): 1,
  //   DateTime(2023, 4, 2): 2,
  //   DateTime(2023, 4, 3): 3,
  //   DateTime(2023, 4, 4): 1,
  //   DateTime(2023, 4, 5): 3,
  // };

  return mappedIntensity;
}

class HeadTrackerPage extends StatefulWidget {
  HeadTrackerPage({required Key key, required this.userID, required this.headacheQueryResult}) : super(key: key);

  factory HeadTrackerPage.async() {
    Future<Map<DateTime, int>?> queryResult = fetchHeadacheIntensity(userID);
    DateTime key = DateTime.now();
    return HeadTrackerPage(
      key: ValueKey(key),
      userID:userID,
      headacheQueryResult: queryResult,
    );
  }

  @override
  _HeadTrackerPageState createState() => _HeadTrackerPageState();
}

class _HeadTrackerPageState extends State<HeadTrackerPage> {
  DateTime? selectedDate;

  // Sample data for the heatmap, replace with your actual data
  Map<DateTime, int> intensityData = {
    DateTime(2023, 4, 1): 1,
    DateTime(2023, 4, 2): 2,
    DateTime(2023, 4, 3): 3,
    DateTime(2023, 4, 4): 1,
    DateTime(2023, 4, 5): 3,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Headache Tracker',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              HeatMapCalendar(
                colorMode: ColorMode.color,
                datasets: intensityData,
                colorsets: {
                  1: Colors.lime,
                  2: Colors.yellow,
                  3: Colors.orange,
                  4: Colors.redAccent.shade700
                },
                onClick: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                  // print("You clicked me!");
                },
                // Change the text color of the dates with colors
                textColor: Colors.black,
                monthFontSize: 20,
                weekFontSize: 14,
                size: 50,
              ),
              // Legend
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildLegendItem("Weak headache", Colors.yellow),
                            SizedBox(width: 10),
                            buildLegendItem("Moderate headache", Colors.orange),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildLegendItem("Strong headache", Colors.redAccent
                                .shade700),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Display selected date and show details button
              selectedDate != null
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Selected date: ${DateFormat(
                    'MMMM d, y',
                  ).format(selectedDate!)}',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : Container(),
              selectedDate != null
                  ? ElevatedButton(
                onPressed: () {
                  // Navigate to the detailed page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailedInfoPage.async(
                            key: ValueKey(selectedDate!),
                            date: selectedDate!,
                            userID : userID,
                          ),
                    ),
                  );
                },
                child: Text('Show Details'),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLegendItem(String text, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: color,
              ),
            ),
            SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}