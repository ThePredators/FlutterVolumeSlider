import 'package:flutter/material.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                FlutterVolumeSlider(
                  display: Display.HORIZONTAL,
                  sliderActiveColor: Colors.blue,
                  sliderInActiveColor: Colors.grey,
                ),
                FlutterVolumeSlider(
                  display: Display.VERTICAL,
                  sliderActiveColor: Colors.blue,
                  sliderInActiveColor: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
