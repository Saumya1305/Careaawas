// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class ThankYouMessagePage extends StatefulWidget {
//   final int donorId;
//   final String donorName;
//   final dynamic donationAmount;
//   final String donationDate;

//   const ThankYouMessagePage({
//     Key? key,
//     required this.donorId,
//     required this.donorName,
//     required this.donationAmount,
//     required this.donationDate,
//   }) : super(key: key);

//   @override
//   _ThankYouMessagePageState createState() => _ThankYouMessagePageState();
// }

// class _ThankYouMessagePageState extends State<ThankYouMessagePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _messageController = TextEditingController();
//   final _subjectController = TextEditingController();
  
//   bool _isLoading = false;
//   bool _includeUtilizationUpdate = false;
//   String _selectedTemplate = 'formal';
  
//   List<String> _templates = [
//     'formal',
//     'casual',
//     'project_update',
//     'first_time_donor',
//     'recurring_donor'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill subject with default
//     _subjectController.text = 'Thank You for Your Generous Donation';
//     // Load template message
//     _loadTemplate();
//   }

//   void _loadTemplate() {
//     String template = '';
//     final formatter = NumberFormat.currency(symbol: '₹');
//     final amount = formatter.format(double.tryParse(widget.donationAmount.toString()) ?? 0);
//     final date = DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.donationDate));
    
//     switch (_selectedTemplate) {
//       case 'formal':
//         template = '''Dear ${widget.donorName},

// Thank you for your generous donation of $amount on $date. Your support means a lot to us and the communities we serve.

// Your contribution will help us continue our mission of making a positive impact. We are grateful for your trust and support.

// Sincerely,
// [NGO Name]
// ''';
//         break;
      
//       case 'casual':
//         template = '''Hi ${widget.donorName}!

// Wow! Thank you so much for your amazing donation of $amount on $date! We're so excited to put your generous gift to work right away.

// Your support means we can keep doing what we love - helping those who need it most. We'd love to keep you updated on the impact you're making!

// With gratitude,
// The [NGO Name] Team
// ''';
//         break;
      
//       case 'project_update':
//         template = '''Dear ${widget.donorName},

// Thank you for your generous donation of $amount on $date. We wanted to let you know that your contribution is being directed to our [Project Name] initiative.

// This project is currently helping [number] beneficiaries by providing [specific services]. Thanks to supporters like you, we've already achieved [specific milestone].

// We'll be sending updates as the project progresses. Thank you again for making this possible!

// Warm regards,
// [NGO Name]
// ''';
//         break;
      
//       case 'first_time_donor':
//         template = '''Dear ${widget.donorName},

// Thank you for your first donation of $amount to our organization! We're thrilled to welcome you to our community of supporters.

// Your contribution on $date will directly help us [specific impact]. As a first-time donor, we wanted to personally thank you for choosing to support our cause.

// We'd love to learn more about what inspired your donation. Feel free to reply to this message or check out more ways to get involved on our website.

// With appreciation,
// [NGO Name]
// ''';
//         break;
      
//       case 'recurring_donor':
//         template = '''Dear ${widget.donorName},

// Thank you for your continued support with your recent donation of $amount on $date. As one of our valued recurring supporters, your consistent generosity has a profound impact on our work.

// Over the past year, recurring donors like you have helped us [specific achievement]. This ongoing support allows us to plan effectively and commit to long-term solutions.

// We're deeply grateful for your partnership in our mission.

// With sincere thanks,
// [NGO Name]
// ''';
//         break;
//     }
    
//     _messageController.text = template;
//   }

//   Future<void> _sendThankYouMessage() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
    
//     setState(() {
//       _isLoading = true;
//     });
    
//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:3000/ngo/send-thank-you'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'donor_id': widget.donorId,
//           'subject': _subjectController.text,
//           'message': _messageController.text,
//           'include_utilization_update': _includeUtilizationUpdate,
//         }),
//       );
      
//       setState(() {
//         _isLoading = false;
//       });
      
//       if (response.statusCode == 200) {
//         if (!mounted) return;
        
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Thank you message sent successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         if (!mounted) return;
        
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to send message: ${response.body}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error sending message: $error'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Send Thank You',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.teal,
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
//               SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: Colors.teal.shade50,
//                                 radius: 24,
//                                 child: const Icon(
//                                   Icons.favorite,
//                                   color: Colors.teal,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Sending to: ${widget.donorName}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       'For donation on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.donationDate))}',
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 24),
                          
//                           // Template selector
//                           Text(
//                             'Select Message Template',
//                             style: TextStyle(
//                               color: Colors.grey[700],
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey[300]!),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               children: _templates.map((template) {
//                                 final isSelected = _selectedTemplate == template;
//                                 String displayName = '';
                                
//                                 switch (template) {
//                                   case 'formal':
//                                     displayName = 'Formal Thank You';
//                                     break;
//                                   case 'casual':
//                                     displayName = 'Casual & Friendly';
//                                     break;
//                                   case 'project_update':
//                                     displayName = 'Project Update';
//                                     break;
//                                   case 'first_time_donor':
//                                     displayName = 'First-Time Donor';
//                                     break;
//                                   case 'recurring_donor':
//                                     displayName = 'Recurring Donor';
//                                     break;
//                                 }
                                
//                                 return RadioListTile<String>(
//                                   title: Text(
//                                     displayName,
//                                     style: TextStyle(
//                                       fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                                     ),
//                                   ),
//                                   value: template,
//                                   groupValue: _selectedTemplate,
//                                   activeColor: Colors.teal,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _selectedTemplate = value!;
//                                       _loadTemplate();
//                                     });
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Subject field
//                           TextFormField(
//                             controller: _subjectController,
//                             decoration: InputDecoration(
//                               labelText: 'Email Subject',
//                               prefixIcon: const Icon(Icons.subject, color: Colors.teal),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: const BorderSide(color: Colors.teal, width: 2),
//                               ),
//                               labelStyle: const TextStyle(color: Colors.teal),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter an email subject';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Message field
//                           TextFormField(
//                             controller: _messageController,
//                             decoration: InputDecoration(
//                               labelText: 'Message',
//                               alignLabelWithHint: true,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: const BorderSide(color: Colors.teal, width: 2),
//                               ),
//                               labelStyle: const TextStyle(color: Colors.teal),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a message';
//                               }
//                               return null;
//                             },
//                             maxLines: 10,
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Text(
//                                 'Tip: Personalize your message for better engagement',
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                   fontStyle: FontStyle.italic,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
                          
//                           // Options
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[50],
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.grey[200]!),
//                             ),
//                             padding: const EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Additional Options',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 CheckboxListTile(
//                                   title: const Text('Include Utilization Update'),
//                                   subtitle: const Text(
//                                     'Adds information about how donations are being used',
//                                     style: TextStyle(fontSize: 12),
//                                   ),
//                                   value: _includeUtilizationUpdate,
//                                   activeColor: Colors.teal,
//                                   contentPadding: EdgeInsets.zero,
//                                   controlAffinity: ListTileControlAffinity.leading,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _includeUtilizationUpdate = value!;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 24),
                          
//                           // Send Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton.icon(
//                               icon: const Icon(Icons.send),
//                               label: Text(_isLoading ? 'Sending...' : 'Send Thank You Message'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.teal,
//                                 foregroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 elevation: 2,
//                               ),
//                               onPressed: _isLoading ? null : _sendThankYouMessage,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Center(
//                             child: TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text(
//                                 'Cancel',
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _subjectController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThankYouMessagePage extends StatefulWidget {
  final String donorName;
  final dynamic donationAmount;
  final String donationDate;

  const ThankYouMessagePage({
    Key? key,
    required this.donorName,
    required this.donationAmount,
    required this.donationDate,
  }) : super(key: key);

  @override
  _ThankYouMessagePageState createState() => _ThankYouMessagePageState();
}

class _ThankYouMessagePageState extends State<ThankYouMessagePage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _subjectController = TextEditingController();
  
  bool _isLoading = false;
  bool _includeUtilizationUpdate = false;
  String _selectedTemplate = 'formal';
  
  List<String> _templates = [
    'formal',
    'casual',
    'project_update',
    'first_time_donor',
    'recurring_donor'
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill subject with default
    _subjectController.text = 'Thank You for Your Generous Donation';
    // Load template message
    _loadTemplate();
  }

  void _loadTemplate() {
    String template = '';
    final formatter = NumberFormat.currency(symbol: '₹');
    final amount = formatter.format(double.tryParse(widget.donationAmount.toString()) ?? 0);
    final date = DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.donationDate));
    
    switch (_selectedTemplate) {
      case 'formal':
        template = '''Dear ${widget.donorName},

Thank you for your generous donation of $amount on $date. Your support means a lot to us and the communities we serve.

Your contribution will help us continue our mission of making a positive impact. We are grateful for your trust and support.

Sincerely,
[NGO Name]
''';
        break;
      
      case 'casual':
        template = '''Hi ${widget.donorName}!

Wow! Thank you so much for your amazing donation of $amount on $date! We're so excited to put your generous gift to work right away.

Your support means we can keep doing what we love - helping those who need it most. We'd love to keep you updated on the impact you're making!

With gratitude,
The [NGO Name] Team
''';
        break;
      
      case 'project_update':
        template = '''Dear ${widget.donorName},

Thank you for your generous donation of $amount on $date. We wanted to let you know that your contribution is being directed to our [Project Name] initiative.

This project is currently helping [number] beneficiaries by providing [specific services]. Thanks to supporters like you, we've already achieved [specific milestone].

We'll be sending updates as the project progresses. Thank you again for making this possible!

Warm regards,
[NGO Name]
''';
        break;
      
      case 'first_time_donor':
        template = '''Dear ${widget.donorName},

Thank you for your first donation of $amount to our organization! We're thrilled to welcome you to our community of supporters.

Your contribution on $date will directly help us [specific impact]. As a first-time donor, we wanted to personally thank you for choosing to support our cause.

We'd love to learn more about what inspired your donation. Feel free to reply to this message or check out more ways to get involved on our website.

With appreciation,
CareAawas
''';
        break;
      
      case 'recurring_donor':
        template = '''Dear ${widget.donorName},

Thank you for your continued support with your recent donation of $amount on $date. As one of our valued recurring supporters, your consistent generosity has a profound impact on our work.

Over the past year, recurring donors like you have helped us [specific achievement]. This ongoing support allows us to plan effectively and commit to long-term solutions.

We're deeply grateful for your partnership in our mission.

With sincere thanks,
CareAawas
''';
        break;
    }
    
    _messageController.text = template;
  }

  Future<void> _sendThankYouMessage() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Since there's no backend, we'll just simulate the success response
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      if (!mounted) return;
        
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you message sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending message: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Thank You',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
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
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.teal.shade50,
                                radius: 24,
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sending to: ${widget.donorName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'For donation on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.donationDate))}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          // Template selector
                          Text(
                            'Select Message Template',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: _templates.map((template) {
                                final isSelected = _selectedTemplate == template;
                                String displayName = '';
                                
                                switch (template) {
                                  case 'formal':
                                    displayName = 'Formal Thank You';
                                    break;
                                  case 'casual':
                                    displayName = 'Casual & Friendly';
                                    break;
                                  case 'project_update':
                                    displayName = 'Project Update';
                                    break;
                                  case 'first_time_donor':
                                    displayName = 'First-Time Donor';
                                    break;
                                  case 'recurring_donor':
                                    displayName = 'Recurring Donor';
                                    break;
                                }
                                
                                return RadioListTile<String>(
                                  title: Text(
                                    displayName,
                                    style: TextStyle(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  value: template,
                                  groupValue: _selectedTemplate,
                                  activeColor: Colors.teal,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTemplate = value!;
                                      _loadTemplate();
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Subject field
                          TextFormField(
                            controller: _subjectController,
                            decoration: InputDecoration(
                              labelText: 'Email Subject',
                              prefixIcon: const Icon(Icons.subject, color: Colors.teal),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.teal, width: 2),
                              ),
                              labelStyle: const TextStyle(color: Colors.teal),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          
                          // Message field
                          TextFormField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              labelText: 'Message',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.teal, width: 2),
                              ),
                              labelStyle: const TextStyle(color: Colors.teal),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a message';
                              }
                              return null;
                            },
                            maxLines: 10,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Tip: Personalize your message for better engagement',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Options
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Additional Options',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CheckboxListTile(
                                  title: const Text('Include Utilization Update'),
                                  subtitle: const Text(
                                    'Adds information about how donations are being used',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: _includeUtilizationUpdate,
                                  activeColor: Colors.teal,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  onChanged: (value) {
                                    setState(() {
                                      _includeUtilizationUpdate = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Send Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.send),
                              label: Text(_isLoading ? 'Sending...' : 'Send Thank You Message'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              onPressed: _isLoading ? null : _sendThankYouMessage,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _subjectController.dispose();
    super.dispose();
  }
}
