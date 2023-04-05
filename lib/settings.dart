import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: const Text('Settings'),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.black,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                    radius: 48.0,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png")),
                SizedBox(width: 16.0),
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Notifications',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SwitchListTile(
              title: const Text('Push Notifications',
                  style: TextStyle(color: Colors.white)),
              value: _pushNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _pushNotificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Email Notifications',
                  style: TextStyle(color: Colors.white)),
              value: _emailNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _emailNotificationsEnabled = value;
                });
              },
            ),
            const Divider(),
            const Text(
              'Appearance',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: const Text('Theme', style: TextStyle(color: Colors.white)),
              subtitle:
                  const Text('Dark', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the theme selection page
              },
            ),
            ListTile(
              title: const Text('Font Size',
                  style: TextStyle(color: Colors.white)),
              subtitle:
                  const Text('Large', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the font size selection page
              },
            ),
            const Divider(),
            const Text(
              'Account',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            ListTile(
              title: const Text('Change Password',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the change password page
              },
            ),
            ListTile(
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Perform logout
              },
            ),
            const Divider(),
            const Text(
              'Feedback and Support',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: const Text('Send Feedback',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the feedback form
              },
            ),
            ListTile(
              title: const Text('Contact Support',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the support page
              },
            ),
          ],
        ),
      ),
    );
  }
}
