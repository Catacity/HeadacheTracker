import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';
import 'package:fluttertest/pages/calendar_detailed_page.dart';
import 'package:fluttertest/databasehandler/headacheForm.dart';

// For testing:
// String userID = "3";

Future<Map<DateTime, int>> fetchHeadacheIntensity(String userId) async{
  List<Map<String, dynamic>>? resultList = await HeadacheFormDBHelper.instance.fetchValidEntriesForUser(userId);
  // print(resultList);

  Map<DateTime, int> mappedIntensity = {};
  if (resultList != null){
    if (resultList.length > 0){
      // print(resultList.length);
      for (int i = 0 ; i < resultList.length ; i++){
        DateTime date = DateTime.fromMillisecondsSinceEpoch(resultList[i]['dateInSecondsSinceEpoch'] * 1000);

        // print("TS: ${resultList[i]['dateInSecondsSinceEpoch']}");
        // print("intensity: ${resultList[i]['intensityLevel']}");

        date = DateTime(date.year,date.month,date.day);
        mappedIntensity[date] = resultList[i]['intensityLevel'];
      }
    }
  }

  // print(mappedIntensity);
  return mappedIntensity;
}

class HeadTrackerPage extends StatefulWidget {
  final Future<Map<DateTime, int>?> headacheQueryResult;
  final String userID;

  HeadTrackerPage({required Key key, required this.userID, required this.headacheQueryResult}) : super(key: key);

  factory HeadTrackerPage.async({required key, required String userID}) {
    Future<Map<DateTime, int>?> queryResult = fetchHeadacheIntensity(userID);
    DateTime key = DateTime.now();
    return HeadTrackerPage(
      key: ValueKey(key),
      userID: userID,
      headacheQueryResult: queryResult,
    );
  }

  @override
  _HeadTrackerPageState createState() => _HeadTrackerPageState();
}

class _HeadTrackerPageState extends State<HeadTrackerPage> {
  DateTime? selectedDate;

  // Sample data for the heatmap, replace with your actual data
  // Map<DateTime, int>? intensityData;
  Map<DateTime, int>? intensityData;

  @override
  void initState() {
    super.initState();
    // deFuture the furure lists/ maps
    widget.headacheQueryResult.then((qResult) {
      setState(() {
        intensityData = qResult ?? {};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(intensityData);
    Map<DateTime, int> intensityMapping = intensityData ?? {};
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
                datasets: intensityMapping,
                colorsets: {
                  0: Colors.lime,
                  1: Colors.yellow,
                  2: Colors.orange,
                  3: Colors.redAccent.shade700
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
                            buildLegendItem("Mild headache", Colors.lime),
                            SizedBox(width: 10),
                            buildLegendItem("Moderate headache", Colors.yellow),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildLegendItem("Strong headache", Colors.orange),
                            SizedBox(width: 10),
                            buildLegendItem("Severe headache", Colors.redAccent.shade700),
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
                            userID : widget.userID,
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