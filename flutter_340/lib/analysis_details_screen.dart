import 'package:flutter/material.dart';

class AnalysisDetailsScreen extends StatelessWidget {
  // You may need to pass data related to the selected analysis
  final String analysisData;

  AnalysisDetailsScreen({super.key, required this.analysisData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Analysis Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analysis Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display analysis details based on the data passed
            Text('Analysis Data: $analysisData'),
            // Add more widgets to display additional analysis details

            // Placeholder for a button to go back to the previous screen
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
