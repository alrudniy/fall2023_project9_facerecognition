import 'package:flutter/material.dart';
import 'analysis_details_screen.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the following list with data from your video analysis history
    List<String> videoHistory = ['Analysis 1', 'Analysis 2', 'Analysis 3'];

    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: ListView.builder(
        itemCount: videoHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videoHistory[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalysisDetailsScreen(analysisData: '',),
                  // You may need to pass data related to the selected analysis
                ),
              );
            },
          );
        },
      ),
    );
  }
}
