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

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  String? _tempHtmlFilePath;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _loadHtmlFromAssets().then((File file) {
      setState(() {
        _tempHtmlFilePath = file.uri.toString();
      });
    });
  }

  Future<File> _loadHtmlFromAssets() async {
    // Replace 'assets/html/sample.html' with the path to your HTML file
    String fileText = await rootBundle.loadString('assets/vega_lite6.html');

    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/temp.html');
    await tempFile.writeAsString(
      fileText.replaceAll('{{data}}', dataToJson1()), // Replace {{data}} with JSON data
      flush: true,
    );
    return tempFile;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep and headache'),
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
