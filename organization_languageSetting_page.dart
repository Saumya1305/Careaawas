import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  _LanguageSettingsPageState createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = Intl.getCurrentLocale();
  }

  void _changeLanguage(String? languageCode) {
    if (languageCode == null) return;

    setState(() {
      _selectedLanguage = languageCode;
    });

    final locale = Locale(
      languageCode.split('_')[0],
      languageCode.split('_')[1],
    );
    Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.teal, Colors.tealAccent],
              ),
            ),
          ),
          // Decorative circles
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.teal.shade300, Colors.transparent],
                  radius: 0.8,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.teal.shade600, Colors.transparent],
                  radius: 0.8,
                ),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Language',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selectedLanguage,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'en_US',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'hi_IN',
                        child: Text('हिंदी (Hindi)'),
                      ),
                      DropdownMenuItem(
                        value: 'mr_IN',
                        child: Text('मराठी (Marathi)'),
                      ),
                      DropdownMenuItem(
                        value: 'ta_IN',
                        child: Text('தமிழ் (Tamil)'),
                      ),
                      DropdownMenuItem(
                        value: 'gu_IN',
                        child: Text('ગુજરાતી (Gujarati)'),
                      ),
                      DropdownMenuItem(
                        value: 'bn_IN',
                        child: Text('বাংলা (Bengali)'),
                      ),
                    ],
                    onChanged: _changeLanguage,
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Save and Go Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
