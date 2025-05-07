// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';

// // // class PatientViewSchedulePage extends StatefulWidget {
// // //   final int patient_id; // Receiving patient_id

// // //   const PatientViewSchedulePage({Key? key, required this.patient_id})
// // //       : super(key: key);

// // //   @override
// // //   _PatientViewSchedulePageState createState() =>
// // //       _PatientViewSchedulePageState();
// // // }

// // // class _PatientViewSchedulePageState extends State<PatientViewSchedulePage> {
// // //   List<Map<String, dynamic>> treatmentList = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchTreatmentData();
// // //   }

// // //   Future<void> fetchTreatmentData() async {
// // //     print("Fetching data for patient_id: ${widget.patient_id}"); // Debugging

// // //     final String apiUrl =
// // //         "http://localhost:3000/api/treatment/getTreatmentByPatientId/${widget.patient_id}";

// // //     try {
// // //       final response = await http.get(Uri.parse(apiUrl));

// // //       print("Response Status: ${response.statusCode}");
// // //       print("Response Body: ${response.body}"); // Debugging

// // //       if (response.statusCode == 200) {
// // //         setState(() {
// // //           treatmentList =
// // //               List<Map<String, dynamic>>.from(json.decode(response.body));
// // //         });
// // //       } else {
// // //         throw Exception("Failed to load treatment data");
// // //       }
// // //     } catch (error) {
// // //       print("Error fetching data: $error");
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("View Schedule"),
// // //       ),
// // //       body: treatmentList.isEmpty
// // //           ? Center(child: CircularProgressIndicator()) // Show loading
// // //           : SingleChildScrollView(
// // //               scrollDirection: Axis.horizontal,
// // //               child: DataTable(
// // //                 columns: const [
// // //                   DataColumn(label: Text("Date")),
// // //                   DataColumn(label: Text("Therapy Type")),
// // //                   DataColumn(label: Text("Activity")),
// // //                   DataColumn(label: Text("Dosage")),
// // //                   DataColumn(label: Text("Notes")),
// // //                 ],
// // //                 rows: treatmentList.map((treatment) {
// // //                   return DataRow(cells: [
// // //                     DataCell(Text(treatment['treatmentDate'].toString())),
// // //                     DataCell(Text(treatment['therapyType'])),
// // //                     DataCell(Text(treatment['activity'])),
// // //                     DataCell(Text(treatment['dosage'])),
// // //                     DataCell(Text(treatment['notes'])),
// // //                   ]);
// // //                 }).toList(),
// // //               ),
// // //             ),
// // //     );
// // //   }
// // // }




// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class PatientViewSchedulePage extends StatefulWidget {
// //   final int patient_id;

// //   const PatientViewSchedulePage({Key? key, required this.patient_id})
// //       : super(key: key);

// //   @override
// //   _PatientViewSchedulePageState createState() =>
// //       _PatientViewSchedulePageState();
// // }

// // class _PatientViewSchedulePageState extends State<PatientViewSchedulePage> {
// //   List<Map<String, dynamic>> treatmentList = [];
// //   bool isLoading = true;
// //   String errorMessage = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchTreatmentData();
// //   }

// //   Future<void> fetchTreatmentData() async {
// //     print("Fetching data for patient_id: ${widget.patient_id}");
// //     setState(() {
// //       isLoading = true;
// //       errorMessage = '';
// //     });

// //     // Replace localhost with your computer's IP if testing on a physical device
// //     final String apiUrl =
// //         "http://localhost:3000/api/treatment/getTreatmentByPatientId/${widget.patient_id}";

// //     try {
// //       final response = await http.get(Uri.parse(apiUrl));

// //       print("Response Status: ${response.statusCode}");
// //       print("Response Body: ${response.body}");

// //       if (response.statusCode == 200) {
// //         final decodedData = json.decode(response.body);
// //         print("Decoded data type: ${decodedData.runtimeType}");
// //         print("Decoded data: $decodedData");
        
// //         setState(() {
// //           isLoading = false;
// //           treatmentList = List<Map<String, dynamic>>.from(decodedData);
// //         });
// //       } else {
// //         setState(() {
// //           isLoading = false;
// //           errorMessage = "Failed to load treatment data: Status ${response.statusCode}";
// //         });
// //         print("API Error: ${response.statusCode} - ${response.body}");
// //       }
// //     } catch (error) {
// //       setState(() {
// //         isLoading = false;
// //         errorMessage = "Error connecting to server: $error";
// //       });
// //       print("Error fetching data: $error");
// //     }
// //   }

// //   String formatDate(dynamic dateString) {
// //     if (dateString == null) return 'N/A';
// //     try {
// //       // Handle different date formats
// //       if (dateString is String) {
// //         // Try to parse ISO date format
// //         final date = DateTime.parse(dateString);
// //         return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
// //       } else {
// //         return dateString.toString();
// //       }
// //     } catch (e) {
// //       print("Date parsing error: $e for date: $dateString");
// //       return dateString.toString();
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Treatment Schedule"),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: fetchTreatmentData,
// //             tooltip: "Refresh data",
// //           ),
// //         ],
// //       ),
// //       body: isLoading
// //           ? Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   CircularProgressIndicator(),
// //                   SizedBox(height: 16),
// //                   Text("Loading treatment schedule..."),
// //                 ],
// //               ),
// //             )
// //           : errorMessage.isNotEmpty
// //               ? Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(Icons.error_outline, size: 48, color: Colors.red),
// //                       SizedBox(height: 16),
// //                       Text(errorMessage),
// //                       SizedBox(height: 16),
// //                       ElevatedButton(
// //                         onPressed: fetchTreatmentData,
// //                         child: Text("Try Again"),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               : treatmentList.isEmpty
// //                   ? Center(
// //                       child: Text("No treatment schedule found for this patient."),
// //                     )
// //                   : Padding(
// //                       padding: const EdgeInsets.all(16.0),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             "Patient Treatment Schedule",
// //                             style: TextStyle(
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           SizedBox(height: 16),
// //                           Expanded(
// //                             child: SingleChildScrollView(
// //                               scrollDirection: Axis.horizontal,
// //                               child: SingleChildScrollView(
// //                                 child: DataTable(
// //                                   columns: const [
// //                                     DataColumn(label: Text("Date")),
// //                                     DataColumn(label: Text("Therapy Type")),
// //                                     DataColumn(label: Text("Activity")),
// //                                     DataColumn(label: Text("Dosage")),
// //                                     DataColumn(label: Text("Notes")),
// //                                   ],
// //                                   rows: treatmentList.map((treatment) {
// //                                     return DataRow(cells: [
// //                                       DataCell(Text(formatDate(treatment['treatmentDate']))),
// //                                       DataCell(Text(treatment['therapyType'] ?? 'N/A')),
// //                                       DataCell(Text(treatment['activity'] ?? 'N/A')),
// //                                       DataCell(Text(treatment['dosage'] ?? 'N/A')),
// //                                       DataCell(Text(treatment['notes'] ?? 'N/A')),
// //                                     ]);
// //                                   }).toList(),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //     );
// //   }
// // }




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class PatientViewSchedulePage extends StatefulWidget {
//   final int patient_id;

//   const PatientViewSchedulePage({Key? key, required this.patient_id})
//       : super(key: key);

//   @override
//   _PatientViewSchedulePageState createState() =>
//       _PatientViewSchedulePageState();
// }

// class _PatientViewSchedulePageState extends State<PatientViewSchedulePage> {
//   List<Map<String, dynamic>> treatmentList = [];
//   bool isLoading = true;
//   String errorMessage = '';
  
//   // Define teal color scheme
//   final Color primaryTeal = Color(0xFF009688);
//   final Color lightTeal = Color(0xFFB2DFDB);
//   final Color darkTeal = Color(0xFF00796B);
//   final Color accentTeal = Color(0xFF4DB6AC);

//   @override
//   void initState() {
//     super.initState();
//     fetchTreatmentData();
//   }

//   Future<void> fetchTreatmentData() async {
//     print("Fetching data for patient_id: ${widget.patient_id}");
//     setState(() {
//       isLoading = true;
//       errorMessage = '';
//     });

//     // Replace localhost with your computer's IP if testing on a physical device
//     final String apiUrl =
//         "http://localhost:3000/api/treatment/getTreatmentByPatientId/${widget.patient_id}";

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       print("Response Status: ${response.statusCode}");
//       print("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final decodedData = json.decode(response.body);
//         print("Decoded data type: ${decodedData.runtimeType}");
//         print("Decoded data: $decodedData");
        
//         // Sort treatments by date (newest first)
//         List<Map<String, dynamic>> sortedList = List<Map<String, dynamic>>.from(decodedData);
//         sortedList.sort((a, b) {
//           DateTime dateA = DateTime.parse(a['treatmentDate'] ?? '2000-01-01');
//           DateTime dateB = DateTime.parse(b['treatmentDate'] ?? '2000-01-01');
//           return dateB.compareTo(dateA); // Newest first
//         });
        
//         setState(() {
//           isLoading = false;
//           treatmentList = sortedList;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = "Failed to load treatment data: Status ${response.statusCode}";
//         });
//         print("API Error: ${response.statusCode} - ${response.body}");
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//         errorMessage = "Error connecting to server: $error";
//       });
//       print("Error fetching data: $error");
//     }
//   }

//   String formatDate(dynamic dateString) {
//     if (dateString == null) return 'N/A';
//     try {
//       if (dateString is String) {
//         final date = DateTime.parse(dateString);
//         return DateFormat('EEEE, MMMM d, yyyy').format(date);
//       } else {
//         return dateString.toString();
//       }
//     } catch (e) {
//       print("Date parsing error: $e for date: $dateString");
//       return dateString.toString();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: primaryTeal,
//         foregroundColor: Colors.white,
//         title: Text(
//           "Treatment Schedule",
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: fetchTreatmentData,
//             tooltip: "Refresh data",
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [primaryTeal, Colors.white],
//             stops: [0.0, 0.3],
//           ),
//         ),
//         child: _buildContent(),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (isLoading) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(primaryTeal),
//             ),
//             SizedBox(height: 16),
//             Text(
//               "Loading treatment schedule...",
//               style: TextStyle(
//                 color: darkTeal,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     if (errorMessage.isNotEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 64, color: Colors.red[700]),
//             SizedBox(height: 16),
//             Text(
//               errorMessage,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.red[700],
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: fetchTreatmentData,
//               icon: Icon(Icons.refresh),
//               label: Text("Try Again"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryTeal,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     if (treatmentList.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.calendar_today, size: 64, color: accentTeal),
//             SizedBox(height: 16),
//             Text(
//               "No treatment schedule found for this patient.",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: darkTeal,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: fetchTreatmentData,
//               icon: Icon(Icons.refresh),
//               label: Text("Refresh"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryTeal,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return SafeArea(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//             child: Row(
//               children: [
//                 Icon(Icons.calendar_month, color: Colors.white),
//                 SizedBox(width: 8),
//                 Text(
//                   "Upcoming Treatment Plans",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//             child: Text(
//               "${treatmentList.length} treatment sessions scheduled",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.white.withOpacity(0.9),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: treatmentList.length,
//               itemBuilder: (context, index) {
//                 final treatment = treatmentList[index];
//                 return _buildTreatmentCard(treatment, index);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTreatmentCard(Map<String, dynamic> treatment, int index) {
//     // Generate a different shade of teal for each therapy type
//     final therapyType = treatment['therapyType'] ?? 'General';
//     final cardColor = index % 2 == 0 ? Colors.white : lightTeal.withOpacity(0.3);
//     final iconData = _getIconForTherapyType(therapyType);
    
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       elevation: 3,
//       shadowColor: Colors.black26,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(
//           color: lightTeal,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: primaryTeal,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Row(
//               children: [
//                 Icon(
//                   iconData,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     formatDate(treatment['treatmentDate']),
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             color: cardColor,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow(
//                   "Therapy Type:",
//                   treatment['therapyType'] ?? 'N/A',
//                   Icons.medical_services,
//                 ),
//                 Divider(height: 16, thickness: 0.5),
//                 _buildInfoRow(
//                   "Activity:",
//                   treatment['activity'] ?? 'N/A',
//                   Icons.directions_run,
//                 ),
//                 Divider(height: 16, thickness: 0.5),
//                 _buildInfoRow(
//                   "Dosage:",
//                   treatment['dosage'] ?? 'N/A',
//                   Icons.format_list_numbered,
//                 ),
//                 if (treatment['notes'] != null && treatment['notes'].toString().trim().isNotEmpty) ...[
//                   Divider(height: 16, thickness: 0.5),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Icon(Icons.notes, size: 18, color: darkTeal),
//                           SizedBox(width: 8),
//                           Text(
//                             "Notes:",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: darkTeal,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 26, top: 4),
//                         child: Text(
//                           treatment['notes'] ?? 'N/A',
//                           style: TextStyle(
//                             height: 1.4,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, IconData icon) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 18, color: darkTeal),
//         SizedBox(width: 8),
//         Expanded(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: darkTeal,
//                 ),
//               ),
//               SizedBox(width: 4),
//               Expanded(
//                 child: Text(
//                   value,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   IconData _getIconForTherapyType(String therapyType) {
//     switch (therapyType.toLowerCase()) {
//       case 'physical therapy':
//       case 'physiotherapy':
//         return Icons.fitness_center;
//       case 'occupational therapy':
//         return Icons.engineering;
//       case 'speech therapy':
//         return Icons.record_voice_over;
//       case 'medication':
//         return Icons.medication;
//       case 'massage':
//         return Icons.spa;
//       case 'hydrotherapy':
//         return Icons.pool;
//       case 'exercise':
//         return Icons.directions_run;
//       default:
//         return Icons.healing;
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PatientViewSchedulePage extends StatefulWidget {
  final int patient_id;

  const PatientViewSchedulePage({Key? key, required this.patient_id})
      : super(key: key);

  @override
  _PatientViewSchedulePageState createState() =>
      _PatientViewSchedulePageState();
}

class _PatientViewSchedulePageState extends State<PatientViewSchedulePage> {
  List<Map<String, dynamic>> treatmentList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchTreatmentData();
  }

  Future<void> fetchTreatmentData() async {
    print("Fetching data for patient_id: ${widget.patient_id}");
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Replace localhost with your computer's IP if testing on a physical device
    final String apiUrl =
        "http://172.21.81.6:3000/api/treatment/getTreatmentByPatientId/${widget.patient_id}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        print("Decoded data type: ${decodedData.runtimeType}");
        print("Decoded data: $decodedData");
        
        // Sort treatments by date (newest first)
        List<Map<String, dynamic>> sortedList = List<Map<String, dynamic>>.from(decodedData);
        sortedList.sort((a, b) {
          DateTime dateA = DateTime.parse(a['treatmentDate'] ?? '2000-01-01');
          DateTime dateB = DateTime.parse(b['treatmentDate'] ?? '2000-01-01');
          return dateB.compareTo(dateA); // Newest first
        });
        
        setState(() {
          isLoading = false;
          treatmentList = sortedList;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "Failed to load treatment data: Status ${response.statusCode}";
        });
        print("API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Error connecting to server: $error";
      });
      print("Error fetching data: $error");
    }
  }

  String formatDate(dynamic dateString) {
    if (dateString == null) return 'N/A';
    try {
      if (dateString is String) {
        final date = DateTime.parse(dateString);
        return DateFormat('EEEE, MMMM d, yyyy').format(date);
      } else {
        return dateString.toString();
      }
    } catch (e) {
      print("Date parsing error: $e for date: $dateString");
      return dateString.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Treatment Schedule',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchTreatmentData,
            tooltip: "Refresh data",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade800,
        ),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.teal.shade600, Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.teal.shade600, Colors.transparent],
                  ),
                ),
              ),
            ),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Loading treatment schedule...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[200]),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: fetchTreatmentData,
              icon: Icon(Icons.refresh),
              label: Text("Try Again"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade400,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (treatmentList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 64, color: Colors.white70),
            SizedBox(height: 16),
            Text(
              "No treatment schedule found",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Check back later for updates",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: fetchTreatmentData,
              icon: Icon(Icons.refresh),
              label: Text("Refresh"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade400,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Your Treatment Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${treatmentList.length} sessions scheduled",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final treatment = treatmentList[index];
              return _buildTreatmentCard(treatment);
            },
            childCount: treatmentList.length,
          ),
        ),
        // Add some padding at the bottom
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }

  Widget _buildTreatmentCard(Map<String, dynamic> treatment) {
    // Get therapy type and icon
    final therapyType = treatment['therapyType'] ?? 'General';
    final iconData = _getIconForTherapyType(therapyType);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.shade400,
              Colors.teal.shade600,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Icon(
                      iconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      formatDate(treatment['treatmentDate']),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Treatment details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Therapy Type", treatment['therapyType'] ?? 'N/A'),
                  SizedBox(height: 12),
                  _buildInfoRow("Activity", treatment['activity'] ?? 'N/A'),
                  SizedBox(height: 12),
                  _buildInfoRow("Dosage", treatment['dosage'] ?? 'N/A'),
                  if (treatment['notes'] != null && treatment['notes'].toString().trim().isNotEmpty) ...[
                    SizedBox(height: 12),
                    _buildNotesSection(treatment['notes']),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          child: Text(
            label + ":",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection(String notes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notes:",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            notes,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIconForTherapyType(String therapyType) {
    switch (therapyType.toLowerCase()) {
      case 'physical therapy':
      case 'physiotherapy':
        return Icons.fitness_center;
      case 'occupational therapy':
        return Icons.engineering;
      case 'speech therapy':
        return Icons.record_voice_over;
      case 'medication':
        return Icons.medication;
      case 'massage':
        return Icons.spa;
      case 'hydrotherapy':
        return Icons.pool;
      case 'exercise':
        return Icons.directions_run;
      default:
        return Icons.healing;
    }
  }
}