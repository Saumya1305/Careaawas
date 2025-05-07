import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'organization_dashboard_page.dart';
import 'organization_signup_page.dart';
import 'forgot_password_page.dart';

class OrganizationLoginPage extends StatefulWidget {
  const OrganizationLoginPage({super.key});

  @override
  _OrganizationLoginPageState createState() => _OrganizationLoginPageState();
}

class _OrganizationLoginPageState extends State<OrganizationLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _ispasswordvisible = false;
  String _statusMessage = '';
  bool _isLoading = false;

  // Future<void> _loginOrganization() async {
  //   final String apiUrl = 'http://172.19.132.216:3000/ngo/login';

  //   // Show loading state
  //   setState(() {
  //     _isLoading = true;
  //     _statusMessage = '';
  //   });

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         'email': _emailController.text,
  //         'password': _passwordController.text,
  //       }),
  //     );

  //     setState(() {
  //       _isLoading = false;
  //     });

  //     if (response.statusCode == 200) {
  //       // Successful login - NGO is verified
  //       final responseData = json.decode(response.body);
  //       final int ngoId = responseData['ngo']?['ngo_id'];

  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => OrganizationDashboardPage(ngoId: ngoId),
  //         ),
  //       );
  //     } else if (response.statusCode == 403) {
  //       // NGO is pending or rejected
  //       final responseData = json.decode(response.body);
  //       if (responseData is String) {
  //         setState(() {
  //           _statusMessage = responseData;
  //         });
  //       } else {
  //         setState(() {
  //           _statusMessage =
  //               'Your account verification is pending or has been rejected. Please contact support.';
  //         });
  //       }
  //     } else {
  //       // Invalid credentials or other error
  //       setState(() {
  //         _statusMessage = 'Invalid email or password.';
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       _isLoading = false;
  //       _statusMessage = 'Error: $error';
  //     });
  //   }
  // }
  void _showVerificationStatusDialog(String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            status == 'pending'
                ? 'Verification Pending'
                : 'Verification Rejected',
            style: TextStyle(color: Colors.teal),
          ),
          content: Text(
            status == 'pending'
                ? 'Your account is currently under review. Please wait for admin approval.'
                : 'Your account verification has been rejected. Please contact support for further assistance.',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  Future<void> _loginOrganization() async {
    final String apiUrl = 'http://172.21.81.6:3000/ngo/login';

    // Show loading state
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        // Successful login - NGO is verified
        final responseData = json.decode(response.body);
        final int ngoId = responseData['ngo']?['ngo_id'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrganizationDashboardPage(ngoId: ngoId),
          ),
        );
      } else if (response.statusCode == 403) {
        // NGO is pending or rejected
        final responseData = json.decode(response.body);

        // Determine verification status from response
        if (responseData.toString().contains('pending')) {
          _showVerificationStatusDialog('pending');
        } else if (responseData.toString().contains('rejected')) {
          _showVerificationStatusDialog('rejected');
        } else {
          setState(() {
            _statusMessage =
                'Account verification issue. Please contact support.';
          });
        }
      } else {
        // Invalid credentials or other error
        setState(() {
          _statusMessage = 'Invalid email or password.';
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Organization Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.teal,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative elements
              Positioned(
                top: -100,
                left: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -100,
                right: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              Center(
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
                            Icon(
                              Icons.business,
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
                              'Login to your organization account',
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
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.teal),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (!value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Enter a valid email (must contain @ and .)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_ispasswordvisible,
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
                                child: Text(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              onPressed: _isLoading ? null : _loginOrganization,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account? ',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrganizationSignupPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_statusMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _statusMessage.contains('Error') ||
                                            _statusMessage
                                                .contains('rejected') ||
                                            _statusMessage
                                                .contains('pending') ||
                                            _statusMessage.contains('Invalid')
                                        ? Colors.red.withOpacity(0.1)
                                        : Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    _statusMessage,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _statusMessage.contains('Error') ||
                                              _statusMessage
                                                  .contains('rejected') ||
                                              _statusMessage
                                                  .contains('pending') ||
                                              _statusMessage.contains('Invalid')
                                          ? Colors.red
                                          : Colors.green,
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
