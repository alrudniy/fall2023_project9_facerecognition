import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Video')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add UI for local video upload or drag and drop
            ElevatedButton(
              onPressed: () {
                // Add functionality for video upload
              },
              child: Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}
