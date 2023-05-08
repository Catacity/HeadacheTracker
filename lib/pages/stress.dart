import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertest/pages/daily_headache_data.dart';

class StressPage extends StatefulWidget {
  final String? jsonData;

  const StressPage({Key? key, required this.jsonData}) : super(key: key);

  factory StressPage.async({required Key key, required String? jsonData}) {

    return StressPage(
        key: key,
        jsonData: jsonData
    );
  }

  @override
  _StressPageState createState() => _StressPageState();
}

class _StressPageState extends State<StressPage> {
  String? _tempHtmlFilePath;
  WebViewController? _controller;

  String? jsonStr;

  @override
  void initState() {
    super.initState();
    _loadHtmlFromAssets().then((File file) {
      setState(() {
        _tempHtmlFilePath = file.uri.toString();
      });
    });

    setState(() {
      jsonStr = widget.jsonData;
    });

  }

  Future<File> _loadHtmlFromAssets() async {
    // Replace 'assets/html/sample.html' with the path to your HTML file
    String fileText = await rootBundle.loadString('assets/vega_lite7.html');

    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/temp.html');
    await tempFile.writeAsString(
      fileText.replaceAll('{{data}}', jsonStr ?? "{}"), // Replace {{data}} with JSON data
      flush: true,
    );
    return tempFile;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stress and headache analysis'),
      ),
      body: _tempHtmlFilePath == null
          ? Center(child: CircularProgressIndicator())
          : Column(
          children: [

            Flexible(
              child: Container(
                // set the height as needed
                child: WebView(
                  initialUrl: _tempHtmlFilePath,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                  onPageFinished: (String url) {
                    _controller?.evaluateJavascript('updateChart()');
                  },
                ),
              ),
            ),


          ]
      ),
    );

  }


}
