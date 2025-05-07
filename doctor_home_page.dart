// import 'package:flutter/material.dart';
// import 'role_selection_page.dart';
// import 'patient_list_page.dart';
// import 'doctor_patient_Vital_page.dart';
// import 'organization_setting_page.dart';
// import 'organization_help_page.dart';
// import 'organization_ContactUs_page.dart';
// import 'organization_AboutUs_page.dart';
// import 'chatbot.dart';

// class DoctorHomePage extends StatelessWidget {
//   final int doctorId;

//   const DoctorHomePage({super.key, required this.doctorId});

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
//           // Display Doctor ID in the app bar
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Center(
//               child: Text(
//                 'Doctor ID: $doctorId',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const RoleSelectionPage()),
//                 (route) => false,
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
//             Positioned(
//               top: -50,
//               right: -50,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [Colors.teal.shade600, Colors.transparent],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               left: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [Colors.teal.shade600, Colors.transparent],
//                   ),
//                 ),
//               ),
//             ),
//             CustomScrollView(
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 8.0, bottom: 20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Hello, Doctor! (ID: $doctorId)',
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               const Text(
//                                 'Your Dashboard',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 28.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GridView(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 1.1,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                           ),
//                           children: [
//                             _buildDashboardButton(
//                               context,
//                               icon: Icons.list,
//                               label: 'Patient List',
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         PatientListPage(doctorId: doctorId),
//                                   ),
//                                 );
//                               },
//                             ),
//                             _buildDashboardButton(
//                               context,
//                               icon: Icons.chat,
//                               label: 'Consultations',
//                               onPressed: () {
//                                 // Handle Consultations
//                               },
//                             ),
//                             _buildDashboardButton(
//                               context,
//                               icon: Icons.folder,
//                               label: 'Medical Records',
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => PatientVitalsPage(
//                                       patientId: 1,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             _buildDashboardButton(
//                               context,
//                               icon: Icons.medication,
//                               label: 'Prescriptions',
//                               onPressed: () {
//                                 // Handle Prescriptions
//                               },
//                             ),
//                           ],
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
//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: () {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => PatientVitalsPage(), // Navigate to Chatbot Page
//       //       ),
//       //     );
//       //   },
//       //   backgroundColor: Colors.teal.shade700,
//       //   icon: const Icon(Icons.chat, color: Colors.white),
//       //   label: const Text(
//       //     "Hey Doc",
//       //     style: TextStyle(color: Colors.white, fontSize: 14),
//       //   ),
//       //   elevation: 6,
//       //   shape:
//       //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//       // ),
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
//                     child: Icon(Icons.medical_services,
//                         size: 40, color: Colors.teal),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Doctor Menu',
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
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ContactUsPage()),
//               );
//             }),
//             _buildDrawerItem(Icons.info, 'About', () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AboutUsPage()),
//               );
//             }),
//             _buildDrawerItem(Icons.help, 'Help', () {
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
// }

import 'package:flutter/material.dart';
import 'role_selection_page.dart';
import 'patient_list_page.dart';
import 'doctor_patient_Vital_page.dart';
import 'organization_setting_page.dart';
import 'organization_help_page.dart';
import 'organization_ContactUs_page.dart';
import 'organization_AboutUs_page.dart';
import 'chatbot.dart';
import 'doctor_myaccount_page.dart';

class DoctorHomePage extends StatelessWidget {
  final int doctorId;

  const DoctorHomePage({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Careआवास',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
        actions: [
          // Display Doctor ID in the app bar
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Doctor ID: $doctorId',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const RoleSelectionPage()),
                (route) => false,
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
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, Doctor! (ID: $doctorId)',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Your Dashboard',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          children: [
                            _buildDashboardButton(
                              context,
                              icon: Icons.list,
                              label: 'Patient List',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PatientListPage(doctorId: doctorId),
                                  ),
                                );
                              },
                            ),
                            _buildDashboardButton(
                              context,
                              icon: Icons.chat,
                              label: 'My Account',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorMyAccountPage(doctorId: doctorId),
                                  ),
                                );
                              },
                            ),
                            // _buildDashboardButton(
                            //   context,
                            //   icon: Icons.folder,
                            //   label: 'Medical Records',
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => PatientVitalsPage(
                            //           patientId: 1,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            // _buildDashboardButton(
                            //   context,
                            //   icon: Icons.medication,
                            //   label: 'Prescriptions',
                            //   onPressed: () {
                            //     // Handle Prescriptions
                            //   },
                            // ),
                          ],
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatBotScreen(), // Navigate to Chatbot Page
            ),
          );
        },
        backgroundColor: Colors.teal.shade700,
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text(
          "Hey Doc",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        elevation: 6,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
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
                    child: Icon(Icons.medical_services,
                        size: 40, color: Colors.teal),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Doctor Menu',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            }),
            _buildDrawerItem(Icons.info, 'About', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            }),
            _buildDrawerItem(Icons.help, 'Help', () {
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
}
