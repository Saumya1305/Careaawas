import 'package:flutter/material.dart';

class PatientAboutAppPage extends StatelessWidget {
  const PatientAboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Careआवास is designed to support patients in their rehabilitation journey, offering real-time monitoring, data management, and communication with doctors and healthcare professionals. The app aims to provide a holistic and personalized approach to treatment and recovery, enhancing the patient experience.',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
