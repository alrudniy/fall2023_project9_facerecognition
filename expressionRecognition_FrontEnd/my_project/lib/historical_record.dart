import 'package:flutter/material.dart';
import 'data_manager.dart';
import 'package:my_project/resultPage.dart';
import 'dart:io';

class HistoricalRecordPage extends StatefulWidget {
  @override
  _HistoricalRecordPageState createState() => _HistoricalRecordPageState();
}

class _HistoricalRecordPageState extends State<HistoricalRecordPage> {
  final DataManager _dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historical Records'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dataManager.getAllImageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No records found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var record = snapshot.data![index];
              var dominantEmotion = record['dominant_emotion'];
              var imagePath = record['imagePath'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Image.file(File(imagePath),
                      width: 100, height: 100, fit: BoxFit.cover),
                  title: Text('Dominant Emotion: $dominantEmotion'),
                  onTap: () {
                    Map<String, dynamic> analysisResult = record;
                    String imagePath = record['imagePath'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                            analysisResult: analysisResult,
                            imagePath: imagePath),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
