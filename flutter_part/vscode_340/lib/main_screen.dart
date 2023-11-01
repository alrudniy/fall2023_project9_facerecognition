import 'package:flutter/material.dart';
import 'upload_screen.dart';
import 'camera_permission_screen.dart';
import 'custom_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSR App',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FSR')),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToScreen(context, UploadScreen());
              },
              child: Text('Local Video Upload'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToScreen(context, CameraPermissionScreen());
              },
              child: Text('Get Camera Permission'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analysis Results'),
        ],
      ),
    );
  }

  // Function to navigate to a new screen
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
