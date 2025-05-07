import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordPage extends StatefulWidget {
  final String token;
  ResetPasswordPage({required this.token});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    final response = await http.post(
      Uri.parse("http://172.21.81.6:3000/auth/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": widget.token,
        "new_password": newPasswordController.text,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data["message"])));
      Navigator.pop(context); // Go back to login page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data["error"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: "Enter New Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: resetPassword,
              child: Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
