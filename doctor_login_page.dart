import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'doctor_home_page.dart';
import 'forgot_password_page.dart';
import 'role_selection_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({super.key});

  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _ispasswordvisible = false; //naya h
  String _statusMessage = '';

  Future<void> _loginDoctor() async {
    final String apiUrl = 'http://172.21.81.6:3000/doctor/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('API Response: $responseData'); // Debugging line

        // Corrected to access doctor_id inside "doctor"
        final int? doctorId = responseData['doctor']?['doctor_id'] != null
            ? int.tryParse(responseData['doctor']!['doctor_id'].toString())
            : null;

        if (doctorId == null) {
          setState(() {
            _statusMessage = 'Error: Doctor ID not found.';
          });
          return;
        }

        // Store doctor_id in SharedPreferences for later use
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('doctor_id', doctorId);

        // Navigate to HomePage and pass doctorId
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DoctorHomePage(doctorId: doctorId)),
        );
      } else {
        setState(() {
          _statusMessage = 'Invalid email or password.';
        });
      }
    } catch (error) {
      setState(() {
        _statusMessage = 'Error: $error';
      });
    }
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  void _navigateToRoleSelection() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
    );
  }

  // Method to create the gradient circle background
  Widget _buildGradientCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.teal.withOpacity(0.6),
            Colors.transparent,
          ],
          radius: 0.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Doctor Login',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _navigateToRoleSelection,
        ),
      ),
      body: Stack(
        children: [
          // Background Design Elements (Gradient Circles)
          Positioned(
            top: -100,
            right: -100,
            child: _buildGradientCircle(200),
          ),
          Positioned(
            top: 100,
            left: -150,
            child: _buildGradientCircle(150),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildGradientCircle(180),
          ),
          Positioned(
            bottom: 50,
            right: -120,
            child: _buildGradientCircle(220),
          ),
          Positioned(
            top: 250,
            right: -70,
            child: _buildGradientCircle(120),
          ),
          Positioned(
            top: 180,
            left: 50,
            child: _buildGradientCircle(130),
          ),
          Positioned(
            top: 300,
            left: 120,
            child: _buildGradientCircle(160),
          ),
          Positioned(
            top: 400,
            right: 80,
            child: _buildGradientCircle(190),
          ),
          Positioned(
            top: 500,
            left: 200,
            child: _buildGradientCircle(140),
          ),
          Positioned(
            top: 600,
            right: 150,
            child: _buildGradientCircle(180),
          ),
          Positioned(
            bottom: 150,
            left: 250,
            child: _buildGradientCircle(150),
          ),
          Positioned(
            bottom: 200,
            right: 200,
            child: _buildGradientCircle(170),
          ),
          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.medical_services,
                            size: 64,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Welcome Back',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Login to your doctor account',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email, color: Colors.teal),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.teal, width: 2),
                              ),
                              labelStyle: TextStyle(color: Colors.teal),
                            ),
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction, // Auto validate when user types
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!value.contains('@') ||
                                  !value.contains('.')) {
                                return 'Enter a valid email (must contain @ and .)';
                              }
                              return null; // No error if valid
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_ispasswordvisible, //naya code
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.teal),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _ispasswordvisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _ispasswordvisible = !_ispasswordvisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 2),
                              ),
                              labelStyle: const TextStyle(color: Colors.teal),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _navigateToForgotPassword,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.teal),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: _loginDoctor,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (_statusMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                _statusMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _statusMessage.contains('Error')
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
