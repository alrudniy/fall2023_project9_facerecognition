import 'package:flutter/material.dart';

class CameraPermissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Permission')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add UI for displaying other person's mood
            // Add UI for real-time camera view
            // Add button for capturing video
            ElevatedButton(
              onPressed: () {
                // Add functionality for capturing video
              },
              child: Text('Capture Video'),
            ),
          ],
        ),
      ),
    );
  }
}
