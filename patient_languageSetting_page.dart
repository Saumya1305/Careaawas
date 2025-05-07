import 'package:flutter/material.dart';

class PatientLanguageSettingsPage extends StatelessWidget {
  const PatientLanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Select Language'),
            onTap: () {
              // Navigate to language selection page
            },
          ),
        ],
      ),
    );
  }
}