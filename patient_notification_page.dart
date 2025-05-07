import 'package:flutter/material.dart';

class PatientNotificationPage extends StatelessWidget {
  const PatientNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: true, // Set based on user's preference
            onChanged: (bool value) {
              // Update notification preference
            },
          ),
          ListTile(
            title: const Text('Notification Frequency'),
            onTap: () {
              // Navigate to set notification frequency
            },
          ),
        ],
      ),
    );
  }
}

