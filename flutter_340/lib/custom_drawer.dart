import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  // Add user avatar image here
                ),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Settings'),
            // Add functionality for Settings
            onTap: () {
              // Navigate or perform Settings action
            },
          ),
          ListTile(
            title: Text('Logout'),
            // Add functionality for Logout
            onTap: () {
              // Implement logout logic
            },
          ),
        ],
      ),
    );
  }
}
