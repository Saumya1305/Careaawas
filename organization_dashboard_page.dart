import 'package:flutter/material.dart';
import 'organization_total_doctors_page.dart';
import 'organization_total_patient_page.dart';
import 'doctor_management_page.dart';
import 'patient_management_page.dart';
import 'organization_trackNgoActivity_page.dart';
import 'organization_setting_page.dart';
import 'role_selection_page.dart';
import 'organization_anlytics_page.dart';
import 'organization_help_page.dart';
import 'organization_ContactUs_page.dart';
import 'organization_AboutUs_page.dart';
import 'organization_TrackDonation_page.dart';
import 'organization_DonationStatistics_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrganizationDashboardPage extends StatelessWidget {
  final int ngoId;

  const OrganizationDashboardPage({super.key, required this.ngoId});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NGO ID: $ngoId',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            const Text(
              'Careआवास',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RoleSelectionPage()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.teal.shade800,
        ),
        child: Stack(
          children: [
            _buildBackgroundDecorations(),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<Map<String, dynamic>>(
                          future: _fetchDashboardData(ngoId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  'Error loading data',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            final data = snapshot.data!;
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 24),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildQuickStat(
                                          context,
                                          'Total Doctors',
                                          data['totalDoctors'],
                                          Icons.medical_services,
                                          ngoId),
                                      _buildQuickStat(
                                          context,
                                          'Active Patients',
                                          data['activePatients'],
                                          Icons.people,
                                          ngoId),
                                      // _buildQuickStat(
                                      //     context,
                                      //     'Today\'s Cases',
                                      //     data['todaysCases'],
                                      //     Icons.calendar_today,
                                      //     ngoId),
                                    ],
                                  ),
                                ),
                                _buildGridOptions(context),
                              ],
                            );
                          },
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

  Widget _buildQuickStat(BuildContext context, String title, String value,
      IconData icon, int ngoId) {
    return GestureDetector(
      onTap: () {
        if (title == 'Total Doctors') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrganizationTotalDoctorsPage(
                    ngoId: int.parse(ngoId.toString()))),
          );
        } else if (title == 'Active Patients') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActivePatientsScreen(ngoId: ngoId)),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridOptions(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: [
        _buildDashboardButton(
          context,
          icon: Icons.local_hospital,
          label: 'Manage\nDoctors',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorManagementPage(ngoId: ngoId)),
            );
          },
        ),
        _buildDashboardButton(
          context,
          icon: Icons.people,
          label: 'Manage\nPatients',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PatientManagementPage(ngoId: ngoId)),
            );
          },
        ),
        _buildDashboardButton(
          context,
          icon: Icons.track_changes,
          label: 'Track NGO\nActivity',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrackNgoActivityPage()),
            );
          },
        ),
        _buildDashboardButton(
          context,
          icon: Icons.people,
          label: 'Donation\nTrack',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DonationTrackingPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal.shade800,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal.shade900,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.apartment, size: 40, color: Colors.teal),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home', () {
              Navigator.pop(context);
              // Already on home page, so just close drawer
            }),
            _buildDrawerItem(Icons.contact_page, 'Contact Us', () {
              Navigator.pop(context);
              // Add contact page navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            }),
            _buildDrawerItem(Icons.info, 'About', () {
              Navigator.pop(context);
              // Add about page navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            }),
            _buildDrawerItem(Icons.settings, 'Help', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            }),
            _buildDrawerItem(Icons.settings, 'Settings', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDashboardButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(
                icon,
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
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
      ],
    );
  }

  Future<Map<String, dynamic>> _fetchDashboardData(int ngoId) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'totalDoctors': '*',
      'activePatients': '*',
      // 'todaysCases': '*',
    };
  }
}



// import 'package:flutter/material.dart';
// import 'organization_total_doctors_page.dart';
// import 'organization_Total_patient_page.dart';
// import 'doctor_management_page.dart';
// import 'patient_management_page.dart';
// import 'organization_trackNgoActivity_page.dart';
// import 'organization_setting_page.dart';
// import 'role_selection_page.dart';
// import 'organization_anlytics_page.dart';
// import 'organization_help_page.dart';
// import 'organization_ContactUs_page.dart';
// import 'organization_AboutUs_page.dart';
// import 'organization_TrackDonation_page.dart';
// import 'organization_DonationStatistics_page.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OrganizationDashboardPage extends StatelessWidget {
//   final int ngoId;

//   const OrganizationDashboardPage({super.key, required this.ngoId});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Careआवास',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             fontSize: 24.0,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.teal.shade800,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => RoleSelectionPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(context),
//       body: Container(
//         height: screenHeight,
//         decoration: BoxDecoration(
//           color: Colors.teal.shade800,
//         ),
//         child: Stack(
//           children: [
//             _buildBackgroundDecorations(),
//             CustomScrollView(
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.only(left: 8.0, bottom: 20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Welcome back!',
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Dashboard',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 28.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         FutureBuilder<Map<String, dynamic>>(
//                           future: _fetchDashboardData(ngoId),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                 child: CircularProgressIndicator(
//                                     color: Colors.white),
//                               );
//                             } else if (snapshot.hasError) {
//                               return const Center(
//                                 child: Text(
//                                   'Error loading data',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               );
//                             }

//                             final data = snapshot.data!;
//                             return Column(
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(bottom: 24),
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       _buildQuickStat(
//                                           context,
//                                           'Total Doctors',
//                                           data['totalDoctors'],
//                                           Icons.medical_services,
//                                           ngoId),
//                                       _buildQuickStat(
//                                           context,
//                                           'Active Patients',
//                                           data['activePatients'],
//                                           Icons.people,
//                                           ngoId),
//                                       _buildQuickStat(
//                                           context,
//                                           'Today\'s Cases',
//                                           data['todaysCases'],
//                                           Icons.calendar_today,
//                                           ngoId),
//                                     ],
//                                   ),
//                                 ),
//                                 _buildGridOptions(context),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickStat(BuildContext context, String title, String value,
//       IconData icon, int ngoId) {
//     return GestureDetector(
//       onTap: () {
//         if (title == 'Total Doctors') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => OrganizationTotalDoctorsPage(
//                     ngoId: int.parse(ngoId.toString()))),
//           );
//         } else if (title == 'Active Patients') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     OrganizationTotalPatientsPage(ngoId: ngoId)),
//           );
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white70, size: 24),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGridOptions(BuildContext context) {
//     return GridView(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1.1,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       children: [
//         _buildDashboardButton(
//           context,
//           icon: Icons.local_hospital,
//           label: 'Manage\nDoctors',
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => DoctorManagementPage(ngoId: ngoId)),
//             );
//           },
//         ),
//         _buildDashboardButton(
//           context,
//           icon: Icons.people,
//           label: 'Manage\nPatients',
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => PatientManagementPage(ngoId: ngoId)),
//             );
//           },
//         ),
//         _buildDashboardButton(
//           context,
//           icon: Icons.track_changes,
//           label: 'Track NGO\nActivity',
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => TrackNgoActivityPage()),
//             );
//           },
//         ),
//         _buildDashboardButton(
//           context,
//           icon: Icons.people,
//           label: 'Donation\nTrack',
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => DonationTrackingPage()),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: Colors.teal.shade800,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.teal.shade900,
//               ),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.apartment, size: 40, color: Colors.teal),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Menu',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _buildDrawerItem(Icons.home, 'Home', () {
//               Navigator.pop(context);
//               // Already on home page, so just close drawer
//             }),
//             _buildDrawerItem(Icons.contact_page, 'Contact Us', () {
//               Navigator.pop(context);
//               // Add contact page navigation
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ContactUsPage()),
//               );
//             }),
//             _buildDrawerItem(Icons.info, 'About', () {
//               Navigator.pop(context);
//               // Add about page navigation
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AboutUsPage()),
//               );
//             }),
//             _buildDrawerItem(Icons.settings, 'Help', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HelpPage()),
//               );
//             }),
//             _buildDrawerItem(Icons.settings, 'Settings', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsPage()),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.white),
//       title: Text(
//         title,
//         style: const TextStyle(color: Colors.white),
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _buildDashboardButton(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.teal.shade400,
//               Colors.teal.shade600,
//             ],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.2),
//               ),
//               child: Icon(
//                 icon,
//                 size: 32,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackgroundDecorations() {
//     return Stack(
//       children: [
//         Positioned(
//           top: -50,
//           right: -50,
//           child: Container(
//             width: 200,
//             height: 200,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [Colors.teal.shade600, Colors.transparent],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: -100,
//           left: -100,
//           child: Container(
//             width: 300,
//             height: 300,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [Colors.teal.shade600, Colors.transparent],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<Map<String, dynamic>> _fetchDashboardData(int ngoId) async {
//     await Future.delayed(const Duration(seconds: 2));
//     return {
//       'totalDoctors': '4',
//       'activePatients': '3',
//       'todaysCases': '3',
//     };
//   }
// }