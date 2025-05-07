// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:intl/intl.dart';
// // import 'organization_DonationDetails_page.dart';
// // import 'organization_ThankYou_page.dart';
// // import 'organization_DonationStatistics_page.dart';

// // class DonationTrackingPage extends StatefulWidget {
// //   final int ngoId;

// //   const DonationTrackingPage({Key? key, required this.ngoId}) : super(key: key);

// //   @override
// //   _DonationTrackingPageState createState() => _DonationTrackingPageState();
// // }

// // class _DonationTrackingPageState extends State<DonationTrackingPage> {
// //   List<Map<String, dynamic>> _donations = [];
// //   bool _isLoading = true;
// //   String _filterCategory = 'All';
// //   String _searchQuery = '';
// //   String _sortBy = 'date';
// //   bool _sortAscending = false;
// //   Map<String, double> _categoryTotals = {};
// //   double _totalDonations = 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchDonations();
// //   }

// //   Future<void> _fetchDonations() async {
// //     setState(() {
// //       _isLoading = true;
// //     });

// //     try {
// //       final response = await http.get(
// //         Uri.parse('http://localhost:3000/ngo/donations/${widget.ngoId}'),
// //         headers: {'Content-Type': 'application/json'},
// //       );

// //       if (response.statusCode == 200) {
// //         final List<dynamic> donationsData = json.decode(response.body);
// //         setState(() {
// //           _donations = List<Map<String, dynamic>>.from(donationsData);
// //           _calculateStats();
// //           _sortDonations();
// //           _isLoading = false;
// //         });
// //       } else {
// //         setState(() {
// //           _isLoading = false;
// //         });
// //         _showErrorSnackBar('Failed to load donations');
// //       }
// //     } catch (error) {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //       _showErrorSnackBar('Error: $error');
// //     }
// //   }

// //   void _calculateStats() {
// //     _categoryTotals = {};
// //     _totalDonations = 0;


// //     for (var donation in _donations) {
// //       final category = donation['category'] ?? 'Other';
// //       final amount = double.tryParse(donation['amount'].toString()) ?? 0;
      
// //       _categoryTotals[category] = (_categoryTotals[category] ?? 0) + amount;
// //       _totalDonations += amount;
// //     }
// //   }

// //   void _sortDonations() {
// //     _donations.sort((a, b) {
// //       dynamic valueA, valueB;
      
// //       switch (_sortBy) {
// //         case 'date':
// //           valueA = DateTime.parse(a['donation_date'].toString());
// //           valueB = DateTime.parse(b['donation_date'].toString());
// //           break;
// //         case 'amount':
// //           valueA = double.tryParse(a['amount'].toString()) ?? 0;
// //           valueB = double.tryParse(b['amount'].toString()) ?? 0;
// //           break;
// //         case 'name':
// //           valueA = a['donor_name'].toString();
// //           valueB = b['donor_name'].toString();
// //           break;
// //         default:
// //           valueA = DateTime.parse(a['donation_date'].toString());
// //           valueB = DateTime.parse(b['donation_date'].toString());
// //       }

// //       int comparison;
// //       if (valueA is DateTime && valueB is DateTime) {
// //         comparison = valueA.compareTo(valueB);
// //       } else if (valueA is num && valueB is num) {
// //         comparison = valueA.compareTo(valueB);
// //       } else {
// //         comparison = valueA.toString().compareTo(valueB.toString());
// //       }

// //       return _sortAscending ? comparison : -comparison;
// //     });
// //   }











// //   List<Map<String, dynamic>> _getFilteredDonations() {
// //     return _donations.where((donation) {
// //       // Category filter
// //       bool matchesCategory = _filterCategory == 'All' || 
// //                             donation['category'] == _filterCategory;
      
// //       // Search query filter
// //       bool matchesSearch = _searchQuery.isEmpty || 
// //                           donation['donor_name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
// //                           donation['donation_id'].toString().contains(_searchQuery);
      
// //       return matchesCategory && matchesSearch;
// //     }).toList();
// //   }

// //   void _showErrorSnackBar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         backgroundColor: Colors.red,
// //         duration: const Duration(seconds: 3),
// //       ),
// //     );
// //   }

// //   void _viewDonationDetails(Map<String, dynamic> donation) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => DonationDetailsPage(donation: donation),
// //       ),
// //     );
// //   }

// //   void _sendThankYouMessage(Map<String, dynamic> donation) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => ThankYouMessagePage(
// //           donorId: donation['donor_id'],
// //           donorName: donation['donor_name'],
// //           donationAmount: donation['amount'],
// //           donationDate: donation['donation_date'],
// //         ),
// //       ),
// //     );
// //   }

// //   void _viewStatistics() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => DonationStatisticsPage(
// //           ngoId: widget.ngoId,
// //           categoryTotals: _categoryTotals,
// //           totalDonations: _totalDonations,
// //         ),
// //       ),
// //     );
// //   }

// //   String _formatCurrency(dynamic amount) {
// //     final formatter = NumberFormat.currency(symbol: '₹');
// //     return formatter.format(double.tryParse(amount.toString()) ?? 0);
// //   }

// //   String _formatDate(String dateStr) {
// //     final date = DateTime.parse(dateStr);
// //     return DateFormat('MMM dd, yyyy').format(date);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final filteredDonations = _getFilteredDonations();
    
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Donation Tracking',
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         backgroundColor: Colors.teal,
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.bar_chart, color: Colors.white),
// //             onPressed: _viewStatistics,
// //             tooltip: 'View Statistics',
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.refresh, color: Colors.white),
// //             onPressed: _fetchDonations,
// //             tooltip: 'Refresh Data',
// //           ),
// //         ],
// //       ),
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Colors.teal,
// //               Colors.teal,
// //             ],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: Stack(
// //             children: [
// //               // Decorative elements (same as login page)
// //               Positioned(
// //                 top: -100,
// //                 left: -100,
// //                 child: Container(
// //                   width: 200,
// //                   height: 200,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         Colors.white.withOpacity(0.3),
// //                         Colors.white.withOpacity(0.1),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Positioned(
// //                 bottom: -100,
// //                 right: -100,
// //                 child: Container(
// //                   width: 200,
// //                   height: 200,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         Colors.white.withOpacity(0.3),
// //                         Colors.white.withOpacity(0.1),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               // Main content
// //               Column(
// //                 children: [
// //                   // Stats cards
// //                   Container(
// //                     padding: const EdgeInsets.all(16),
// //                     child: Row(
// //                       children: [
// //                         Expanded(
// //                           child: _buildStatCard(
// //                             'Total Donations',
// //                             _formatCurrency(_totalDonations),
// //                             Icons.monetization_on,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 16),
// //                         Expanded(
// //                           child: _buildStatCard(
// //                             'Donors',
// //                             _donations.map((d) => d['donor_id']).toSet().length.toString(),
// //                             Icons.people,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   // Search and filter options
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 16),
// //                     child: Card(
// //                       elevation: 4,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(16),
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(16),
// //                         child: Column(
// //                           children: [
// //                             TextField(
// //                               decoration: InputDecoration(
// //                                 labelText: 'Search donor name or ID',
// //                                 prefixIcon: Icon(Icons.search, color: Colors.teal),
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   borderSide: BorderSide(color: Colors.teal, width: 2),
// //                                 ),
// //                                 labelStyle: TextStyle(color: Colors.teal),
// //                               ),
// //                               onChanged: (value) {
// //                                 setState(() {
// //                                   _searchQuery = value;
// //                                 });
// //                               },
// //                             ),
// //                             const SizedBox(height: 16),
// //                             Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: _buildDropdownFilter(
// //                                     'Category',
// //                                     _filterCategory,
// //                                     ['All', 'Education', 'Food & Nutrition', 'Medical Treatment', 'Emergency Relief', 'Other'],
// //                                     (value) {
// //                                       setState(() {
// //                                         _filterCategory = value!;
// //                                       });
// //                                     },
// //                                   ),
// //                                 ),
// //                                 const SizedBox(width: 16),
// //                                 Expanded(
// //                                   child: _buildDropdownFilter(
// //                                     'Sort By',
// //                                     _sortBy,
// //                                     ['date', 'amount', 'name'],
// //                                     (value) {
// //                                       setState(() {
// //                                         _sortBy = value!;
// //                                         _sortDonations();
// //                                       });
// //                                     },
// //                                   ),
// //                                 ),
// //                                 IconButton(
// //                                   icon: Icon(
// //                                     _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
// //                                     color: Colors.teal,
// //                                   ),
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _sortAscending = !_sortAscending;
// //                                       _sortDonations();
// //                                     });
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
                  
// //                   // Donation list
// //                   Expanded(
// //                     child: _isLoading
// //                         ? const Center(
// //                             child: CircularProgressIndicator(
// //                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// //                             ),
// //                           )
// //                         : filteredDonations.isEmpty
// //                             ? Center(
// //                                 child: Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     Icon(
// //                                       Icons.sentiment_dissatisfied,
// //                                       size: 64,
// //                                       color: Colors.white.withOpacity(0.8),
// //                                     ),
// //                                     const SizedBox(height: 16),
// //                                     Text(
// //                                       'No donations found',
// //                                       style: TextStyle(
// //                                         color: Colors.white,
// //                                         fontSize: 18,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               )
// //                             : Padding(
// //                                 padding: const EdgeInsets.all(16),
// //                                 child: ListView.builder(
// //                                   itemCount: filteredDonations.length,
// //                                   itemBuilder: (context, index) {
// //                                     final donation = filteredDonations[index];
// //                                     final isAnonymous = donation['is_anonymous'] == true;
                                    
// //                                     return Card(
// //                                       elevation: 4,
// //                                       margin: const EdgeInsets.only(bottom: 16),
// //                                       shape: RoundedRectangleBorder(
// //                                         borderRadius: BorderRadius.circular(16),
// //                                       ),
// //                                       child: InkWell(
// //                                         onTap: () => _viewDonationDetails(donation),
// //                                         borderRadius: BorderRadius.circular(16),
// //                                         child: Padding(
// //                                           padding: const EdgeInsets.all(16),
// //                                           child: Column(
// //                                             crossAxisAlignment: CrossAxisAlignment.start,
// //                                             children: [
// //                                               Row(
// //                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                                 children: [
// //                                                   Expanded(
// //                                                     child: Text(
// //                                                       isAnonymous ? 'Anonymous Donor' : donation['donor_name'],
// //                                                       style: const TextStyle(
// //                                                         fontSize: 18,
// //                                                         fontWeight: FontWeight.bold,
// //                                                         color: Colors.teal,
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                   Chip(
// //                                                     label: Text(
// //                                                       donation['category'] ?? 'Other',
// //                                                       style: const TextStyle(color: Colors.white),
// //                                                     ),
// //                                                     backgroundColor: Colors.teal,
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                               const SizedBox(height: 8),
// //                                               Row(
// //                                                 children: [
// //                                                   const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
// //                                                   const SizedBox(width: 4),
// //                                                   Text(
// //                                                     _formatDate(donation['donation_date']),
// //                                                     style: TextStyle(color: Colors.grey[700]),
// //                                                   ),
// //                                                   const SizedBox(width: 16),
// //                                                   const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
// //                                                   const SizedBox(width: 4),
// //                                                   Text(
// //                                                     'ID: ${donation['donation_id']}',
// //                                                     style: TextStyle(color: Colors.grey[700]),
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                               const SizedBox(height: 16),
// //                                               Row(
// //                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                                 children: [
// //                                                   Column(
// //                                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                                     children: [
// //                                                       Text(
// //                                                         'Donation Amount',
// //                                                         style: TextStyle(
// //                                                           color: Colors.grey[600],
// //                                                           fontSize: 12,
// //                                                         ),
// //                                                       ),
// //                                                       Text(
// //                                                         _formatCurrency(donation['amount']),
// //                                                         style: const TextStyle(
// //                                                           fontSize: 20,
// //                                                           fontWeight: FontWeight.bold,
// //                                                         ),
// //                                                       ),
// //                                                     ],
// //                                                   ),
// //                                                   if (donation['payment_method'] != null)
// //                                                     Chip(
// //                                                       label: Text(
// //                                                         donation['payment_method'],
// //                                                         style: TextStyle(fontSize: 12),
// //                                                       ),
// //                                                       backgroundColor: Colors.grey[200],
// //                                                     ),
// //                                                 ],
// //                                               ),
// //                                               if (donation['donation_type'] == 'item')
// //                                                 Padding(
// //                                                   padding: const EdgeInsets.only(top: 8),
// //                                                   child: Text(
// //                                                     'Item Donated: ${donation['item_description']}',
// //                                                     style: TextStyle(
// //                                                       fontStyle: FontStyle.italic,
// //                                                       color: Colors.grey[800],
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                               const Divider(height: 24),
// //                                               Row(
// //                                                 mainAxisAlignment: MainAxisAlignment.end,
// //                                                 children: [
// //                                                   if (!isAnonymous)
// //                                                     TextButton.icon(
// //                                                       icon: const Icon(Icons.mail_outline, color: Colors.teal),
// //                                                       label: const Text(
// //                                                         'Thank Donor',
// //                                                         style: TextStyle(color: Colors.teal),
// //                                                       ),
// //                                                       onPressed: () => _sendThankYouMessage(donation),
// //                                                     ),
// //                                                   const SizedBox(width: 8),
// //                                                   TextButton.icon(
// //                                                     icon: const Icon(Icons.visibility, color: Colors.teal),
// //                                                     label: const Text(
// //                                                       'View Details',
// //                                                       style: TextStyle(color: Colors.teal),
// //                                                     ),
// //                                                     onPressed: () => _viewDonationDetails(donation),
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                             ],
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     );
// //                                   },
// //                                 ),
// //                               ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: Colors.teal,
// //         child: const Icon(Icons.download, color: Colors.white),
// //         onPressed: () {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(
// //               content: Text('Downloading donation report...'),
// //               backgroundColor: Colors.teal,
// //             ),
// //           );
// //           // Logic to download donation report would go here
// //         },
// //         tooltip: 'Download Report',
// //       ),
// //     );
// //   }

// //   Widget _buildStatCard(String title, String value, IconData icon) {
// //     return Card(
// //       elevation: 4,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Icon(icon, color: Colors.teal, size: 20),
// //                 const SizedBox(width: 8),
// //                 Text(
// //                   title,
// //                   style: TextStyle(
// //                     color: Colors.grey[600],
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               value,
// //               style: const TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.teal,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDropdownFilter<T>(
// //     String label,
// //     T value,
// //     List<T> items,
// //     void Function(T?) onChanged,
// //   ) {
// //     return DropdownButtonFormField<T>(
// //       value: value,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         labelStyle: const TextStyle(color: Colors.teal),
// //       ),
// //       style: const TextStyle(color: Colors.black),
// //       dropdownColor: Colors.white,
// //       items: items.map((T item) {
// //         return DropdownMenuItem<T>(
// //           value: item,
// //           child: Text(
// //             item.toString().replaceFirst(item.toString()[0], item.toString()[0].toUpperCase()),
// //             style: const TextStyle(fontSize: 14),
// //           ),
// //         );
// //       }).toList(),
// //       onChanged: onChanged,
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'organization_DonationDetails_page.dart';
// import 'organization_ThankYou_page.dart';
// import 'organization_DonationStatistics_page.dart';

// class DonationTrackingPage extends StatefulWidget {
  

//   const DonationTrackingPage({Key? key}) : super(key: key);

//   @override
//   _DonationTrackingPageState createState() => _DonationTrackingPageState();
// }

// class _DonationTrackingPageState extends State<DonationTrackingPage> {
//   List<Map<String, dynamic>> _donations = [];
//   bool _isLoading = true;
//   String _filterCategory = 'All';
//   String _searchQuery = '';
//   String _sortBy = 'date';
//   bool _sortAscending = false;
//   Map<String, double> _categoryTotals = {};
//   double _totalDonations = 0;

//   // Mock data
//   final List<Map<String, dynamic>> mockDonations = [
//     {
//       'donation_id': 'DON001',
//       'donor_id': 'DR001',
//       'donor_name': 'John Doe',
//       'amount': 10000,
//       'donation_date': '2024-02-20',
//       'category': 'Education',
//       'payment_method': 'Credit Card',
//       'is_anonymous': false,
//       'donation_type': 'money'
//     },
//     {
//       'donation_id': 'DON002',
//       'donor_id': 'DR002',
//       'donor_name': 'Jane Smith',
//       'amount': 15000,
//       'donation_date': '2024-02-19',
//       'category': 'Medical Treatment',
//       'payment_method': 'UPI',
//       'is_anonymous': false,
//       'donation_type': 'money'
//     },
//     {
//       'donation_id': 'DON003',
//       'donor_id': 'DR003',
//       'donor_name': 'Anonymous',
//       'amount': 5000,
//       'donation_date': '2024-02-18',
//       'category': 'Food & Nutrition',
//       'payment_method': 'Bank Transfer',
//       'is_anonymous': true,
//       'donation_type': 'money'
//     },
//     {
//       'donation_id': 'DON004',
//       'donor_id': 'DR004',
//       'donor_name': 'Robert Johnson',
//       'amount': 20000,
//       'donation_date': '2024-02-17',
//       'category': 'Emergency Relief',
//       'payment_method': 'Credit Card',
//       'is_anonymous': false,
//       'donation_type': 'money'
//     },
//     {
//       'donation_id': 'DON005',
//       'donor_id': 'DR005',
//       'donor_name': 'Sarah Williams',
//       'amount': 8000,
//       'donation_date': '2024-02-16',
//       'category': 'Education',
//       'payment_method': 'UPI',
//       'is_anonymous': false,
//       'donation_type': 'item',
//       'item_description': 'Books and Stationery'
//     }
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _fetchDonations();
//   }

//   Future<void> _fetchDonations() async {
//     setState(() {
//       _isLoading = true;
//     });

//     // Simulate API delay
//     await Future.delayed(const Duration(seconds: 1));

//     try {
//       setState(() {
//         _donations = List<Map<String, dynamic>>.from(mockDonations);
//         _calculateStats();
//         _sortDonations();
//         _isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showErrorSnackBar('Error: $error');
//     }
//   }

//   void _calculateStats() {
//     _categoryTotals = {};
//     _totalDonations = 0;

//     for (var donation in _donations) {
//       final category = donation['category'] ?? 'Other';
//       final amount = double.tryParse(donation['amount'].toString()) ?? 0;
      
//       _categoryTotals[category] = (_categoryTotals[category] ?? 0) + amount;
//       _totalDonations += amount;
//     }
//   }

//   void _sortDonations() {
//     _donations.sort((a, b) {
//       dynamic valueA, valueB;
      
//       switch (_sortBy) {
//         case 'date':
//           valueA = DateTime.parse(a['donation_date'].toString());
//           valueB = DateTime.parse(b['donation_date'].toString());
//           break;
//         case 'amount':
//           valueA = double.tryParse(a['amount'].toString()) ?? 0;
//           valueB = double.tryParse(b['amount'].toString()) ?? 0;
//           break;
//         case 'name':
//           valueA = a['donor_name'].toString();
//           valueB = b['donor_name'].toString();
//           break;
//         default:
//           valueA = DateTime.parse(a['donation_date'].toString());
//           valueB = DateTime.parse(b['donation_date'].toString());
//       }

//       int comparison;
//       if (valueA is DateTime && valueB is DateTime) {
//         comparison = valueA.compareTo(valueB);
//       } else if (valueA is num && valueB is num) {
//         comparison = valueA.compareTo(valueB);
//       } else {
//         comparison = valueA.toString().compareTo(valueB.toString());
//       }

//       return _sortAscending ? comparison : -comparison;
//     });
//   }

//   List<Map<String, dynamic>> _getFilteredDonations() {
//     return _donations.where((donation) {
//       // Category filter
//       bool matchesCategory = _filterCategory == 'All' || 
//                             donation['category'] == _filterCategory;
      
//       // Search query filter
//       bool matchesSearch = _searchQuery.isEmpty || 
//                           donation['donor_name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
//                           donation['donation_id'].toString().contains(_searchQuery);
      
//       return matchesCategory && matchesSearch;
//     }).toList();
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

//   void _viewDonationDetails(Map<String, dynamic> donation) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DonationDetailsPage(donation: donation),
//       ),
//     );
//   }

//   void _sendThankYouMessage(Map<String, dynamic> donation) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ThankYouMessagePage(
//           donorId: donation['donor_id'],
//           donorName: donation['donor_name'],
//           donationAmount: donation['amount'],
//           donationDate: donation['donation_date'],
//         ),
//       ),
//     );
//   }

//   void _viewStatistics() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DonationStatisticsPage(
          
//           categoryTotals: _categoryTotals,
//           totalDonations: _totalDonations,
//         ),
//       ),
//     );
//   }

//   String _formatCurrency(dynamic amount) {
//     final formatter = NumberFormat.currency(symbol: '₹');
//     return formatter.format(double.tryParse(amount.toString()) ?? 0);
//   }

//   String _formatDate(String dateStr) {
//     final date = DateTime.parse(dateStr);
//     return DateFormat('MMM dd, yyyy').format(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredDonations = _getFilteredDonations();
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Donation Tracking',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.bar_chart, color: Colors.white),
//             onPressed: _viewStatistics,
//             tooltip: 'View Statistics',
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: _fetchDonations,
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
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.white.withOpacity(0.3),
//                         Colors.white.withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -100,
//                 right: -100,
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.white.withOpacity(0.3),
//                         Colors.white.withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // Main content
//               Column(
//                 children: [
//                   // Stats cards
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: _buildStatCard(
//                             'Total Donations',
//                             _formatCurrency(_totalDonations),
//                             Icons.monetization_on,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildStatCard(
//                             'Donors',
//                             _donations.map((d) => d['donor_id']).toSet().length.toString(),
//                             Icons.people,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Search and filter options
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             TextField(
//                               decoration: InputDecoration(
//                                 labelText: 'Search donor name or ID',
//                                 prefixIcon: Icon(Icons.search, color: Colors.teal),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(color: Colors.teal, width: 2),
//                                 ),
//                                 labelStyle: TextStyle(color: Colors.teal),
//                               ),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _searchQuery = value;
//                                 });
//                               },
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: _buildDropdownFilter(
//                                     'Category',
//                                     _filterCategory,
//                                     ['All', 'Education', 'Food & Nutrition', 'Medical Treatment', 'Emergency Relief', 'Other'],
//                                     (value) {
//                                       setState(() {
//                                         _filterCategory = value!;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: _buildDropdownFilter(
//                                     'Sort By',
//                                     _sortBy,
//                                     ['date', 'amount', 'name'],
//                                     (value) {
//                                       setState(() {
//                                         _sortBy = value!;
//                                         _sortDonations();
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
//                                     color: Colors.teal,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _sortAscending = !_sortAscending;
//                                       _sortDonations();
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
                  
//                   // Donation list
//                   Expanded(
//                     child: _isLoading
//                         ? const Center(
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                         : filteredDonations.isEmpty
//                             ? Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.sentiment_dissatisfied,
//                                       size: 64,
//                                       color: Colors.white.withOpacity(0.8),
//                                     ),
//                                     const SizedBox(height: 16),
//                                     Text(
//                                       'No donations found',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : Padding(
//                                 padding: const EdgeInsets.all(16),
//                                 child: ListView.builder(
//                                   itemCount: filteredDonations.length,
//                                   itemBuilder: (context, index) {
//                                     final donation = filteredDonations[index];
//                                     final isAnonymous = donation['is_anonymous'] == true;
                                    
//                                     return Card(
//                                       elevation: 4,
//                                       margin: const EdgeInsets.only(bottom: 16),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(16),
//                                       ),
//                                       child: InkWell(
//                                         onTap: () => _viewDonationDetails(donation),
//                                         borderRadius: BorderRadius.circular(16),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(16),
//                                             child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Expanded(
//                                                     child: Text(
//                                                       isAnonymous ? 'Anonymous Donor' : donation['donor_name'],
//                                                       style: const TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight: FontWeight.bold,
//                                                         color: Colors.teal,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Chip(
//                                                     label: Text(
//                                                       donation['category'] ?? 'Other',
//                                                       style: const TextStyle(color: Colors.white),
//                                                     ),
//                                                     backgroundColor: Colors.teal,
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 8),
//                                               Row(
//                                                 children: [
//                                                   const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//                                                   const SizedBox(width: 4),
//                                                   Text(
//                                                     _formatDate(donation['donation_date']),
//                                                     style: TextStyle(color: Colors.grey[700]),
//                                                   ),
//                                                   const SizedBox(width: 16),
//                                                   const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
//                                                   const SizedBox(width: 4),
//                                                   Text(
//                                                     'ID: ${donation['donation_id']}',
//                                                     style: TextStyle(color: Colors.grey[700]),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 16),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         'Donation Amount',
//                                                         style: TextStyle(
//                                                           color: Colors.grey[600],
//                                                           fontSize: 12,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         _formatCurrency(donation['amount']),
//                                                         style: const TextStyle(
//                                                           fontSize: 20,
//                                                           fontWeight: FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   if (donation['payment_method'] != null)
//                                                     Chip(
//                                                       label: Text(
//                                                         donation['payment_method'],
//                                                         style: TextStyle(fontSize: 12),
//                                                       ),
//                                                       backgroundColor: Colors.grey[200],
//                                                     ),
//                                                 ],
//                                               ),
//                                               if (donation['donation_type'] == 'item')
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(top: 8),
//                                                   child: Text(
//                                                     'Item Donated: ${donation['item_description']}',
//                                                     style: TextStyle(
//                                                       fontStyle: FontStyle.italic,
//                                                       color: Colors.grey[800],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               const Divider(height: 24),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   if (!isAnonymous)
//                                                     TextButton.icon(
//                                                       icon: const Icon(Icons.mail_outline, color: Colors.teal),
//                                                       label: const Text(
//                                                         'Thank Donor',
//                                                         style: TextStyle(color: Colors.teal),
//                                                       ),
//                                                       onPressed: () => _sendThankYouMessage(donation),
//                                                     ),
//                                                   const SizedBox(width: 8),
//                                                   TextButton.icon(
//                                                     icon: const Icon(Icons.visibility, color: Colors.teal),
//                                                     label: const Text(
//                                                       'View Details',
//                                                       style: TextStyle(color: Colors.teal),
//                                                     ),
//                                                     onPressed: () => _viewDonationDetails(donation),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.teal,
//         child: const Icon(Icons.download, color: Colors.white),
//         onPressed: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Downloading donation report...'),
//               backgroundColor: Colors.teal,
//             ),
//           );
//           // Logic to download donation report would go here
//         },
//         tooltip: 'Download Report',
//       ),
//     );
//   }

//   Widget _buildStatCard(String title, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, color: Colors.teal, size: 20),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownFilter<T>(
//     String label,
//     T value,
//     List<T> items,
//     void Function(T?) onChanged,
//   ) {
//     return DropdownButtonFormField<T>(
//       value: value,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         labelStyle: const TextStyle(color: Colors.teal),
//       ),
//       style: const TextStyle(color: Colors.black),
//       dropdownColor: Colors.white,
//       items: items.map((T item) {
//         return DropdownMenuItem<T>(
//           value: item,
//           child: Text(
//             item.toString().replaceFirst(item.toString()[0], item.toString()[0].toUpperCase()),
//             style: const TextStyle(fontSize: 14),
//           ),
//         );
//       }).toList(),
//       onChanged: onChanged,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'organization_DonationDetails_page.dart';
import 'organization_ThankYou_page.dart';
import 'organization_DonationStatistics_page.dart';

class DonationTrackingPage extends StatefulWidget {
  

  const DonationTrackingPage({Key? key}) : super(key: key);

  @override
  _DonationTrackingPageState createState() => _DonationTrackingPageState();
}

class _DonationTrackingPageState extends State<DonationTrackingPage> {
  List<Map<String, dynamic>> _donations = [];
  bool _isLoading = true;
  String _filterCategory = 'All';
  String _searchQuery = '';
  String _sortBy = 'date';
  bool _sortAscending = false;
  Map<String, double> _categoryTotals = {};
  double _totalDonations = 0;

  // Mock data
  final List<Map<String, dynamic>> mockDonations = [
    {
      'donation_id': 'DON001',
      'donor_id': 'DR001',
      'donor_name': 'John Doe',
      'amount': 10000,
      'donation_date': '2024-02-20',
      'category': 'Education',
      'payment_method': 'Credit Card',
      'is_anonymous': false,
      'donation_type': 'money'
    },
    {
      'donation_id': 'DON002',
      'donor_id': 'DR002',
      'donor_name': 'Jane Smith',
      'amount': 15000,
      'donation_date': '2024-02-19',
      'category': 'Medical Treatment',
      'payment_method': 'UPI',
      'is_anonymous': false,
      'donation_type': 'money'
    },
    {
      'donation_id': 'DON003',
      'donor_id': 'DR003',
      'donor_name': 'Anonymous',
      'amount': 5000,
      'donation_date': '2024-02-18',
      'category': 'Food & Nutrition',
      'payment_method': 'Bank Transfer',
      'is_anonymous': true,
      'donation_type': 'money'
    },
    {
      'donation_id': 'DON004',
      'donor_id': 'DR004',
      'donor_name': 'Robert Johnson',
      'amount': 20000,
      'donation_date': '2024-02-17',
      'category': 'Emergency Relief',
      'payment_method': 'Credit Card',
      'is_anonymous': false,
      'donation_type': 'money'
    },
    {
      'donation_id': 'DON005',
      'donor_id': 'DR005',
      'donor_name': 'Sarah Williams',
      'amount': 8000,
      'donation_date': '2024-02-16',
      'category': 'Education',
      'payment_method': 'UPI',
      'is_anonymous': false,
      'donation_type': 'item',
      'item_description': 'Books and Stationery'
    },
    {
      'donation_id': 'DON006',
      'donor_id': 'DR006',
      'donor_name': 'Michael Brown',
      'amount': 12500,
      'donation_date': '2024-02-15',
      'category': 'Medical Treatment',
      'payment_method': 'Credit Card',
      'is_anonymous': false,
      'donation_type': 'money'
    },
    {
      'donation_id': 'DON007',
      'donor_id': 'DR007',
      'donor_name': 'Emily Davis',
      'amount': 7500,
      'donation_date': '2024-02-14',
      'category': 'Food & Nutrition',
      'payment_method': 'UPI',
      'is_anonymous': false,
      'donation_type': 'money'
    },
    {
      'donation_id': 'DON008',
      'donor_id': 'DR008',
      'donor_name': 'Anonymous',
      'amount': 30000,
      'donation_date': '2024-02-13',
      'category': 'Emergency Relief',
      'payment_method': 'Bank Transfer',
      'is_anonymous': true,
      'donation_type': 'money'
    }
  ];

  @override
  void initState() {
    super.initState();
    _fetchDonations();
  }

  Future<void> _fetchDonations() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      setState(() {
        _donations = List<Map<String, dynamic>>.from(mockDonations);
        _calculateStats();
        _sortDonations();
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error: $error');
    }
  }

  void _calculateStats() {
    _categoryTotals = {};
    _totalDonations = 0;

    for (var donation in _donations) {
      final category = donation['category'] ?? 'Other';
      final amount = double.tryParse(donation['amount'].toString()) ?? 0;
      
      _categoryTotals[category] = (_categoryTotals[category] ?? 0) + amount;
      _totalDonations += amount;
    }
  }

  void _sortDonations() {
    _donations.sort((a, b) {
      dynamic valueA, valueB;
      
      switch (_sortBy) {
        case 'date':
          valueA = DateTime.parse(a['donation_date'].toString());
          valueB = DateTime.parse(b['donation_date'].toString());
          break;
        case 'amount':
          valueA = double.tryParse(a['amount'].toString()) ?? 0;
          valueB = double.tryParse(b['amount'].toString()) ?? 0;
          break;
        case 'name':
          valueA = a['donor_name'].toString();
          valueB = b['donor_name'].toString();
          break;
        default:
          valueA = DateTime.parse(a['donation_date'].toString());
          valueB = DateTime.parse(b['donation_date'].toString());
      }

      int comparison;
      if (valueA is DateTime && valueB is DateTime) {
        comparison = valueA.compareTo(valueB);
      } else if (valueA is num && valueB is num) {
        comparison = valueA.compareTo(valueB);
      } else {
        comparison = valueA.toString().compareTo(valueB.toString());
      }

      return _sortAscending ? comparison : -comparison;
    });
  }

  List<Map<String, dynamic>> _getFilteredDonations() {
    return _donations.where((donation) {
      // Category filter
      bool matchesCategory = _filterCategory == 'All' || 
                            donation['category'] == _filterCategory;
      
      // Search query filter
      bool matchesSearch = _searchQuery.isEmpty || 
                          donation['donor_name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          donation['donation_id'].toString().contains(_searchQuery);
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _viewDonationDetails(Map<String, dynamic> donation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DonationDetailsPage(donation: donation),
      ),
    );
  }

  void _sendThankYouMessage(Map<String, dynamic> donation) {
    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ThankYouMessagePage(
      //donorId: 0, // Pass the donorId as 0 or placeholder value
      donorName: 'John Doe', // Placeholder name
      donationAmount: 500, // Placeholder donation amount
      donationDate: '2025-02-21', // Placeholder donation date
    ),
  ),
);

  }

  void _viewStatistics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DonationStatisticsPage(
          
          categoryTotals: _categoryTotals,
          totalDonations: _totalDonations,
        ),
      ),
    );
  }

  String _formatCurrency(dynamic amount) {
    final formatter = NumberFormat.currency(symbol: '₹');
    return formatter.format(double.tryParse(amount.toString()) ?? 0);
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final filteredDonations = _getFilteredDonations();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donation Tracking',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            onPressed: _viewStatistics,
            tooltip: 'View Statistics',
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchDonations,
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
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -100,
                right: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              Column(
                children: [
                  // Stats cards
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Total Donations',
                            _formatCurrency(_totalDonations),
                            Icons.monetization_on,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Donors',
                            _donations.map((d) => d['donor_id']).toSet().length.toString(),
                            Icons.people,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search and filter options
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Search donor name or ID',
                                prefixIcon: Icon(Icons.search, color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.teal, width: 2),
                                ),
                                labelStyle: TextStyle(color: Colors.teal),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownFilter(
                                    'Category',
                                    _filterCategory,
                                    ['All', 'Education', 'Food & Nutrition', 'Medical Treatment', 'Emergency Relief', 'Other'],
                                    (value) {
                                      setState(() {
                                        _filterCategory = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildDropdownFilter(
                                    'Sort By',
                                    _sortBy,
                                    ['date', 'amount', 'name'],
                                    (value) {
                                      setState(() {
                                        _sortBy = value!;
                                        _sortDonations();
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                                    color: Colors.teal,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _sortAscending = !_sortAscending;
                                      _sortDonations();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Donation list
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : filteredDonations.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sentiment_dissatisfied,
                                      size: 64,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No donations found',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16),
                                child: ListView.builder(
                                  itemCount: filteredDonations.length,
                                  itemBuilder: (context, index) {
                                    final donation = filteredDonations[index];
                                    final isAnonymous = donation['is_anonymous'] == true;
                                    
                                    return Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: InkWell(
                                        onTap: () => _viewDonationDetails(donation),
                                        borderRadius: BorderRadius.circular(16),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                            child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      isAnonymous ? 'Anonymous Donor' : donation['donor_name'],
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                  ),
                                                  Chip(
                                                    label: Text(
                                                      donation['category'] ?? 'Other',
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                    backgroundColor: Colors.teal,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    _formatDate(donation['donation_date']),
                                                    style: TextStyle(color: Colors.grey[700]),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    'ID: ${donation['donation_id']}',
                                                    style: TextStyle(color: Colors.grey[700]),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Donation Amount',
                                                        style: TextStyle(
                                                          color: Colors.grey[600],
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        _formatCurrency(donation['amount']),
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (donation['payment_method'] != null)
                                                    Chip(
                                                      label: Text(
                                                        donation['payment_method'],
                                                        style: TextStyle(fontSize: 12),
                                                      ),
                                                      backgroundColor: Colors.grey[200],
                                                    ),
                                                ],
                                              ),
                                              if (donation['donation_type'] == 'item')
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    'Item Donated: ${donation['item_description']}',
                                                    style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.grey[800],
                                                    ),
                                                  ),
                                                ),
                                              const Divider(height: 24),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  if (!isAnonymous)
                                                    TextButton.icon(
                                                      icon: const Icon(Icons.mail_outline, color: Colors.teal),
                                                      label: const Text(
                                                        'Thank Donor',
                                                        style: TextStyle(color: Colors.teal),
                                                      ),
                                                      onPressed: () => _sendThankYouMessage(donation),
                                                    ),
                                                  const SizedBox(width: 8),
                                                  TextButton.icon(
                                                    icon: const Icon(Icons.visibility, color: Colors.teal),
                                                    label: const Text(
                                                      'View Details',
                                                      style: TextStyle(color: Colors.teal),
                                                    ),
                                                    onPressed: () => _viewDonationDetails(donation),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.download, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Downloading donation report...'),
              backgroundColor: Colors.teal,
            ),
          );
          // Logic to download donation report would go here
        },
        tooltip: 'Download Report',
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownFilter<T>(
    String label,
    T value,
    List<T> items,
    void Function(T?) onChanged,
  ) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: const TextStyle(color: Colors.teal),
      ),
      style: const TextStyle(color: Colors.black),
      dropdownColor: Colors.white,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString().replaceFirst(item.toString()[0], item.toString()[0].toUpperCase()),
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}