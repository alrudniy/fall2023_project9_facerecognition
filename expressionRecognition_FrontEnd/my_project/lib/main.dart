import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_project/photosPage.dart';
import 'package:http/http.dart' as http;

import 'cameraPage.dart';
import 'historical_record.dart';
import 'settingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraPage()),
                );
              },
              child: Icon(Icons.camera),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 150),
                shape: CircleBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhotosPage()),
                );
              },
              child: Icon(Icons.photo_library),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 150),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistoricalRecordPage()),
            );
          },
          child: Text('historical record'),
        ),
      ),
    );
  }
}
