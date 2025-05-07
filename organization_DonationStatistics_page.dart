// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:fl_chart/fl_chart.dart';

// class DonationStatisticsPage extends StatefulWidget {
//   final int ngoId;
//   final Map<String, double> categoryTotals;
//   final double totalDonations;

//   const DonationStatisticsPage({
//     Key? key, 
//     required this.ngoId,
//     required this.categoryTotals,
//     required this.totalDonations,
//   }) : super(key: key);

//   @override
//   _DonationStatisticsPageState createState() => _DonationStatisticsPageState();
// }

// class _DonationStatisticsPageState extends State<DonationStatisticsPage> {
//   bool _isLoading = true;
//   List<Map<String, dynamic>> _monthlyData = [];
//   List<Map<String, dynamic>> _donorStats = [];
//   String _timeRange = 'last6Months';
  
//   @override
//   void initState() {
//     super.initState();
//     _fetchStatistics();
//   }

//   Future<void> _fetchStatistics() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('http://localhost:3000/ngo/donation-statistics/${widget.ngoId}?timeRange=$_timeRange'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         setState(() {
//           _monthlyData = List<Map<String, dynamic>>.from(data['monthlyData']);
//           _donorStats = List<Map<String, dynamic>>.from(data['donorStats']);
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         _showErrorSnackBar('Failed to load statistics');
//       }
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showErrorSnackBar('Error: $error');
      
//       // Use mock data for demonstration
//       _loadMockData();
//     }
//   }
  
//   void _loadMockData() {
//     _monthlyData = [
//       {'month': 'Jan', 'amount': 150000, 'count': 45},
//       {'month': 'Feb', 'amount': 175000, 'count': 52},
//       {'month': 'Mar', 'amount': 120000, 'count': 38},
//       {'month': 'Apr', 'amount': 200000, 'count': 63},
//       {'month': 'May', 'amount': 180000, 'count': 58},
//       {'month': 'Jun', 'amount': 210000, 'count': 70},
//     ];
    
//     _donorStats = [
//       {'type': 'New', 'count': 124, 'percentage': 62},
//       {'type': 'Returning', 'count': 76, 'percentage': 38},
//     ];
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   String _formatCurrency(dynamic amount) {
//     final formatter = NumberFormat.currency(symbol: '₹');
//     return formatter.format(amount);
//   }

//   List<PieChartSectionData> _getCategorySections() {
//     final List<Color> colors = [
//       Colors.blue,
//       Colors.green,
//       Colors.orange,
//       Colors.purple,
//       Colors.red,
//     ];
    
//     final sections = <PieChartSectionData>[];
//     int colorIndex = 0;
    
//     widget.categoryTotals.forEach((category, amount) {
//       final percentage = (amount / widget.totalDonations) * 100;
      
//       sections.add(
//         PieChartSectionData(
//           color: colors[colorIndex % colors.length],
//           value: amount,
//           title: '${percentage.toStringAsFixed(1)}%',
//           radius: 80,
//           titleStyle: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       );
      
//       colorIndex++;
//     });
    
//     return sections;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Donation Statistics',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: _fetchStatistics,
//             tooltip: 'Refresh Data',
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.teal,
//               Colors.teal,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Stack(
//             children: [
//               // Decorative elements
//               Positioned(
//                 top: -100,
//                 left: -100,
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.1),
//                   ),
//                 ),
//               ),
//               _isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       ),
//                     )
//                   : SingleChildScrollView(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Time range selector
//                           Card(
//                             elevation: 4,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: DropdownButtonFormField<String>(
//                                 value: _timeRange,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Time Range',
//                                   border: InputBorder.none,
//                                 ),
//                                 items: const [
//                                   DropdownMenuItem(
//                                     value: 'last6Months',
//                                     child: Text('Last 6 Months'),
//                                   ),
//                                   DropdownMenuItem(
//                                     value: 'lastYear',
//                                     child: Text('Last Year'),
//                                   ),
//                                 ],
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _timeRange = value!;
//                                     _fetchStatistics();
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Total donations card
//                           Card(
//                             elevation: 4,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Total Donations',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     _formatCurrency(widget.totalDonations),
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.teal,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Category distribution chart
//                           Card(
//                             elevation: 4,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Category Distribution',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   SizedBox(
//                                     height: 200,
//                                     child: PieChart(
//                                       PieChartData(
//                                         sections: _getCategorySections(),
//                                         sectionsSpace: 2,
//                                         centerSpaceRadius: 40,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   // Category legend
//                                   Wrap(
//                                     spacing: 16,
//                                     runSpacing: 8,
//                                     children: widget.categoryTotals.entries.map((entry) {
//                                       return Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Container(
//                                             width: 12,
//                                             height: 12,
//                                             decoration: BoxDecoration(
//                                               color: Colors.blue, // You should match this with the chart colors
//                                               shape: BoxShape.circle,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 4),
//                                           Text(entry.key),
//                                         ],
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Monthly trends chart
//                           Card(
//                             elevation: 4,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Monthly Trends',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   SizedBox(
//                                     height: 200,
//                                     child: LineChart(
//                                       LineChartData(
//                                         gridData: FlGridData(show: false),
//                                         titlesData: FlTitlesData(
//                                           leftTitles: AxisTitles(
//                                             sideTitles: SideTitles(
//                                               showTitles: true,
//                                               reservedSize: 40,
//                                               getTitlesWidget: (value, meta) {
//                                                 return Text(
//                                                   _formatCurrency(value),
//                                                   style: const TextStyle(fontSize: 10),
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                           bottomTitles: AxisTitles(
//                                             sideTitles: SideTitles(
//                                               showTitles: true,
//                                               getTitlesWidget: (value, meta) {
//                                                 if (value.toInt() >= 0 && 
//                                                     value.toInt() < _monthlyData.length) {
//                                                   return Text(
//                                                     _monthlyData[value.toInt()]['month'],
//                                                     style: const TextStyle(fontSize: 10),
//                                                   );
//                                                 }
//                                                 return const Text('');
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         borderData: FlBorderData(show: true),
//                                         lineBarsData: [
//                                           LineChartBarData(
//                                             spots: _monthlyData.asMap().entries.map((entry) {
//                                               return FlSpot(
//                                                 entry.key.toDouble(),
//                                                 entry.value['amount'].toDouble(),
//                                               );
//                                             }).toList(),
//                                             isCurved: true,
//                                             color: Colors.white,
//                                             barWidth: 2,
//                                             dotData: FlDotData(show: true),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Donor statistics
//                           Card(
//                             elevation: 4,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Donor Statistics',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   ..._donorStats.map((stat) => Padding(
//                                     padding: const EdgeInsets.only(bottom: 8.0),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           '${stat['type']} Donors',
//                                           style: const TextStyle(fontSize: 16),
//                                         ),
//                                         Text(
//                                           '${stat['count']} (${stat['percentage']}%)',
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )).toList(),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class DonationStatisticsPage extends StatefulWidget {
  final Map<String, double> categoryTotals;
  final double totalDonations;

  const DonationStatisticsPage({
    Key? key, 
    required this.categoryTotals,
    required this.totalDonations,
  }) : super(key: key);

  @override
  _DonationStatisticsPageState createState() => _DonationStatisticsPageState();
}

class _DonationStatisticsPageState extends State<DonationStatisticsPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _monthlyData = [];
  List<Map<String, dynamic>> _donorStats = [];
  String _timeRange = 'last6Months';

  @override
  void initState() {
    super.initState();
    _loadMockData(); // Mock data used here for frontend testing
  }

  void _loadMockData() {
    _monthlyData = [
      {'month': 'Jan', 'amount': 150000, 'count': 45},
      {'month': 'Feb', 'amount': 175000, 'count': 52},
      {'month': 'Mar', 'amount': 120000, 'count': 38},
      {'month': 'Apr', 'amount': 200000, 'count': 63},
      {'month': 'May', 'amount': 180000, 'count': 58},
      {'month': 'Jun', 'amount': 210000, 'count': 70},
    ];

    _donorStats = [
      {'type': 'New', 'count': 124, 'percentage': 62},
      {'type': 'Returning', 'count': 76, 'percentage': 38},
    ];
  }

  String _formatCurrency(dynamic amount) {
    final formatter = NumberFormat.currency(symbol: '₹');
    return formatter.format(amount);
  }

  List<PieChartSectionData> _getCategorySections() {
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];

    final sections = <PieChartSectionData>[];
    int colorIndex = 0;

    widget.categoryTotals.forEach((category, amount) {
      final percentage = (amount / widget.totalDonations) * 100;

      sections.add(
        PieChartSectionData(
          color: colors[colorIndex % colors.length],
          value: amount,
          title: '${percentage.toStringAsFixed(1)}%',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

      colorIndex++;
    });

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donation Statistics',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadMockData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.teal,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative elements
              Positioned(
                top: -100,
                left: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time range selector
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField<String>(
                                value: _timeRange,
                                decoration: const InputDecoration(
                                  labelText: 'Time Range',
                                  border: InputBorder.none,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'last6Months',
                                    child: Text('Last 6 Months'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'lastYear',
                                    child: Text('Last Year'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _timeRange = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Total donations card
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Donations',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _formatCurrency(widget.totalDonations),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Category distribution chart
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Category Distribution',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    height: 200,
                                    child: PieChart(
                                      PieChartData(
                                        sections: _getCategorySections(),
                                        sectionsSpace: 2,
                                        centerSpaceRadius: 40,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Category legend
                                  Wrap(
                                    spacing: 16,
                                    runSpacing: 8,
                                    children: widget.categoryTotals.entries.map((entry) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.blue, // You should match this with the chart colors
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(entry.key),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Monthly trends chart
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Monthly Trends',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    height: 200,
                                    child: LineChart(
                                      LineChartData(
                                        gridData: FlGridData(show: false),
                                        titlesData: FlTitlesData(
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 40,
                                              getTitlesWidget: (value, meta) {
                                                return Text(
                                                  _formatCurrency(value),
                                                  style: const TextStyle(fontSize: 10),
                                                );
                                              },
                                            ),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                if (value.toInt() >= 0 &&
                                                    value.toInt() < _monthlyData.length) {
                                                  return Text(
                                                    _monthlyData[value.toInt()]['month'],
                                                    style: const TextStyle(fontSize: 10),
                                                  );
                                                }
                                                return const Text('');
                                              },
                                            ),
                                          ),
                                        ),
                                        borderData: FlBorderData(show: true),
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: _monthlyData.asMap().entries.map((entry) {
                                              return FlSpot(
                                                entry.key.toDouble(),
                                                entry.value['amount'].toDouble(),
                                              );
                                            }).toList(),
                                            isCurved: true,
                                            color: Colors.white,
                                            barWidth: 2,
                                            dotData: FlDotData(show: true),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Donor statistics
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Donor Statistics',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ..._donorStats.map((stat) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${stat['type']} Donors',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${stat['count']} (${stat['percentage']}%)',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )).toList(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
