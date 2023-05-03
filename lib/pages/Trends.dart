import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';



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

class HeadacheData {
  final String date;
  final int intensity;

  HeadacheData({required this.date, required this.intensity});

  factory HeadacheData.fromJson(Map<String, dynamic> json) {
    return HeadacheData(
      date: json['date'],
      intensity: json['intensity'],
    );
  }
}


class ChartData {
  final String month;
  final int intensity1Count;
  final int intensity2Count;
  final int intensity3Count;

  ChartData({
    required this.month,
    required this.intensity1Count,
    required this.intensity2Count,
    required this.intensity3Count,
  });
}


class HeadacheTrendsPage extends StatefulWidget {
  @override
  _HeadacheTrendsPageState createState() => _HeadacheTrendsPageState();
}

class _HeadacheTrendsPageState extends State<HeadacheTrendsPage> {
  List<HeadacheData> data = [];
  int selectedYear = DateTime
      .now()
      .year;
  List<int> availableYears = [];

  Future<void> _loadData() async {
    String jsonString = await rootBundle.loadString('assets/headache_data.json');
    List<dynamic> jsonData = json.decode(jsonString);
    data = jsonData.map((e) => HeadacheData.fromJson(e)).toList();
    availableYears = data.map((e) => DateTime.parse(e.date).year).toSet().toList();
    if (availableYears.isNotEmpty) {
      selectedYear = availableYears.last;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Headache Trends')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerLeft,
                  child:
                  Text("Select the year:",
                      textAlign: TextAlign.left ,
                      style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ) )),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<int>(
                  value: selectedYear,
                  items: availableYears.map<DropdownMenuItem<int>>(
                        (int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(height: 5),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: SfCartesianChart(
                  title: ChartTitle(
                      text: 'Count of headache records and intensity',
                      textStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold ,
                        fontSize: 16,
                      )),
                  legend: Legend(isVisible: true),
                  primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Months')),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Count of records')),
                  series: _buildStackedColumnSeries(selectedYear),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  
  List<StackedColumnSeries<ChartData, String>> _buildStackedColumnSeries(
      int year) {
    List<ChartData> chartData = _prepareChartData(year);
    return [
      StackedColumnSeries<ChartData, String>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.month,
        yValueMapper: (ChartData data, _) => data.intensity1Count,
        color: Colors.yellow,
        name: 'Intensity 1',
      ),
      StackedColumnSeries<ChartData, String>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.month,
        yValueMapper: (ChartData data, _) => data.intensity2Count,
        color: Colors.orange,
        name: 'Intensity 2',
      ),
      StackedColumnSeries<ChartData, String>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.month,
        yValueMapper: (ChartData data, _) => data.intensity3Count,
        color: Colors.red,
        name: 'Intensity 3',
      ),
    ];
  }

  List<ChartData> _prepareChartData(int year) {
    List<ChartData> chartData = [];
    Map<String, List<int>> monthlyData = _initializeMonthlyData();

    for (var item in data) {
      DateTime dateTime = DateTime.parse(item.date);
      if (dateTime.year == year) {
        String month = DateFormat('MMM').format(dateTime);
        monthlyData[month]?[item.intensity - 1] = (monthlyData[month]?[item.intensity - 1] ?? 0) + 1;

      }
    }

    for (var entry in monthlyData.entries) {
      chartData.add(ChartData(
        month: entry.key,
        intensity1Count: entry.value[0],
        intensity2Count: entry.value[1],
        intensity3Count: entry.value[2],
      ));
    }

    return chartData;
  }

  Map<String, List<int>> _initializeMonthlyData() {
    Map<String, List<int>> monthlyData = {};

    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    for (String month in months) {
      monthlyData[month] = [0, 0, 0];
    }

    return monthlyData;
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
