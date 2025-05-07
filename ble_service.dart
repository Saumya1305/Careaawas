// import 'dart:async';
// import 'package:permission_handler/permission_handler.dart'; // Handle permissions
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:flutter/material.dart';

// class BleService {
//   final flutterReactiveBle = FlutterReactiveBle();
//   String? deviceId;
//   late StreamSubscription<DiscoveredDevice> _scanSubscription;
//   late StreamSubscription<ConnectionStateUpdate> _connectionSubscription;

//   // Request BLE permissions
//   Future<void> requestPermissions() async {
//     await [
//       Permission.bluetooth,
//       Permission.bluetoothScan,
//       Permission.bluetoothConnect,
//       Permission.location,
//     ].request();
//   }

//   // Step 1: Scan for Smartwatch
//   Future<void> scanForDevices() async {
//     await requestPermissions(); // Ensure permissions are granted

//     _scanSubscription = flutterReactiveBle.scanForDevices(withServices: []).listen(
//       (device) {
//         if (device.name.contains("XTEND") || device.name.contains("BOAT")) {
//           print("🎯 Found Smartwatch: ${device.id}");
//           deviceId = device.id;
//           _scanSubscription.cancel(); // Stop scanning once found
//         }
//       },
//       onError: (error) {
//         print("❌ Scan error: $error");
//       },
//     );
//   }

//   // Step 2: Connect to Smartwatch
//   Future<void> connectToDevice() async {
//   if (deviceId == null) {
//     print("❌ No device found. Scan first!");
//     return;
//   }

//   _connectionSubscription = flutterReactiveBle.connectToDevice(id: deviceId!).listen(
//     (connectionState) async {
//       print("🔗 Connection state: $connectionState");

//       if (connectionState.connectionState == DeviceConnectionState.connected) {
//         try {
//           final mtu = await flutterReactiveBle.requestMtu(deviceId: deviceId!, mtu: 512);
//           print("🔧 Requested MTU size: $mtu");

//           await Future.delayed(Duration(seconds: 2)); // Wait for stability

//           await discoverCharacteristics(); // Check services after connection
//         } catch (e) {
//           print("⚠️ MTU request failed: $e");
//         }
//       }
//     },
//     onError: (error) {
//       print("❌ Connection error: $error");
//     },
//   );
// }

//   // Step 3: Discover Services & Characteristics
//   Future<void> discoverCharacteristics() async {
//   if (deviceId == null) {
//     print("❌ No device connected!");
//     return;
//   }

//   print("🔍 Checking predefined services...");

//   // List of known services & characteristics (modify as needed)
//   List<Map<String, String>> knownServices = [
//     {
//       "service": "0000180D-0000-1000-8000-00805F9B34FB", // Heart Rate Service
//       "characteristic": "00002A37-0000-1000-8000-00805F9B34FB" // Heart Rate Measurement
//     },
//     {
//       "service": "0000180A-0000-1000-8000-00805F9B34FB", // Device Information
//       "characteristic": "00002A29-0000-1000-8000-00805F9B34FB" // Manufacturer Name
//     }
//   ];

//   for (var service in knownServices) {
//     print("🛠 Checking Service: ${service["service"]}");
//     print("📌 Expected Characteristic: ${service["characteristic"]}");
//   }
// }

//   // Step 4: Read Heart Rate (Update UUIDs based on discovery)
//   Future<void> readHeartRate() async {
//     if (deviceId == null) {
//       print("❌ No device connected!");
//       return;
//     }

//     final characteristic = QualifiedCharacteristic(
//       serviceId: Uuid.parse("0000180D-0000-1000-8000-00805F9B34FB"), // Standard Heart Rate Service
//       characteristicId: Uuid.parse("00002A37-0000-1000-8000-00805F9B34FB"), // Standard Heart Rate Characteristic
//       deviceId: deviceId!,
//     );

//     try {
//       final result = await flutterReactiveBle.readCharacteristic(characteristic);
//       print("❤️ Heart Rate: ${result[0]} BPM");
//     } catch (e) {
//       print("❌ Error reading heart rate: $e");
//     }
//   }

//   // Step 5: Subscribe to Steps (Update UUIDs based on discovery)
//   void subscribeToSteps() {
//     if (deviceId == null) {
//       print("❌ No device connected!");
//       return;
//     }

//     final characteristic = QualifiedCharacteristic(
//       serviceId: Uuid.parse("0000180D-0000-1000-8000-00805F9B34FB"), // Replace with actual Steps Service UUID
//       characteristicId: Uuid.parse("00002A78-0000-1000-8000-00805F9B34FB"), // Replace with actual Steps Characteristic UUID
//       deviceId: deviceId!,
//     );

//     flutterReactiveBle.subscribeToCharacteristic(characteristic).listen(
//       (data) {
//         int steps = data[0];
//         print("👟 Steps Count: $steps");
//       },
//       onError: (error) {
//         print("❌ Error receiving steps data: $error");
//       },
//     );
//   }
// }

// import 'dart:async';
// import 'package:permission_handler/permission_handler.dart'; // Handle permissions
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:flutter/material.dart';

// class BleService {
//   final flutterReactiveBle = FlutterReactiveBle();
//   String? deviceId;
//   late StreamSubscription<DiscoveredDevice> _scanSubscription;
//   late StreamSubscription<ConnectionStateUpdate> _connectionSubscription;
//   late StreamSubscription<List<int>>? _heartRateSubscription;

//   // Request BLE permissions
//   Future<void> requestPermissions() async {
//     await [
//       Permission.bluetooth,
//       Permission.bluetoothScan,
//       Permission.bluetoothConnect,
//       Permission.location,
//     ].request();
//   }

//   // Step 1: Scan for the Target Smartwatch
//   Future<void> scanForDevices() async {
//     await requestPermissions(); // Ensure permissions are granted

//     print("🔍 Starting scan...");
//     _scanSubscription = flutterReactiveBle.scanForDevices(withServices: []).listen(
//       (device) {
//         // Print every found device (for debugging)
//         print("Found device: '${device.name}' with id ${device.id}");
//         // Change the check to match exactly the expected name.
//         if (device.name.trim() == "Noise lcon 2") {
//           print("🎯 Found target smartwatch: ${device.id}");
//           deviceId = device.id;
//           _scanSubscription.cancel(); // Stop scanning once found
//         }
//       },
//       onError: (error) {
//         print("❌ Scan error: $error");
//       },
//     );
//   }

//   // Step 2: Connect to the Smartwatch
//   Future<void> connectToDevice() async {
//     if (deviceId == null) {
//       print("❌ No device found. Scan first!");
//       return;
//     }

//     _connectionSubscription = flutterReactiveBle.connectToDevice(id: deviceId!).listen(
//       (connectionState) async {
//         print("🔗 Connection state: $connectionState");
//         if (connectionState.connectionState == DeviceConnectionState.connected) {
//           try {
//             final mtu = await flutterReactiveBle.requestMtu(deviceId: deviceId!, mtu: 512);
//             print("🔧 Requested MTU size: $mtu");
//             // Wait a bit to ensure the connection is stable
//             await Future.delayed(Duration(seconds: 2));
//             // Automatically subscribe to heart rate notifications once connected
//             await subscribeToHeartRate(onData: (int hr) {
//               print("Received heart rate: $hr BPM");
//             });
//           } catch (e) {
//             print("⚠️ MTU request failed: $e");
//           }
//         }
//       },
//       onError: (error) {
//         print("❌ Connection error: $error");
//       },
//     );
//   }

//   // Step 3: Subscribe to Heart Rate Measurement (0x2A37)
//   Future<void> subscribeToHeartRate({required Function(int) onData}) async {
//   if (deviceId == null) {
//     print("❌ No device connected!");
//     return;
//   }

//   final characteristic = QualifiedCharacteristic(
//     serviceId: Uuid.parse("0000180D-0000-1000-8000-00805F9B34FB"), // Standard Heart Rate Service
//     characteristicId: Uuid.parse("00002A37-0000-1000-8000-00805F9B34FB"), // Standard Heart Rate Measurement
//     deviceId: deviceId!,
//   );

//   try {
//     print("📡 Subscribing to heart rate notifications...");
//     _heartRateSubscription = flutterReactiveBle.subscribeToCharacteristic(characteristic).listen(
//       (data) {
//         // Debug print the raw data:
//         print("Raw heart rate data: $data");
//         if (data.length >= 2) {
//           // Use the second byte (index 1) as the heart rate value.
//           int hr = data[1];
//           print("Received heart rate: $hr BPM");
//           onData(hr);
//         } else {
//           print("Unexpected data length: ${data.length}");
//         }
//       },
//       onError: (error) {
//         print("❌ Error receiving heart rate data: $error");
//       },
//     );
//   } catch (e) {
//     print("❌ Subscription error: $e");
//   }
// }

//   // Step 4: Cleanup when not needed
//   void dispose() {
//     _scanSubscription.cancel();
//     _connectionSubscription.cancel();
//     _heartRateSubscription?.cancel();
//     print("🛑 BLE service disposed.");
//   }
// }

import 'dart:async';
import 'package:permission_handler/permission_handler.dart'; // Handle permissions
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleService {
  final flutterReactiveBle = FlutterReactiveBle();
  String? deviceId;
  late StreamSubscription<DiscoveredDevice> _scanSubscription;
  late StreamSubscription<ConnectionStateUpdate> _connectionSubscription;
  StreamSubscription<List<int>>? _heartRateSubscription;
  StreamSubscription<List<int>>? _oxygenLevelSubscription;
  StreamSubscription<List<int>>? _stepCountSubscription;

  // Request BLE permissions
  Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
  }

  // Scan for the Target Smartwatch
  Future<void> scanForDevices() async {
    await requestPermissions();
    print("🔍 Scanning for smartwatch...");

    _scanSubscription =
        flutterReactiveBle.scanForDevices(withServices: []).listen(
      (device) {
        print("Found device: '${device.name}' with id ${device.id}");
        if (device.name.trim() == "FireBoltt 100") {
          print("🎯 Found smartwatch: ${device.id}");
          deviceId = device.id;
          _scanSubscription.cancel(); // Stop scanning once found
        }
      },
      onError: (error) {
        print("❌ Scan error: $error");
      },
    );
  }

  // Connect to the Smartwatch
  Future<void> connectToDevice() async {
    if (deviceId == null) {
      print("❌ No device found. Scan first!");
      return;
    }

    _connectionSubscription =
        flutterReactiveBle.connectToDevice(id: deviceId!).listen(
      (connectionState) async {
        print("🔗 Connection state: $connectionState");
        if (connectionState.connectionState ==
            DeviceConnectionState.connected) {
          try {
            final mtu = await flutterReactiveBle.requestMtu(
                deviceId: deviceId!, mtu: 512);
            print("🔧 Requested MTU size: $mtu");
            await Future.delayed(Duration(seconds: 2));

            // Subscribe to health metrics
            await subscribeToHeartRate(onData: (int hr) {
              print("❤️ Heart Rate: $hr BPM");
            });

            await subscribeToOxygenLevel(onData: (int spo2) {
              print("🩸 Oxygen Level: $spo2%");
            });

            await subscribeToStepCount(onData: (int steps) {
              print("👣 Steps: $steps");
            });

            // Keep connection alive
            keepConnectionAlive();
          } catch (e) {
            print("⚠️ MTU request failed: $e");
          }
        }
      },
      onError: (error) {
        print("❌ Connection error: $error");
        onDisconnected();
      },
    );
  }

  // Keep the connection alive if Bluetooth disconnects
  void keepConnectionAlive() {
    flutterReactiveBle.statusStream.listen((status) async {
      if (status == BleStatus.ready) {
        if (deviceId != null) {
          print("🔄 Reconnecting...");
          await connectToDevice();
        }
      } else {
        print("❌ Bluetooth turned off or unavailable.");
      }
    });
  }

  // Handle disconnection and try to reconnect
  void onDisconnected() async {
    print("🔌 Disconnected. Attempting to reconnect...");
    await Future.delayed(Duration(seconds: 5)); // Small delay before retry
    await connectToDevice();
  }

  // Subscribe to Heart Rate
  Future<void> subscribeToHeartRate({required Function(int) onData}) async {
    if (deviceId == null) return;

    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("0000180D-0000-1000-8000-00805F9B34FB"),
      characteristicId: Uuid.parse("00002A37-0000-1000-8000-00805F9B34FB"),
      deviceId: deviceId!,
    );

    _heartRateSubscription =
        flutterReactiveBle.subscribeToCharacteristic(characteristic).listen(
      (data) {
        if (data.length >= 2) {
          int hr = data[1];
          onData(hr);
        }
      },
      onError: (error) {
        print("❌ Heart Rate Error: $error");
      },
    );
  }

  // Subscribe to Oxygen Level
  Future<void> subscribeToOxygenLevel({required Function(int) onData}) async {
    if (deviceId == null) return;

    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("0000FEEA-0000-1000-8000-00805F9B34FB"),
      characteristicId: Uuid.parse("0000FEE1-0000-1000-8000-00805F9B34FB"),
      deviceId: deviceId!,
    );

    _oxygenLevelSubscription =
        flutterReactiveBle.subscribeToCharacteristic(characteristic).listen(
      (data) {
        if (data.isNotEmpty) {
          int spo2 = data[0];
          onData(spo2);
        }
      },
      onError: (error) {
        print("❌ Oxygen Level Error: $error");
      },
    );
  }

  // Subscribe to Step Count
  Future<void> subscribeToStepCount({required Function(int) onData}) async {
    if (deviceId == null) return;

    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("0000FEEA-0000-1000-8000-00805F9B34FB"),
      characteristicId: Uuid.parse("0000FEE1-0000-1000-8000-00805F9B34FB"),
      deviceId: deviceId!,
    );

    _stepCountSubscription =
        flutterReactiveBle.subscribeToCharacteristic(characteristic).listen(
      (data) {
        if (data.length >= 2) {
          int steps = data[0] | (data[1] << 8);
          onData(steps);
        }
      },
      onError: (error) {
        print("❌ Step Count Error: $error");
      },
    );
  }

  // Cleanup
  void dispose() {
    _scanSubscription.cancel();
    _connectionSubscription.cancel();
    _heartRateSubscription?.cancel();
    _oxygenLevelSubscription?.cancel();
    _stepCountSubscription?.cancel();
    print("🛑 BLE service disposed.");
  }
}
