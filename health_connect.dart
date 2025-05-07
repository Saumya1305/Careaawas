import 'package:flutter/services.dart';

class HealthConnect {
  static const MethodChannel _channel = MethodChannel('health_connect');

  // Request health data permissions
  static Future<bool> requestPermissions() async {
    final bool granted = await _channel.invokeMethod('requestPermissions');
    return granted;
  }

  // Get health data from the native code
  static Future<Map<dynamic, dynamic>> getHealthData() async {
    final Map<dynamic, dynamic> data =
        await _channel.invokeMethod('getHealthData');
    return data;
  }
}
