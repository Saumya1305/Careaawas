// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class OneTimeDonationPage extends StatefulWidget {
//   const OneTimeDonationPage({Key? key}) : super(key: key);

//   @override
//   _OneTimeDonationPageState createState() => _OneTimeDonationPageState();
// }

// class _OneTimeDonationPageState extends State<OneTimeDonationPage>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   String? selectedAmount;
//   final TextEditingController _customAmountController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   bool isAnonymous = false;
//   String? selectedPaymentMethod;
//   bool receiptRequired = true;
//   int _currentStep = 0;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   final List<String> predefinedAmounts = [
//     '500',
//     '1000',
//     '2000',
//     '5000',
//     '10000'
//   ];
//   final List<String> paymentMethods = [
//     'UPI',
//     'Credit Card',
//     'Debit Card',
//     'Net Banking',
//     'PayPal'
//   ];
//   final List<String> donationCategories = [
//     'Medical Treatment',
//     'Education',
//     'Food & Nutrition',
//     'Emergency Relief'
//   ];
//   String? selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _customAmountController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _panController.dispose();
//     _messageController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   Widget _buildGradientCircle(double size) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: RadialGradient(
//           colors: [
//             Colors.teal.withOpacity(0.6),
//             Colors.transparent,
//           ],
//           radius: 0.6,
//         ),
//       ),
//     );
//   }

//   Widget _buildAmountButton(String amount) {
//     bool isSelected = selectedAmount == amount;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedAmount = amount;
//           _customAmountController.clear();
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.teal : Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: Colors.teal),
//           boxShadow: isSelected
//               ? [
//                   BoxShadow(
//                     color: Colors.teal.withOpacity(0.3),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   )
//                 ]
//               : null,
//         ),
//         child: Text(
//           '₹$amount',
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.teal,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAmountSection() {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Column(
//         children: [
//           _buildImpactCard(),
//           const SizedBox(height: 20),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: predefinedAmounts
//                 .map((amount) => _buildAmountButton(amount))
//                 .toList(),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             controller: _customAmountController,
//             decoration: InputDecoration(
//               labelText: 'Custom Amount',
//               prefixText: '₹',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             keyboardType: TextInputType.number,
//             inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 setState(() => selectedAmount = null);
//               }
//             },
//           ),
//           const SizedBox(height: 20),
//           DropdownButtonFormField<String>(
//             value: selectedCategory,
//             decoration: InputDecoration(
//               labelText: 'Donation Category',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//             items: donationCategories.map((category) {
//               return DropdownMenuItem(
//                 value: category,
//                 child: Text(category),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() => selectedCategory = value);
//             },
//             validator: (value) =>
//                 value == null ? 'Please select a category' : null,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDonorSection() {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Column(
//         children: [
//           SwitchListTile(
//             title: const Text('Donate Anonymously'),
//             subtitle:
//                 const Text('Your personal information will not be displayed'),
//             value: isAnonymous,
//             onChanged: (value) {
//               setState(() => isAnonymous = value);
//             },
//             tileColor: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//           const SizedBox(height: 20),
//           if (!isAnonymous) ...[
//             TextFormField(
//               controller: _nameController,
//               decoration: _buildInputDecoration('Full Name', Icons.person),
//               validator: (value) =>
//                   value?.isEmpty ?? true ? 'Please enter your name' : null,
//             ),
//             const SizedBox(height: 15),
//             TextFormField(
//               controller: _emailController,
//               decoration: _buildInputDecoration('Email', Icons.email),
//               validator: (value) {
//                 if (value?.isEmpty ?? true) return 'Please enter your email';
//                 if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                     .hasMatch(value!)) {
//                   return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 15),
//             TextFormField(
//               controller: _phoneController,
//               decoration: _buildInputDecoration('Phone Number', Icons.phone),
//               keyboardType: TextInputType.phone,
//               validator: (value) {
//                 if (value?.isEmpty ?? true)
//                   return 'Please enter your phone number';
//                 if (value!.length < 10)
//                   return 'Please enter a valid phone number';
//                 return null;
//               },
//             ),
//             const SizedBox(height: 15),
//             TextFormField(
//               controller: _panController,
//               decoration: _buildInputDecoration(
//                   'PAN Number (Optional)', Icons.credit_card),
//               textCapitalization: TextCapitalization.characters,
//             ),
//           ],
//           const SizedBox(height: 15),
//           TextFormField(
//             controller: _messageController,
//             decoration: _buildInputDecoration(
//                 'Add a Personal Message (Optional)', Icons.message),
//             maxLines: 3,
//           ),
//           const SizedBox(height: 15),
//           CheckboxListTile(
//             title: const Text('I need a receipt for tax purposes'),
//             subtitle: const Text('A receipt will be sent to your email'),
//             value: receiptRequired,
//             onChanged: (value) {
//               setState(() => receiptRequired = value ?? true);
//             },
//             tileColor: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentSection() {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Column(
//         children: [
//           Card(
//             elevation: 4,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: const [
//                       Icon(Icons.receipt_long, color: Colors.teal),
//                       SizedBox(width: 8),
//                       Text(
//                         'Donation Summary',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   _buildSummaryRow('Amount',
//                       '₹${selectedAmount ?? _customAmountController.text}'),
//                   _buildSummaryRow(
//                       'Category', selectedCategory ?? 'Not specified'),
//                   if (!isAnonymous)
//                     _buildSummaryRow('Donor', _nameController.text),
//                   _buildSummaryRow(
//                       'Receipt Required', receiptRequired ? 'Yes' : 'No'),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Select Payment Method',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),
//           ...paymentMethods.map((method) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: RadioListTile<String>(
//                 title: Text(method),
//                 value: method,
//                 groupValue: selectedPaymentMethod,
//                 onChanged: (value) {
//                   setState(() => selectedPaymentMethod = value);
//                 },
//                 tileColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//               ),
//             );
//           }).toList(),
//           const SizedBox(height: 20),
//           if (selectedPaymentMethod != null)
//             Text(
//               'You selected ${selectedPaymentMethod!}',
//               style: const TextStyle(
//                 color: Colors.teal,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImpactCard() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: -20,
//             top: -20,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.teal.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 const Icon(
//                   Icons.favorite,
//                   color: Colors.teal,
//                   size: 48,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Your Donation Makes a Difference',
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold,
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Every contribution helps us provide essential support to those in need.',
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: Colors.grey[600],
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildImpactMetrics(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImpactMetrics() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         _buildMetricItem('1000+', 'Lives Impacted'),
//         _buildMetricItem('50+', 'Projects'),
//         _buildMetricItem('95%', 'Success Rate'),
//       ],
//     );
//   }

//   Widget _buildMetricItem(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.teal,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   InputDecoration _buildInputDecoration(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       prefixIcon: Icon(icon, color: Colors.teal),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade300),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.teal, width: 2),
//       ),
//     );
//   }

//   void _showInfoDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Row(
//           children: const [
//             Icon(Icons.info_outline, color: Colors.teal),
//             SizedBox(width: 8),
//             Text('About Donations'),
//           ],
//         ),
//         content: const SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('• All donations are tax-deductible'),
//               SizedBox(height: 8),
//               Text('• 100% of your donation goes to the cause'),
//               SizedBox(height: 8),
//               Text('• Receipts are generated instantly'),
//               SizedBox(height: 8),
//               Text('• Your data is secure and confidential'),
//               SizedBox(height: 8),
//               Text('• Regular updates on how your donation helps'),
//               SizedBox(height: 8),
//               Text('• Option to make recurring donations'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close', style: TextStyle(color: Colors.teal)),
//           ),
//         ],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       ),
//     );
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           title: Column(
//             children: [
//               const Icon(
//                 Icons.check_circle,
//                 color: Colors.green,
//                 size: 50,
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Thank You!',
//                 style: TextStyle(
//                   color: Colors.teal,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'Your donation will make a difference',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Your donation of ₹${selectedAmount ?? _customAmountController.text} has been processed successfully.',
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 12),
//               if (receiptRequired)
//                 const Text(
//                   'A receipt has been sent to your email address.',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               const SizedBox(height: 12),
//               const Text(
//                 'Transaction ID: ',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 _generateTransactionId(),
//                 style: const TextStyle(fontFamily: 'monospace'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _resetForm();
//               },
//               child: const Text(
//                 'Close',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _shareReceipt();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Share Receipt'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   String _generateTransactionId() {
//     final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//     return 'DON${timestamp.substring(timestamp.length - 8)}';
//   }

//   void _shareReceipt() {
//     // Implement share functionality
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Receipt sharing functionality will be implemented here'),
//         backgroundColor: Colors.teal,
//       ),
//     );
//   }

//   void _resetForm() {
//     _formKey.currentState?.reset();
//     setState(() {
//       selectedAmount = null;
//       selectedCategory = null;
//       selectedPaymentMethod = null;
//       _customAmountController.clear();
//       _nameController.clear();
//       _emailController.clear();
//       _phoneController.clear();
//       _panController.clear();
//       _messageController.clear();
//       isAnonymous = false;
//       receiptRequired = true;
//       _currentStep = 0;
//     });
//   }

//   Future<void> _processDonation() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     // Validate amount
//     if (selectedAmount == null && _customAmountController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select or enter a donation amount'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Validate payment method
//     if (selectedPaymentMethod == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a payment method'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Show loading indicator
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Center(
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
//                   ),
//                   SizedBox(height: 16),
//                   Text('Processing your donation...'),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );

//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 2));

//     // Hide loading indicator
//     Navigator.of(context).pop();

//     // Show success dialog
//     _showSuccessDialog();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text('One-Time Donation'),
//         backgroundColor: Colors.teal,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: () => _showInfoDialog(),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -100,
//             right: -100,
//             child: _buildGradientCircle(200),
//           ),
//           Positioned(
//             bottom: -50,
//             left: -50,
//             child: _buildGradientCircle(180),
//           ),
//           SafeArea(
//             child: Form(
//               key: _formKey,
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   colorScheme: ColorScheme.light(
//                     primary: Colors.teal,
//                     secondary: Colors.tealAccent,
//                   ),
//                 ),
//                 child: Stepper(
//                   type: StepperType.horizontal,
//                   currentStep: _currentStep,
//                   onStepContinue: () {
//                     if (_currentStep < 2) {
//                       setState(() => _currentStep++);
//                     } else {
//                       _processDonation();
//                     }
//                   },
//                   onStepCancel: () {
//                     if (_currentStep > 0) {
//                       setState(() => _currentStep--);
//                     }
//                   },
//                   controlsBuilder: (context, details) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: details.onStepContinue,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.teal,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 12),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: Text(
//                                 _currentStep == 2
//                                     ? 'Proceed to Payment'
//                                     : 'Continue',
//                               ),
//                             ),
//                           ),
//                           if (_currentStep > 0) ...[
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: OutlinedButton(
//                                 onPressed: details.onStepCancel,
//                                 style: OutlinedButton.styleFrom(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 12),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text('Back'),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     );
//                   },
//                   steps: [
//                     Step(
//                       title: const Text('Amount'),
//                       content: _buildAmountSection(),
//                       isActive: _currentStep >= 0,
//                       state: _currentStep > 0
//                           ? StepState.complete
//                           : StepState.indexed,
//                     ),
//                     Step(
//                       title: const Text('Details'),
//                       content: _buildDonorSection(),
//                       isActive: _currentStep >= 1,
//                       state: _currentStep > 1
//                           ? StepState.complete
//                           : StepState.indexed,
//                     ),
//                     Step(
//                       title: const Text('Payment'),
//                       content: _buildPaymentSection(),
//                       isActive: _currentStep >= 2,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// Donate_OneTime_Account_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Donate_OneTimeDonation_Details_page.dart';

class OneTimeAccountPage extends StatefulWidget {
  const OneTimeAccountPage({Key? key}) : super(key: key);

  @override
  _OneTimeAccountPageState createState() => _OneTimeAccountPageState();
}

class _OneTimeAccountPageState extends State<OneTimeAccountPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? selectedAmount;
  final TextEditingController _customAmountController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> predefinedAmounts = [
    '500',
    '1000',
    '2000',
    '5000',
    '10000'
  ];
  final List<String> donationCategories = [
    'Medical Treatment',
    'Education',
    'Food & Nutrition',
    'Emergency Relief'
  ];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildGradientCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.teal.shade700.withOpacity(0.6),
            Colors.transparent,
          ],
          radius: 0.6,
        ),
      ),
    );
  }

  Widget _buildAmountButton(String amount) {
    bool isSelected = selectedAmount == amount;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAmount = amount;
          _customAmountController.clear();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.teal.shade700),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.teal.shade700.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Text(
          '₹$amount',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.teal.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          _buildImpactCard(),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: predefinedAmounts
                .map((amount) => _buildAmountButton(amount))
                .toList(),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _customAmountController,
            decoration: InputDecoration(
              labelText: 'Custom Amount',
              prefixText: '₹',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() => selectedAmount = null);
              }
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
              labelText: 'Donation Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            items: donationCategories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => selectedCategory = value);
            },
            validator: (value) =>
                value == null ? 'Please select a category' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.teal.shade700.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.teal.shade700,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Donation Makes a Difference',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Every contribution helps us provide essential support to those in need.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildImpactMetrics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMetricItem('1000+', 'Lives Impacted'),
        _buildMetricItem('50+', 'Projects'),
        _buildMetricItem('95%', 'Success Rate'),
      ],
    );
  }

  Widget _buildMetricItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.teal.shade700),
            const SizedBox(width: 8),
            const Text('About Donations'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• All donations are tax-deductible'),
              SizedBox(height: 8),
              Text('• 100% of your donation goes to the cause'),
              SizedBox(height: 8),
              Text('• Receipts are generated instantly'),
              SizedBox(height: 8),
              Text('• Your data is secure and confidential'),
              SizedBox(height: 8),
              Text('• Regular updates on how your donation helps'),
              SizedBox(height: 8),
              Text('• Option to make recurring donations'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: Colors.teal.shade700)),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('One-Time Donation'),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: _buildGradientCircle(200),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildGradientCircle(180),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAmountSection(),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectedAmount != null || _customAmountController.text.isNotEmpty) {
                              // Navigate to details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OneTimeDetailsPage(
                                    amount: selectedAmount ?? _customAmountController.text,
                                    category: selectedCategory ?? 'Not specified',
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select or enter a donation amount'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Continue'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
