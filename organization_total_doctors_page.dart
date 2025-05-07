// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OrganizationTotalDoctorsPage extends StatefulWidget {
//   final int ngoId;

//   const OrganizationTotalDoctorsPage({Key? key, required this.ngoId}) : super(key: key);

//   @override
//   _OrganizationTotalDoctorsPageState createState() => _OrganizationTotalDoctorsPageState();
// }

// class _OrganizationTotalDoctorsPageState extends State<OrganizationTotalDoctorsPage> {
//   List<dynamic> doctors = [];
//   List<dynamic> filteredDoctors = [];
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDoctors();
//   }

//   Future<void> fetchDoctors() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://localhost:3000/doctors/${widget.ngoId}'),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           doctors = json.decode(response.body);
//           filteredDoctors = doctors;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to load doctors')),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     }
//   }

//   void filterDoctors(String query) {
//     setState(() {
//       filteredDoctors = doctors.where((doctor) {
//         final nameLower = doctor['name'].toLowerCase();
//         final degreeLower = doctor['degree'].toLowerCase();
//         final queryLower = query.toLowerCase();
//         return nameLower.contains(queryLower) ||
//                degreeLower.contains(queryLower);
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Total Doctors',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.teal.shade800,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.teal.shade800,
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: searchController,
//                 onChanged: filterDoctors,
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Search doctors by name or degree',
//                   hintStyle: TextStyle(color: Colors.white70),
//                   prefixIcon: Icon(Icons.search, color: Colors.white),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.1),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(color: Colors.white),
//                     )
//                   : filteredDoctors.isEmpty
//                       ? Center(
//                           child: Text(
//                             'No doctors found',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: filteredDoctors.length,
//                           itemBuilder: (context, index) {
//                             final doctor = filteredDoctors[index];
//                             return _buildDoctorCard(doctor);
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDoctorCard(Map<String, dynamic> doctor) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withOpacity(0.2),
//             ),
//             child: Icon(
//               Icons.medical_services,
//               color: Colors.white,
//               size: 32,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   doctor['name'] ?? 'N/A',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Degree: ${doctor['degree'] ?? 'N/A'}',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'License: ${doctor['license'] ?? 'N/A'}',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Contact: ${doctor['mobile'] ?? 'N/A'}',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//aaditya
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OrganizationTotalDoctorsPage extends StatefulWidget {
//   final int ngoId;

//   const OrganizationTotalDoctorsPage({Key? key, required this.ngoId})
//       : super(key: key);

//   @override
//   _OrganizationTotalDoctorsPageState createState() =>
//       _OrganizationTotalDoctorsPageState();
// }

// class _OrganizationTotalDoctorsPageState
//     extends State<OrganizationTotalDoctorsPage> {
//   List<dynamic> doctors = [];
//   List<dynamic> filteredDoctors = [];
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDoctors();
//   }

//   Future<void> fetchDoctors() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://localhost:3000/api/doctors/${widget.ngoId}'),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           doctors = json.decode(response.body);
//           filteredDoctors = doctors;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to load doctors')),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     }
//   }

//   void filterDoctors(String query) {
//     setState(() {
//       filteredDoctors = doctors.where((doctor) {
//         final nameLower = doctor['name'].toLowerCase();
//         final degreeLower = doctor['degree'].toLowerCase();
//         final queryLower = query.toLowerCase();
//         return nameLower.contains(queryLower) ||
//             degreeLower.contains(queryLower);
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Total Doctors',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.teal.shade800,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.teal.shade800,
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: searchController,
//                 onChanged: filterDoctors,
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Search doctors by name or degree',
//                   hintStyle: TextStyle(color: Colors.white70),
//                   prefixIcon: Icon(Icons.search, color: Colors.white),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.1),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(color: Colors.white),
//                     )
//                   : filteredDoctors.isEmpty
//                       ? Center(
//                           child: Text(
//                             'No doctors found',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: filteredDoctors.length,
//                           itemBuilder: (context, index) {
//                             final doctor = filteredDoctors[index];
//                             return _buildDoctorCard(doctor);
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDoctorCard(Map<String, dynamic> doctor) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withOpacity(0.2),
//             ),
//             child: Icon(
//               Icons.medical_services,
//               color: Colors.white,
//               size: 32,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   doctor['name'] ?? 'N/A',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Degree: ${doctor['degree'] ?? 'N/A'}',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'License: ${doctor['license'] ?? 'N/A'}',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Contact: ${doctor['mobile'] ?? 'N/A'}',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
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

class OrganizationTotalDoctorsPage extends StatefulWidget {
  final int ngoId;

  const OrganizationTotalDoctorsPage({super.key, required this.ngoId});

  @override
  _OrganizationTotalDoctorsPageState createState() =>
      _OrganizationTotalDoctorsPageState();
}

class _OrganizationTotalDoctorsPageState
    extends State<OrganizationTotalDoctorsPage> {
  List<dynamic> doctors = [];
  List<dynamic> filteredDoctors = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      final response = await http.get(
          // Uri.parse('http://localhost:3000/api/doctors/${widget.ngoId}'),
          Uri.parse('http://172.21.81.6:3000/ngo/${widget.ngoId}/doctor'));

      if (response.statusCode == 200) {
        setState(() {
          final data = json.decode(response.body);
          setState(() {
            doctors = data['doctors']; // Extract the correct key
            filteredDoctors = doctors;
            isLoading = false;
          });
          filteredDoctors = doctors;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load doctors')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void filterDoctors(String query) {
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        final nameLower = doctor['name'].toLowerCase();
        final degreeLower = doctor['degree'].toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower) ||
            degreeLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Total Doctors',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade800,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                onChanged: filterDoctors,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search doctors by name or degree',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : filteredDoctors.isEmpty
                      ? Center(
                          child: Text(
                            'No doctors found',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredDoctors.length,
                          itemBuilder: (context, index) {
                            final doctor = filteredDoctors[index];
                            return _buildDoctorCard(doctor);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(
              Icons.medical_services,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'] ?? 'N/A',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Degree: ${doctor['degree'] ?? 'N/A'}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'License: ${doctor['license'] ?? 'N/A'}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Contact: ${doctor['mobile'] ?? 'N/A'}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
