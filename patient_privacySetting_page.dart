import 'package:flutter/material.dart';

class PatientPrivacySettingsPage extends StatelessWidget {
  const PatientPrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Manage Account Privacy'),
            onTap: () {
              // Navigate to account privacy management
            },
          ),
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to change password
            },
          ),
          ListTile(
            title: const Text('Manage Data Permissions'),
            onTap: () {
              // Navigate to data permissions
            },
          ),
        ],
      ),
    );
  }
}

