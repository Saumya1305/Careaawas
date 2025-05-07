// import 'package:flutter/material.dart';
// import 'donate_signup_page.dart';

// class DonateLoginPage extends StatefulWidget {
//   const DonateLoginPage({Key? key}) : super(key: key);

//   @override
//   _DonateLoginPageState createState() => _DonateLoginPageState();
// }

// class _DonateLoginPageState extends State<DonateLoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   String _statusMessage = '';

//   Future<void> _login() async {
//     // Implement login functionality here
//     setState(() {
//       _statusMessage = 'Logging in...';
//     });
//     // Add your authentication logic here
//   }

//   void _navigateToForgotPassword() {
//     // Navigate to forgot password page
//   }

//   void _navigateToSignUp() {
//     // Navigate to sign up page
//   }

//   Widget _buildGradientCircle(double size) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: RadialGradient(
//           colors: [
//             Colors.teal.withOpacity(0.6),
//             Colors.transparent,
//           ],
//           radius: 0.6,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal,
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: const Text(
//           'Donate Login',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Stack(
//         children: [
//           // Gradient circles positioning (same as original)
//           Positioned(
//             top: -100,
//             right: -100,
//             child: _buildGradientCircle(200),
//           ),
//           Positioned(
//             top: 100,
//             left: -150,
//             child: _buildGradientCircle(150),
//           ),
//           Positioned(
//             bottom: -50,
//             left: -50,
//             child: _buildGradientCircle(180),
//           ),
//           Positioned(
//             bottom: 50,
//             right: -120,
//             child: _buildGradientCircle(220),
//           ),
//           Positioned(
//             top: 250,
//             right: -70,
//             child: _buildGradientCircle(120),
//           ),
//           Positioned(
//             top: 180,
//             left: 50,
//             child: _buildGradientCircle(130),
//           ),
//           Positioned(
//             top: 300,
//             left: 120,
//             child: _buildGradientCircle(160),
//           ),
//           Positioned(
//             top: 400,
//             right: 80,
//             child: _buildGradientCircle(190),
//           ),
//           SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Card(
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(32.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           const Icon(
//                             Icons.person_outline,
//                             size: 64,
//                             color: Colors.teal,
//                           ),
//                           const SizedBox(height: 24),
//                           Text(
//                             'Welcome to Donate',
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineSmall
//                                 ?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.teal,
//                                 ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Please sign in to continue',
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                   color: Colors.grey[600],
//                                 ),
//                           ),
//                           const SizedBox(height: 32),
//                           TextField(
//                             controller: _emailController,
//                             decoration: InputDecoration(
//                               labelText: 'Email',
//                               prefixIcon: const Icon(Icons.email_outlined),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           const SizedBox(height: 16),
//                           TextField(
//                             controller: _passwordController,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               prefixIcon: const Icon(Icons.lock_outline),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _isPasswordVisible
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isPasswordVisible = !_isPasswordVisible;
//                                   });
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             obscureText: !_isPasswordVisible,
//                           ),
//                           const SizedBox(height: 8),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: _navigateToForgotPassword,
//                               child: const Text(
//                                 'Forgot Password?',
//                                 style: TextStyle(color: Colors.teal),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.teal,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 16,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 2,
//                             ),
//                             onPressed: _login,
//                             child: const Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text("Don't have an account?"),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const DonateSignupPage()),
//                                   );
//                                 },
//                                 child: const Text(
//                                   'Sign Up',
//                                   style: TextStyle(color: Colors.teal),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             _statusMessage,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: _statusMessage.contains('Error')
//                                   ? Colors.red
//                                   : Colors.green,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'donate_signup_page.dart';
import 'donate_home_page.dart';
//import 'forgot_password_page.dart';

class DonateLoginPage extends StatefulWidget {
  const DonateLoginPage({Key? key}) : super(key: key);

  @override
  _DonateLoginPageState createState() => _DonateLoginPageState();
}

class _DonateLoginPageState extends State<DonateLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _statusMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String apiUrl = 'http://172.21.81.6:3000/donate_users/login';

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
        // Handle potential null safely
        if (responseData['donate_user'] != null &&
            responseData['donate_user']['user_id'] != null) {
          final int userId = responseData['donate_user']['user_id'];

          if (!mounted) return; // Check if widget is still mounted

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonationHomePage(user_id: userId),
            ),
          );
        } else {
          setState(() {
            _statusMessage = 'Invalid response format from server.';
          });
        }
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

  // void _navigateToForgotPassword() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
  //   );
  // }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DonateSignupPage()),
    );
  }

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
          'Donate Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Gradient circles positioning
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
                            Icons.person_outline,
                            size: 64,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Welcome to Donate',
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
                            'Please sign in to continue',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          const SizedBox(height: 32),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            obscureText: !_isPasswordVisible,
                          ),
                          // const SizedBox(height: 8),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: TextButton(
                          //     onPressed: _navigateToForgotPassword,
                          //     child: const Text(
                          //       'Forgot Password?',
                          //       style: TextStyle(color: Colors.teal),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            onPressed: _login,
                            child: const Text(
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
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: _navigateToSignUp,
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _statusMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _statusMessage.contains('Error')
                                  ? Colors.red
                                  : Colors.green,
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
