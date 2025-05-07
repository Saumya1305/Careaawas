import 'package:flutter/material.dart';
import 'patient_notification_page.dart';
import 'patient_privacySetting_page.dart';
import 'patient_languageSetting_page.dart';
import 'patient_aboutApp_page.dart';
import 'role_selection_page.dart';

class SettingsPatientPage extends StatelessWidget {
  const SettingsPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildSettingsButton(
              context,
              icon: Icons.notifications,
              label: 'Notification Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientNotificationPage(),
                  ),
                );
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.privacy_tip,
              label: 'Privacy Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientPrivacySettingsPage(),
                  ),
                );
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.language,
              label: 'Language',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientLanguageSettingsPage(),
                  ),
                );
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.info,
              label: 'About App',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientAboutAppPage(),
                  ),
                );
              },
            ),
            _buildSettingsButton(
              context,
              icon: Icons.logout,
              label: 'Logout',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoleSelectionPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.white,
            ),
            const SizedBox(height: 10.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
