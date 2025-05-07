// import 'package:flutter/material.dart';

// class TrackNgoActivityPage extends StatelessWidget {
//   const TrackNgoActivityPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Track NGO Activity',
//           style: TextStyle(
//             fontFamily: 'Roboto',
//             fontWeight: FontWeight.bold,
//             fontSize: 24.0,
//           ),
//         ),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             _buildSectionTitle('Activity Overview'),
//             _buildActivityOverview(),
//             _buildSectionTitle('Recent Activities'),
//             _buildRecentActivities(),
//             _buildSectionTitle('Reports and Analytics'),
//             _buildReportsAnalytics(),
//             _buildSectionTitle('Activity Logs'),
//             _buildActivityLogs(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 20.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityOverview() {
//     // This could be a simple summary of key stats like number of patients treated, etc.
//     return Card(
//       elevation: 4.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text('Total Patients Treated: 120'),
//             SizedBox(height: 8.0),
//             Text('Total Doctors Added: 15'),
//             SizedBox(height: 8.0),
//             Text('Events Held: 5'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecentActivities() {
//     // Display a list of recent activities like adding doctors, patients, etc.
//     return Card(
//       elevation: 4.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             ListTile(
//               title: Text('Doctor Dr. John added to the system'),
//               subtitle: Text('Date: 2025-01-10'),
//             ),
//             ListTile(
//               title: Text('Patient Rajesh Kumar registered'),
//               subtitle: Text('Date: 2025-01-09'),
//             ),
//             ListTile(
//               title: Text('Event on Addiction Awareness conducted'),
//               subtitle: Text('Date: 2025-01-05'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildReportsAnalytics() {
//     // Placeholder for reports and analytics, could use charts or stats.
//     return Card(
//       elevation: 4.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Monthly Report: January 2025',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             // Here, you can use a chart package to display performance data, for example:
//             // - Patients treated this month
//             // - Number of new doctors
//             // - Event participation rates
//             const Text('Patient Treatment Progress: 75%'),
//             const SizedBox(height: 8.0),
//             const Text('Doctor Registration Rate: 80%'),
//             const SizedBox(height: 8.0),
//             const Text('Event Attendance: 90%'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityLogs() {
//     // Display logs of actions taken by the organization.
//     return Card(
//       elevation: 4.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             ListTile(
//               title: Text('Action: Patient added'),
//               subtitle: Text('Performed by: Admin | Date: 2025-01-10'),
//             ),
//             ListTile(
//               title: Text('Action: Doctor added'),
//               subtitle: Text('Performed by: Admin | Date: 2025-01-09'),
//             ),
//             ListTile(
//               title: Text('Action: Event conducted'),
//               subtitle: Text('Performed by: Admin | Date: 2025-01-05'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrackNgoActivityPage extends StatelessWidget {
  const TrackNgoActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Colorful data for the bar chart
    final List<BarChartGroupData> barGroups = [
      BarChartGroupData(
          x: 0,
          barRods: [BarChartRodData(toY: 12, color: Colors.purple.shade300)]),
      BarChartGroupData(
          x: 1,
          barRods: [BarChartRodData(toY: 15, color: Colors.blue.shade300)]),
      BarChartGroupData(
          x: 2,
          barRods: [BarChartRodData(toY: 18, color: Colors.green.shade300)]),
      BarChartGroupData(
          x: 3,
          barRods: [BarChartRodData(toY: 14, color: Colors.orange.shade300)]),
      BarChartGroupData(
          x: 4,
          barRods: [BarChartRodData(toY: 20, color: Colors.red.shade300)]),
      BarChartGroupData(
          x: 5,
          barRods: [BarChartRodData(toY: 25, color: Colors.pink.shade300)]),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set to white color
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'NGO Activity Dashboard',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
      ),
      body: Container(
        height: screenHeight,
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
            // Main content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Stats Cards
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _buildStatCard(
                          title: 'Total Patients',
                          value: '245',
                          icon: Icons.people,
                          iconColor: Colors.blue.shade300,
                        ),
                        _buildStatCard(
                          title: 'Recovered',
                          value: '65',
                          icon: Icons.health_and_safety,
                          iconColor: Colors.green.shade300,
                        ),
                        _buildStatCard(
                          title: 'Success Rate',
                          value: '78%',
                          icon: Icons.trending_up,
                          iconColor: Colors.purple.shade300,
                        ),
                        _buildStatCard(
                          title: 'Active Cases',
                          value: '180',
                          icon: Icons.medical_services,
                          iconColor: Colors.orange.shade300,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Recovery Progress Chart
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.15), // More translucent white
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recovery Progress',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 30,
                                barGroups: barGroups,
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(color: Colors.white30),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 5,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.white10,
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        const months = [
                                          'Jan',
                                          'Feb',
                                          'Mar',
                                          'Apr',
                                          'May',
                                          'Jun'
                                        ];
                                        return Text(
                                          months[value.toInt()],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Recent Activity
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.15), // More translucent white
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent Activity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildActivityItem(
                            'Dr. Sarah Smith',
                            'New Doctor Joined',
                            '2 hours ago',
                            Icons.person_add,
                            Colors.blue.shade300,
                          ),
                          _buildActivityItem(
                            'John Doe',
                            'New Patient Admitted',
                            '5 hours ago',
                            Icons.personal_injury,
                            Colors.purple.shade300,
                          ),
                          _buildActivityItem(
                            'Mike Johnson',
                            'Successfully Recovered',
                            '1 day ago',
                            Icons.health_and_safety,
                            Colors.green.shade300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
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
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
