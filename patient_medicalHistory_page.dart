// import 'package:flutter/material.dart';
// //import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class MedicalHistoryPage extends StatefulWidget {
//   const MedicalHistoryPage({Key? key}) : super(key: key);

//   @override
//   _MedicalHistoryPageState createState() => _MedicalHistoryPageState();
// }

// class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
//   final TextEditingController _searchController = TextEditingController();
//   final List<Map<String, dynamic>> _medicalRecords = [
//     {
//       'name': 'John Doe',
//       'age': 35,
//       'drugAddiction': true,
//       'treatmentHistory': [
//         {
//           'date': '2022-03-15',
//           'treatment': 'Rehabilitation Program',
//           'duration': '3 months',
//           'status': 'Completed'
//         },
//         {
//           'date': '2023-01-10',
//           'treatment': 'Counseling Sessions',
//           'duration': 'Ongoing',
//           'status': 'In Progress'
//         }
//       ],
//       'additionalConditions': ['Anxiety', 'Hypertension']
//     },
//     {
//       'name': 'Jane Smith',
//       'age': 28,
//       'drugAddiction': false,
//       'additionalConditions': ['Diabetes']
//     }
//   ];

//   List<Map<String, dynamic>> _filteredRecords = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredRecords = _medicalRecords;
//   }

//   void _searchRecords(String query) {
//     setState(() {
//       _filteredRecords = _medicalRecords
//           .where((record) =>
//               record['name'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF0D9488),
//               const Color(0xFF14B8A6),
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Gradient Circles from SupportPage
//             Positioned(
//               top: -50,
//               left: -50,
//               child: Container(
//                 width: 250,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   color: Colors.teal[600]?.withOpacity(0.3),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -50,
//               right: -50,
//               child: Container(
//                 width: 250,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   color: Colors.teal[600]?.withOpacity(0.3),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             SafeArea(
//               child: Column(
//                 children: [
//                   // Navigation Bar
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back, color: Colors.white),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         const SizedBox(width: 10),
//                         const Text(
//                           'Medical History',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
                  
//                   // Search Bar
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       controller: _searchController,
//                       onChanged: _searchRecords,
//                       decoration: InputDecoration(
//                         hintText: 'Search medical records',
//                         prefixIcon: const Icon(Icons.search, color: Colors.white),
//                         fillColor: Colors.white.withOpacity(0.2),
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                         hintStyle: const TextStyle(color: Colors.white70),
//                       ),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // Medical Records List
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: ListView.builder(
//                         itemCount: _filteredRecords.length,
//                         itemBuilder: (context, index) {
//                           var record = _filteredRecords[index];
//                           return _buildMedicalRecordTile(record);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMedicalRecordTile(Map<String, dynamic> record) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               record['name'],
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Age: ${record['age']}',
//               style: const TextStyle(color: Colors.white70),
//             ),
//             if (record['drugAddiction'] == true) ...[
//               const SizedBox(height: 10),
//               const Text(
//                 'Drug Addiction Treatment History:',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               ...record['treatmentHistory']?.map((treatment) => Text(
//                     '• ${treatment['date']}: ${treatment['treatment']} (${treatment['status']})',
//                     style: const TextStyle(color: Colors.white70),
//                   )) ?? []
//             ],
//             if (record['additionalConditions'] != null) ...[
//               const SizedBox(height: 10),
//               const Text(
//                 'Additional Health Conditions:',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               ...record['additionalConditions'].map((condition) => Text(
//                     '• $condition',
//                     style: const TextStyle(color: Colors.white70),
//                   ))
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MedicalHistoryPage extends StatefulWidget {
  const MedicalHistoryPage({super.key});

  @override
  _MedicalHistoryPageState createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _medicalRecords = [
    {
      'name': 'John Doe',
      'age': 35,
      'drugAddiction': true,
      'treatmentHistory': [
        {
          'date': '2022-03-15',
          'treatment': 'Rehabilitation Program',
          'duration': '3 months',
          'status': 'Completed'
        },
        {
          'date': '2023-01-10',
          'treatment': 'Counseling Sessions',
          'duration': 'Ongoing',
          'status': 'In Progress'
        }
      ],
      'additionalConditions': ['Anxiety', 'Hypertension']
    },
    {
      'name': 'Jane Smith',
      'age': 28,
      'drugAddiction': false,
      'additionalConditions': ['Diabetes']
    }
  ];

  List<Map<String, dynamic>> _filteredRecords = [];

  @override
  void initState() {
    super.initState();
    _filteredRecords = _medicalRecords;
  }

  void _searchRecords(String query) {
    setState(() {
      _filteredRecords = _medicalRecords
          .where((record) =>
              record['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0D9488),
              const Color(0xFF14B8A6),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Gradient Circles from SupportPage
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.teal[600]?.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              right: -50,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.teal[600]?.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // Navigation Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Medical History',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _searchRecords,
                      decoration: InputDecoration(
                        hintText: 'Search medical records',
                        prefixIcon: const Icon(Icons.search, color: Colors.white),
                        fillColor: Colors.white.withOpacity(0.2),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Medical Records List
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: _filteredRecords.length,
                        itemBuilder: (context, index) {
                          var record = _filteredRecords[index];
                          return _buildMedicalRecordTile(record);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalRecordTile(Map<String, dynamic> record) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record['name'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Age: ${record['age']}',
              style: const TextStyle(color: Colors.white70),
            ),
            if (record['drugAddiction'] == true) ...[
              const SizedBox(height: 10),
              const Text(
                'Drug Addiction Treatment History:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...record['treatmentHistory']?.map((treatment) => Text(
                    '• ${treatment['date']}: ${treatment['treatment']} (${treatment['status']})',
                    style: const TextStyle(color: Colors.white70),
                  )) ?? []
            ],
            if (record['additionalConditions'] != null) ...[
              const SizedBox(height: 10),
              const Text(
                'Additional Health Conditions:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...record['additionalConditions'].map((condition) => Text(
                    '• $condition',
                    style: const TextStyle(color: Colors.white70),
                  ))
            ]
          ],
        ),
      ),
    );
  }
}
