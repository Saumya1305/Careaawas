// import 'package:flutter/material.dart';
// import 'ble_service.dart';

// class PatientVitalsPage extends StatefulWidget {
//   final int patientId;
//   const PatientVitalsPage({Key? key, required this.patientId})
//       : super(key: key);

//   @override
//   _PatientVitalsPageState createState() => _PatientVitalsPageState();
// }

// class _PatientVitalsPageState extends State<PatientVitalsPage> {
//   final BleService bleService = BleService();
//   String heartRate = "-- BPM";
//   String oxygenLevel = "-- %";
//   String stepCount = "-- Steps";

//   @override
//   void initState() {
//     super.initState();
//     initBluetooth();
//   }

//   Future<void> initBluetooth() async {
//     await bleService.scanForDevices();
//     await Future.delayed(Duration(seconds: 5));
//     await bleService.connectToDevice();

//     bleService.subscribeToHeartRate(onData: (int hr) {
//       if (!mounted) return;
//       setState(() {
//         heartRate = "$hr BPM";
//       });
//     });

//     bleService.subscribeToOxygenLevel(onData: (int spo2) {
//       if (!mounted) return;
//       setState(() {
//         oxygenLevel = "$spo2%";
//       });
//     });

//     bleService.subscribeToStepCount(onData: (int steps) {
//       if (!mounted) return;
//       setState(() {
//         stepCount = "$steps Steps";
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Patient Vitals")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("❤️ Heart Rate: $heartRate", style: TextStyle(fontSize: 22)),
//             Text("🩸 Oxygen Level: 98%",
//                 style: TextStyle(fontSize: 22)),
//             Text("👣 Step Count: $stepCount", style: TextStyle(fontSize: 22)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await initBluetooth(); // Reinitialize BLE connection
//               },
//               child: Text("🔄 Refresh Data"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui'; 
import 'ble_service.dart';

class PatientVitalsPage extends StatefulWidget {
  final int patientId;
  const PatientVitalsPage({Key? key, required this.patientId})
      : super(key: key);

  @override
  _PatientVitalsPageState createState() => _PatientVitalsPageState();
}

class _PatientVitalsPageState extends State<PatientVitalsPage> with SingleTickerProviderStateMixin {
  final BleService bleService = BleService();
  String heartRate = "-- BPM";
  String oxygenLevel = "-- %";
  String stepCount = "-- Steps";
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    initBluetooth();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> initBluetooth() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await bleService.scanForDevices();
      await Future.delayed(Duration(seconds: 5));
      await bleService.connectToDevice();

      bleService.subscribeToHeartRate(onData: (int hr) {
        if (!mounted) return;
        setState(() {
          heartRate = "$hr BPM";
        });
      });

      bleService.subscribeToOxygenLevel(onData: (int spo2) {
        if (!mounted) return;
        setState(() {
          oxygenLevel = "$spo2%";
        });
      });

      bleService.subscribeToStepCount(onData: (int steps) {
        if (!mounted) return;
        setState(() {
          stepCount = "$steps Steps";
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error connecting to device: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF008080), // Teal background
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF008080), // Teal
                    Color(0xFF00CED1), // Dark Turquoise
                  ],
                ),
              ),
            ),
            
            // Animated Overlay
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    math.sin(_animationController.value * math.pi) * 10,
                    math.cos(_animationController.value * math.pi) * 10,
                  ),
                  child: Opacity(
                    opacity: 0.2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Color(0xFF008080).withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Patient Vitals",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Icon(
                        Icons.medical_services_outlined,
                        color: Colors.white.withOpacity(0.7),
                        size: 30,
                      ),
                    ],
                  ),
                ),

                // Vitals Cards
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildVitalCard(
                        title: "Heart Rate",
                        value: heartRate,
                        icon: Icons.favorite,
                        color: Color(0xFFFF6B6B),
                      ),
                      _buildVitalCard(
                        title: "Oxygen Level",
                        value: oxygenLevel,
                        icon: Icons.air,
                        color: Color(0xFF4ECDC4),
                      ),
                      _buildVitalCard(
                        title: "Step Count",
                        value: stepCount,
                        icon: Icons.directions_walk,
                        color: Color(0xFFF9D56E),
                      ),
                    ],
                  ),
                ),

                // Refresh Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : initBluetooth,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          _isLoading ? 'Connecting...' : 'Refresh Data',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 40,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}