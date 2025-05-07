import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  Future<void> sendResetLink() async {
  try {
    final response = await http.post(
      Uri.parse("http://172.21.81.6:3000/auth/forgot-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": emailController.text}),
    );

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    final data = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data.containsKey("message") ? data["message"] : data["error"])),
    );
  } catch (e) {
    print("Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong!")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Enter your email"),
            ),
            ElevatedButton(
              onPressed: sendResetLink,
              child: Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}
