// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'organization_login_page.dart';

// class OrganizationSignupPage extends StatefulWidget {
//   const OrganizationSignupPage({super.key});

//   @override
//   _OrganizationSignupPageState createState() => _OrganizationSignupPageState();
// }

// class _OrganizationSignupPageState extends State<OrganizationSignupPage> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _ispasswordvisible = false;
//   bool _isConfirmPasswordVisible = false;
//   String _statusMessage = '';

//   Future<void> _signupOrganization() async {
//     if (_passwordController.text != _confirmPasswordController.text) {
//       setState(() {
//         _statusMessage = 'Passwords do not match.';
//       });
//       return;
//     }

//     final String apiUrl = 'http://localhost:3000/ngo';

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'ngo_name': _nameController.text,
//           'email': _emailController.text,
//           'ph_no': _phoneController.text,
//           'password': _passwordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           _statusMessage = 'NGO registered successfully!';
//         });
//         _nameController.clear();
//         _emailController.clear();
//         _phoneController.clear();
//         _passwordController.clear();
//         _confirmPasswordController.clear();
//       } else {
//         setState(() {
//           _statusMessage = 'Failed to register. Please try again.';
//         });
//       }
//     } catch (error) {
//       setState(() {
//         _statusMessage = 'Error: $error';
//       });
//     }
//   }

//   void _navigateToLogin() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => OrganizationLoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Container(
//         height: screenHeight,
//         width: screenWidth,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.teal,
//               Colors.teal,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: -screenHeight * 0.15,
//                 left: -screenHeight * 0.15,
//                 child: Container(
//                   width: screenHeight * 0.3,
//                   height: screenHeight * 0.3,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.white.withOpacity(0.3),
//                         Colors.white.withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -screenHeight * 0.15,
//                 right: -screenHeight * 0.15,
//                 child: Container(
//                   width: screenHeight * 0.3,
//                   height: screenHeight * 0.3,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.white.withOpacity(0.3),
//                         Colors.white.withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxWidth: 600,
//                     maxHeight: screenHeight,
//                   ),
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.symmetric(
//                       vertical: screenHeight * 0.08,
//                       horizontal: 24,
//                     ),
//                     child: Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(32.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Icon(
//                               Icons.business_center,
//                               size: screenHeight * 0.08,
//                               color: Colors.teal,
//                             ),
//                             const SizedBox(height: 24),
//                             Text(
//                               'Create Account',
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall
//                                   ?.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.teal,
//                                   ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Register your organization',
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium
//                                   ?.copyWith(
//                                     color: Colors.grey[600],
//                                   ),
//                             ),
//                             const SizedBox(height: 32),
//                             TextFormField(
//                               controller: _nameController,
//                               decoration: InputDecoration(
//                                 labelText: 'Organization Name',
//                                 prefixIcon:
//                                     Icon(Icons.business, color: Colors.teal),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide:
//                                       BorderSide(color: Colors.teal, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.teal),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 prefixIcon:
//                                     Icon(Icons.email, color: Colors.teal),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide:
//                                       BorderSide(color: Colors.teal, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.teal),
//                               ),
//                               autovalidateMode: AutovalidateMode
//                                   .onUserInteraction, // Auto validate when user types
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Email is required';
//                                 } else if (!value.contains('@') ||
//                                     !value.contains('.')) {
//                                   return 'Enter a valid email (must contain @ and .)';
//                                 }
//                                 return null; // No error if valid
//                               },
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               controller: _phoneController,
//                               keyboardType: TextInputType.phone,
//                               decoration: InputDecoration(
//                                 labelText: 'Phone Number',
//                                 prefixIcon:
//                                     Icon(Icons.phone, color: Colors.teal),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide:
//                                       BorderSide(color: Colors.teal, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.teal),
//                               ),
//                               autovalidateMode: AutovalidateMode
//                                   .onUserInteraction, // Auto validate while typing
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Phone number is required';
//                                 } else if (value.length > 10) {
//                                   return 'Phone number cannot exceed 10 digits';
//                                 } else if (!RegExp(r'^[0-9]{10}$')
//                                     .hasMatch(value)) {
//                                   return 'Enter a valid 10-digit phone number';
//                                 }
//                                 return null; // No error if valid
//                               },
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               controller: _passwordController,
//                               obscureText: !_ispasswordvisible,
//                               decoration: InputDecoration(
//                                 labelText: 'Password',
//                                 prefixIcon:
//                                     Icon(Icons.lock, color: Colors.teal),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _ispasswordvisible
//                                         ? Icons.visibility
//                                         : Icons.visibility_off,
//                                     color: Colors.teal,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _ispasswordvisible = !_ispasswordvisible;
//                                     });
//                                   },
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide:
//                                       BorderSide(color: Colors.teal, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.teal),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               controller: _confirmPasswordController,
//                               obscureText: !_isConfirmPasswordVisible,
//                               decoration: InputDecoration(
//                                 labelText: 'Confirm Password',
//                                 prefixIcon: Icon(Icons.lock_outline,
//                                     color: Colors.teal),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _isConfirmPasswordVisible
//                                         ? Icons.visibility
//                                         : Icons.visibility_off,
//                                     color: Colors.teal,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isConfirmPasswordVisible =
//                                           !_isConfirmPasswordVisible;
//                                     });
//                                   },
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide:
//                                       BorderSide(color: Colors.teal, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.teal),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.teal,
//                                 foregroundColor: Colors.white,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 elevation: 2,
//                               ),
//                               onPressed: _signupOrganization,
//                               child: const Text(
//                                 'Sign Up',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Already have an account? ',
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                                 TextButton(
//                                   onPressed: _navigateToLogin,
//                                   child: const Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       color: Colors.teal,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             if (_statusMessage.isNotEmpty)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 16),
//                                 child: Text(
//                                   _statusMessage,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: _statusMessage.contains('Error') ||
//                                             _statusMessage.contains('match')
//                                         ? Colors.red
//                                         : Colors.green,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 16,
//                 left: 16,
//                 child: Material(
//                   color: Colors.transparent,
//                   child: IconButton(
//                     icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
//                     onPressed: _navigateToLogin,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';
// // import 'organization_login_page.dart';

// // class OrganizationSignupPage extends StatefulWidget {
// //   const OrganizationSignupPage({super.key});

// //   @override
// //   _OrganizationSignupPageState createState() => _OrganizationSignupPageState();
// // }

// // class _OrganizationSignupPageState extends State<OrganizationSignupPage> {
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _confirmPasswordController = TextEditingController();
// //   bool _ispasswordvisible = false;
// //   bool _isConfirmPasswordVisible = false;
// //   String _statusMessage = '';

// //   // Add image picker functionality
// //   File? _image;
// //   final ImagePicker _picker = ImagePicker();

// //   Future<void> _pickImage() async {
// //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       setState(() {
// //         _image = File(pickedFile.path);
// //       });
// //     }
// //   }

// //   Future<void> _signupOrganization() async {
// //     if (_passwordController.text != _confirmPasswordController.text) {
// //       setState(() {
// //         _statusMessage = 'Passwords do not match.';
// //       });
// //       return;
// //     }

// //     final String apiUrl = 'http://localhost:3000/ngo';

// //     try {
// //       final response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {'Content-Type': 'application/json'},
// //         body: json.encode({
// //           'ngo_name': _nameController.text,
// //           'email': _emailController.text,
// //           'ph_no': _phoneController.text,
// //           'password': _passwordController.text,
// //           // You would typically add code here to handle image upload
// //           // For example, convert image to base64 or use a separate API call
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         setState(() {
// //           _statusMessage = 'NGO registered successfully!';
// //         });
// //         _nameController.clear();
// //         _emailController.clear();
// //         _phoneController.clear();
// //         _passwordController.clear();
// //         _confirmPasswordController.clear();
// //         // Clear the selected image
// //         setState(() {
// //           _image = null;
// //         });
// //       } else {
// //         setState(() {
// //           _statusMessage = 'Failed to register. Please try again.';
// //         });
// //       }
// //     } catch (error) {
// //       setState(() {
// //         _statusMessage = 'Error: $error';
// //       });
// //     }
// //   }

// //   void _navigateToLogin() {
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(builder: (context) => OrganizationLoginPage()),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenHeight = MediaQuery.of(context).size.height;
// //     final screenWidth = MediaQuery.of(context).size.width;

// //     return Scaffold(
// //       body: Container(
// //         height: screenHeight,
// //         width: screenWidth,
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Colors.teal,
// //               Colors.teal,
// //             ],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Stack(
// //             children: [
// //               Positioned(
// //                 top: -screenHeight * 0.15,
// //                 left: -screenHeight * 0.15,
// //                 child: Container(
// //                   width: screenHeight * 0.3,
// //                   height: screenHeight * 0.3,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         Colors.white.withOpacity(0.3),
// //                         Colors.white.withOpacity(0.1),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Positioned(
// //                 bottom: -screenHeight * 0.15,
// //                 right: -screenHeight * 0.15,
// //                 child: Container(
// //                   width: screenHeight * 0.3,
// //                   height: screenHeight * 0.3,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         Colors.white.withOpacity(0.3),
// //                         Colors.white.withOpacity(0.1),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Center(
// //                 child: ConstrainedBox(
// //                   constraints: BoxConstraints(
// //                     maxWidth: 600,
// //                     maxHeight: screenHeight,
// //                   ),
// //                   child: SingleChildScrollView(
// //                     padding: EdgeInsets.symmetric(
// //                       vertical: screenHeight * 0.08,
// //                       horizontal: 24,
// //                     ),
// //                     child: Card(
// //                       elevation: 8,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(16),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(32.0),
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           crossAxisAlignment: CrossAxisAlignment.stretch,
// //                           children: [
// //                             Icon(
// //                               Icons.business_center,
// //                               size: screenHeight * 0.08,
// //                               color: Colors.teal,
// //                             ),
// //                             const SizedBox(height: 24),
// //                             Text(
// //                               'Create Account',
// //                               textAlign: TextAlign.center,
// //                               style: Theme.of(context)
// //                                   .textTheme
// //                                   .headlineSmall
// //                                   ?.copyWith(
// //                                     fontWeight: FontWeight.bold,
// //                                     color: Colors.teal,
// //                                   ),
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Text(
// //                               'Register your organization',
// //                               textAlign: TextAlign.center,
// //                               style: Theme.of(context)
// //                                   .textTheme
// //                                   .bodyMedium
// //                                   ?.copyWith(
// //                                     color: Colors.grey[600],
// //                                   ),
// //                             ),
// //                             const SizedBox(height: 32),
// //                             TextFormField(
// //                               controller: _nameController,
// //                               decoration: InputDecoration(
// //                                 labelText: 'Organization Name',
// //                                 prefixIcon:
// //                                     Icon(Icons.business, color: Colors.teal),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   borderSide:
// //                                       BorderSide(color: Colors.teal, width: 2),
// //                                 ),
// //                                 labelStyle: TextStyle(color: Colors.teal),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                             TextFormField(
// //                               controller: _emailController,
// //                               decoration: InputDecoration(
// //                                 labelText: 'Email',
// //                                 prefixIcon:
// //                                     Icon(Icons.email, color: Colors.teal),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   borderSide:
// //                                       BorderSide(color: Colors.teal, width: 2),
// //                                 ),
// //                                 labelStyle: TextStyle(color: Colors.teal),
// //                               ),
// //                               autovalidateMode: AutovalidateMode
// //                                   .onUserInteraction, // Auto validate when user types
// //                               validator: (value) {
// //                                 if (value == null || value.isEmpty) {
// //                                   return 'Email is required';
// //                                 } else if (!value.contains('@') ||
// //                                     !value.contains('.')) {
// //                                   return 'Enter a valid email (must contain @ and .)';
// //                                 }
// //                                 return null; // No error if valid
// //                               },
// //                             ),
// //                             const SizedBox(height: 16),
// //                             TextFormField(
// //                               controller: _phoneController,
// //                               keyboardType: TextInputType.phone,
// //                               decoration: InputDecoration(
// //                                 labelText: 'Phone Number',
// //                                 prefixIcon:
// //                                     Icon(Icons.phone, color: Colors.teal),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   borderSide:
// //                                       BorderSide(color: Colors.teal, width: 2),
// //                                 ),
// //                                 labelStyle: TextStyle(color: Colors.teal),
// //                               ),
// //                               autovalidateMode: AutovalidateMode
// //                                   .onUserInteraction, // Auto validate while typing
// //                               validator: (value) {
// //                                 if (value == null || value.isEmpty) {
// //                                   return 'Phone number is required';
// //                                 } else if (value.length > 10) {
// //                                   return 'Phone number cannot exceed 10 digits';
// //                                 } else if (!RegExp(r'^[0-9]{10}$')
// //                                     .hasMatch(value)) {
// //                                   return 'Enter a valid 10-digit phone number';
// //                                 }
// //                                 return null; // No error if valid
// //                               },
// //                             ),
// //                             const SizedBox(height: 16),
// //                             TextFormField(
// //                               controller: _passwordController,
// //                               obscureText: !_ispasswordvisible,
// //                               decoration: InputDecoration(
// //                                 labelText: 'Password',
// //                                 prefixIcon:
// //                                     Icon(Icons.lock, color: Colors.teal),
// //                                 suffixIcon: IconButton(
// //                                   icon: Icon(
// //                                     _ispasswordvisible
// //                                         ? Icons.visibility
// //                                         : Icons.visibility_off,
// //                                     color: Colors.teal,
// //                                   ),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _ispasswordvisible = !_ispasswordvisible;
// //                                     });
// //                                   },
// //                                 ),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   borderSide:
// //                                       BorderSide(color: Colors.teal, width: 2),
// //                                 ),
// //                                 labelStyle: TextStyle(color: Colors.teal),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                             TextFormField(
// //                               controller: _confirmPasswordController,
// //                               obscureText: !_isConfirmPasswordVisible,
// //                               decoration: InputDecoration(
// //                                 labelText: 'Confirm Password',
// //                                 prefixIcon: Icon(Icons.lock_outline,
// //                                     color: Colors.teal),
// //                                 suffixIcon: IconButton(
// //                                   icon: Icon(
// //                                     _isConfirmPasswordVisible
// //                                         ? Icons.visibility
// //                                         : Icons.visibility_off,
// //                                     color: Colors.teal,
// //                                   ),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _isConfirmPasswordVisible =
// //                                           !_isConfirmPasswordVisible;
// //                                     });
// //                                   },
// //                                 ),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   borderSide:
// //                                       BorderSide(color: Colors.teal, width: 2),
// //                                 ),
// //                                 labelStyle: TextStyle(color: Colors.teal),
// //                               ),
// //                             ),

// //                             // Added image upload section
// //                             const SizedBox(height: 24),
// //                             Text(
// //                               'Organization Logo',
// //                               style: TextStyle(
// //                                 color: Colors.grey[600],
// //                                 fontSize: 16,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 8),
// //                             Container(
// //                               height: 150,
// //                               width: double.infinity,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.grey[200],
// //                                 borderRadius: BorderRadius.circular(12),
// //                                 border: Border.all(color: Colors.teal),
// //                               ),
// //                               child: _image != null
// //                                   ? ClipRRect(
// //                                       borderRadius: BorderRadius.circular(12),
// //                                       child: Image.file(
// //                                         _image!,
// //                                         fit: BoxFit.cover,
// //                                       ),
// //                                     )
// //                                   : Column(
// //                                       mainAxisAlignment: MainAxisAlignment.center,
// //                                       children: [
// //                                         Icon(
// //                                           Icons.image,
// //                                           size: 50,
// //                                           color: Colors.grey[400],
// //                                         ),
// //                                         const SizedBox(height: 8),
// //                                         Text(
// //                                           'No image selected',
// //                                           style: TextStyle(color: Colors.grey[600]),
// //                                         ),
// //                                       ],
// //                                     ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                             ElevatedButton.icon(
// //                               icon: Icon(Icons.upload_file),
// //                               label: Text('Upload Logo'),
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.white,
// //                                 foregroundColor: Colors.teal,
// //                                 side: BorderSide(color: Colors.teal),
// //                                 padding: const EdgeInsets.symmetric(vertical: 12),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                               ),
// //                               onPressed: _pickImage,
// //                             ),

// //                             const SizedBox(height: 24),
// //                             ElevatedButton(
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: Colors.teal,
// //                                 foregroundColor: Colors.white,
// //                                 padding:
// //                                     const EdgeInsets.symmetric(vertical: 16),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 elevation: 2,
// //                               ),
// //                               onPressed: _signupOrganization,
// //                               child: const Text(
// //                                 'Sign Up',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 16),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 Text(
// //                                   'Already have an account? ',
// //                                   style: TextStyle(color: Colors.grey[600]),
// //                                 ),
// //                                 TextButton(
// //                                   onPressed: _navigateToLogin,
// //                                   child: const Text(
// //                                     'Login',
// //                                     style: TextStyle(
// //                                       color: Colors.teal,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             if (_statusMessage.isNotEmpty)
// //                               Padding(
// //                                 padding: const EdgeInsets.only(top: 16),
// //                                 child: Text(
// //                                   _statusMessage,
// //                                   textAlign: TextAlign.center,
// //                                   style: TextStyle(
// //                                     color: _statusMessage.contains('Error') ||
// //                                             _statusMessage.contains('match')
// //                                         ? Colors.red
// //                                         : Colors.green,
// //                                   ),
// //                                 ),
// //                               ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 16,
// //                 left: 16,
// //                 child: Material(
// //                   color: Colors.transparent,
// //                   child: IconButton(
// //                     icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
// //                     onPressed: _navigateToLogin,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:typed_data'; // For web image bytes
// // import 'package:file_picker/file_picker.dart'; // For web
// // import 'package:image_picker/image_picker.dart'; // For Android/iOS
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'organization_login_page.dart';

// // class OrganizationSignupPage extends StatefulWidget {
// //   const OrganizationSignupPage({super.key});

// //   @override
// //   _OrganizationSignupPageState createState() => _OrganizationSignupPageState();
// // }

// // class _OrganizationSignupPageState extends State<OrganizationSignupPage> {
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _confirmPasswordController = TextEditingController();
// //   final _licenseNumberController = TextEditingController();
// //   bool _ispasswordvisible = false;
// //   bool _isConfirmPasswordVisible = false;
// //   String _statusMessage = '';
// //   File? _licenseImage; // For Android/iOS
// //   Uint8List? _webImageBytes; // For Web
// //   String? _licenseImageName;

// //   // Function to pick image (Android/iOS)
// //   Future<void> _pickImageMobile() async {
// //     final pickedFile =
// //         await ImagePicker().pickImage(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       setState(() {
// //         _licenseImage = File(pickedFile.path);
// //         _licenseImageName = pickedFile.name;
// //       });
// //     }
// //   }

// //   // Function to pick image (Web)
// //   Future<void> _pickImageWeb() async {
// //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// //       type: FileType.image,
// //     );
// //     if (result != null && result.files.single.bytes != null) {
// //       setState(() {
// //         _webImageBytes = result.files.single.bytes;
// //         _licenseImageName = result.files.single.name;
// //       });
// //     }
// //   }

// //   Future<void> _signupOrganization() async {
// //     if (_passwordController.text != _confirmPasswordController.text) {
// //       setState(() {
// //         _statusMessage = 'Passwords do not match.';
// //       });
// //       return;
// //     }

// //     if (!_licenseNumberController.text.startsWith("N-")) {
// //       setState(() {
// //         _statusMessage = "License number must start with 'N-'.";
// //       });
// //       return;
// //     }

// //     final String apiUrl = 'http://localhost:3000/ngo';

// //     var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
// //     request.fields['ngo_name'] = _nameController.text;
// //     request.fields['email'] = _emailController.text;
// //     request.fields['ph_no'] = _phoneController.text;
// //     request.fields['password'] = _passwordController.text;
// //     request.fields['license_number'] = _licenseNumberController.text;

// //     // Handling Image Upload
// //     if (!kIsWeb && _licenseImage != null) {
// //       request.files.add(await http.MultipartFile.fromPath(
// //         'license_image',
// //         _licenseImage!.path,
// //       ));
// //     } else if (kIsWeb && _webImageBytes != null) {
// //       request.files.add(http.MultipartFile.fromBytes(
// //         'license_image',
// //         _webImageBytes!,
// //         filename: _licenseImageName ?? 'license_image.png',
// //       ));
// //     }

// //     try {
// //       var response = await request.send();
// //       if (response.statusCode == 200) {
// //         setState(() {
// //           _statusMessage = 'NGO registered successfully!';
// //         });
// //         _nameController.clear();
// //         _emailController.clear();
// //         _phoneController.clear();
// //         _passwordController.clear();
// //         _confirmPasswordController.clear();
// //         _licenseNumberController.clear();
// //         setState(() {
// //           _licenseImage = null;
// //           _webImageBytes = null;
// //           _licenseImageName = null;
// //         });
// //       } else {
// //         setState(() {
// //           _statusMessage = 'Failed to register. Please try again.';
// //         });
// //       }
// //     } catch (error) {
// //       setState(() {
// //         _statusMessage = 'Error: $error';
// //       });
// //     }
// //   }

// //   void _navigateToLogin() {
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(builder: (context) => OrganizationLoginPage()),
// //     );
// //   }

// //   // Password Field Widget
// //   Widget _passwordField(String label, TextEditingController controller,
// //       bool isVisible, VoidCallback toggleVisibility) {
// //     return TextFormField(
// //       controller: controller,
// //       obscureText: !isVisible,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         prefixIcon: const Icon(Icons.lock, color: Colors.teal),
// //         suffixIcon: IconButton(
// //           icon: Icon(
// //             isVisible ? Icons.visibility : Icons.visibility_off,
// //             color: Colors.teal,
// //           ),
// //           onPressed: toggleVisibility,
// //         ),
// //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenHeight = MediaQuery.of(context).size.height;
// //     final screenWidth = MediaQuery.of(context).size.width;

// //     return Scaffold(
// //       body: Container(
// //         height: screenHeight,
// //         width: screenWidth,
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Colors.teal, Colors.teal],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Center(
// //             child: SingleChildScrollView(
// //               padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
// //               child: Card(
// //                 elevation: 8,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(16),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(32.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.stretch,
// //                     children: [
// //                       Icon(Icons.business_center, size: 60, color: Colors.teal),
// //                       const SizedBox(height: 24),
// //                       Text(
// //                         'Create Account',
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 22,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.teal,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 16),

// //                       // NGO Name
// //                       TextFormField(
// //                         controller: _nameController,
// //                         decoration: _inputDecoration(
// //                             'Organization Name', Icons.business),
// //                       ),
// //                       const SizedBox(height: 16),

// //                       // Email
// //                       TextFormField(
// //                         controller: _emailController,
// //                         decoration: _inputDecoration('Email', Icons.email),
// //                       ),
// //                       const SizedBox(height: 16),

// //                       // Phone Number
// //                       TextFormField(
// //                         controller: _phoneController,
// //                         decoration:
// //                             _inputDecoration('Phone Number', Icons.phone),
// //                         keyboardType: TextInputType.phone,
// //                       ),
// //                       const SizedBox(height: 16),

// //                       // License Number
// //                       TextFormField(
// //                         controller: _licenseNumberController,
// //                         decoration: _inputDecoration(
// //                             'License Number (N-XXXX)', Icons.badge),
// //                       ),
// //                       const SizedBox(height: 16),

// //                       // Password
// //                       _passwordField(
// //                           'Password', _passwordController, _ispasswordvisible,
// //                           () {
// //                         setState(() {
// //                           _ispasswordvisible = !_ispasswordvisible;
// //                         });
// //                       }),
// //                       const SizedBox(height: 16),

// //                       // Confirm Password
// //                       _passwordField(
// //                           'Confirm Password',
// //                           _confirmPasswordController,
// //                           _isConfirmPasswordVisible, () {
// //                         setState(() {
// //                           _isConfirmPasswordVisible =
// //                               !_isConfirmPasswordVisible;
// //                         });
// //                       }),
// //                       const SizedBox(height: 16),

// //                       // License Image Upload
// //                       ElevatedButton.icon(
// //                         onPressed: () async {
// //                           if (kIsWeb) {
// //                             await _pickImageWeb();
// //                           } else {
// //                             await _pickImageMobile();
// //                           }
// //                         },
// //                         icon: Icon(Icons.upload_file),
// //                         label: Text("Upload License Image"),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.teal,
// //                           foregroundColor: Colors.white,
// //                         ),
// //                       ),
// //                       if (_licenseImageName != null) ...[
// //                         const SizedBox(height: 8),
// //                         Text("Selected: $_licenseImageName",
// //                             textAlign: TextAlign.center),
// //                       ],
// //                       const SizedBox(height: 24),

// //                       // Sign Up Button
// //                       ElevatedButton(
// //                         onPressed: _signupOrganization,
// //                         child: Text("Sign Up",
// //                             style: TextStyle(
// //                                 fontSize: 16, fontWeight: FontWeight.bold)),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.teal,
// //                           foregroundColor: Colors.white,
// //                         ),
// //                       ),

// //                       const SizedBox(height: 16),

// //                       // Status Message
// //                       if (_statusMessage.isNotEmpty)
// //                         Text(
// //                           _statusMessage,
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                               color: _statusMessage.contains('Error')
// //                                   ? Colors.red
// //                                   : Colors.green),
// //                         ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   InputDecoration _inputDecoration(String label, IconData icon) {
// //     return InputDecoration(
// //       labelText: label,
// //       prefixIcon: Icon(icon, color: Colors.teal),
// //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'organization_login_page.dart';

class OrganizationSignupPage extends StatefulWidget {
  const OrganizationSignupPage({super.key});

  @override
  _OrganizationSignupPageState createState() => _OrganizationSignupPageState();
}

class _OrganizationSignupPageState extends State<OrganizationSignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _licenseUrlController =
      TextEditingController(); // New controller for license URL
  bool _ispasswordvisible = false;
  bool _isConfirmPasswordVisible = false;
  String _statusMessage = '';
  bool _isUploading = false;
  bool _isValidUrl = false; // Track if URL is valid

  // Function to validate URL format
  void _validateUrl(String url) {
    // Simple URL validation - checks if it contains drive.google.com
    setState(() {
      _isValidUrl = url.isNotEmpty && url.contains('drive.google.com');
    });
  }

  // Test link function - could be expanded to actually test URL accessibility
  void _testLink() {
    if (_licenseUrlController.text.isEmpty) {
      setState(() {
        _statusMessage = 'Please enter a Google Drive URL first';
      });
      return;
    }

    if (_isValidUrl) {
      setState(() {
        _statusMessage =
            'Link appears to be valid! Admin will be able to access it.';
      });
    } else {
      setState(() {
        _statusMessage = 'Invalid Google Drive link. Please check the format.';
      });
    }
  }

  Future<void> _signupOrganization() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _statusMessage = 'Passwords do not match.';
      });
      return;
    }

    if (!_isValidUrl) {
      setState(() {
        _statusMessage =
            'Please provide a valid Google Drive link to your license document.';
      });
      return;
    }

    setState(() {
      _isUploading = true;
      _statusMessage = 'Creating account...';
    });

    final String apiUrl = 'http://172.21.81.6:3000/ngo';

    try {
      // Create request
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ngo_name': _nameController.text,
          'email': _emailController.text,
          'ph_no': _phoneController.text,
          'password': _passwordController.text,
          'license_proof_url':
              _licenseUrlController.text, // Send URL instead of file
        }),
      );

      setState(() {
        _isUploading = false;
      });

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'NGO registered successfully!';
        });
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _licenseUrlController.clear();
      } else {
        setState(() {
          _statusMessage = 'Failed to register. Please try again.';
        });
      }
    } catch (error) {
      setState(() {
        _isUploading = false;
        _statusMessage = 'Error: $error';
      });
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrganizationLoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
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
              Positioned(
                top: -screenHeight * 0.15,
                left: -screenHeight * 0.15,
                child: Container(
                  width: screenHeight * 0.3,
                  height: screenHeight * 0.3,
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
                bottom: -screenHeight * 0.15,
                right: -screenHeight * 0.15,
                child: Container(
                  width: screenHeight * 0.3,
                  height: screenHeight * 0.3,
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
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                    maxHeight: screenHeight,
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.08,
                      horizontal: 24,
                    ),
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
                              Icons.business_center,
                              size: screenHeight * 0.08,
                              color: Colors.teal,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Create Account',
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
                              'Register your organization',
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
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Organization Name',
                                prefixIcon:
                                    Icon(Icons.business, color: Colors.teal),
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
                            ),
                            const SizedBox(height: 16),
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
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon:
                                    Icon(Icons.phone, color: Colors.teal),
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
                                  .onUserInteraction, // Auto validate while typing
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                } else if (value.length > 10) {
                                  return 'Phone number cannot exceed 10 digits';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid 10-digit phone number';
                                }
                                return null; // No error if valid
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_ispasswordvisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.teal),
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
                                  borderSide:
                                      BorderSide(color: Colors.teal, width: 2),
                                ),
                                labelStyle: TextStyle(color: Colors.teal),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.teal),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.teal,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
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
                            ),
                            const SizedBox(height: 24),

                            // New Google Drive Link field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _licenseUrlController,
                                  decoration: InputDecoration(
                                    labelText:
                                        'License Document Google Drive Link',
                                    prefixIcon:
                                        Icon(Icons.link, color: Colors.teal),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Colors.teal, width: 2),
                                    ),
                                    labelStyle: TextStyle(color: Colors.teal),
                                    suffixIcon:
                                        _licenseUrlController.text.isNotEmpty
                                            ? Icon(
                                                _isValidUrl
                                                    ? Icons.check_circle
                                                    : Icons.error,
                                                color: _isValidUrl
                                                    ? Colors.green
                                                    : Colors.red,
                                              )
                                            : null,
                                  ),
                                  onChanged: (value) {
                                    _validateUrl(value);
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Upload your license document to Google Drive and share the link here',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                OutlinedButton.icon(
                                  icon: Icon(Icons.verified, size: 18),
                                  label: Text('Test Link'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.teal,
                                    side: BorderSide(color: Colors.teal),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _testLink,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '• Make sure your document is set to "Anyone with the link can view"',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
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
                              onPressed:
                                  _isUploading ? null : _signupOrganization,
                              child: _isUploading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text('Creating Account...')
                                      ],
                                    )
                                  : const Text(
                                      'Sign Up',
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
                                  'Already have an account? ',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                TextButton(
                                  onPressed: _navigateToLogin,
                                  child: const Text(
                                    'Login',
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
                                child: Text(
                                  _statusMessage,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _statusMessage.contains('Error') ||
                                            _statusMessage.contains('match') ||
                                            _statusMessage
                                                .contains('Invalid') ||
                                            _statusMessage
                                                .contains('Please provide')
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
              Positioned(
                top: 16,
                left: 16,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: _navigateToLogin,
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
