import 'package:flutter/material.dart';

class MonthlyDonationDetailsPage extends StatefulWidget {
  final String amount;
  final String category;
  final String duration;

  const MonthlyDonationDetailsPage({
    Key? key,
    required this.amount,
    required this.category,
    required this.duration,
  }) : super(key: key);

  @override
  _MonthlyDonationDetailsPageState createState() =>
      _MonthlyDonationDetailsPageState();
}

class _MonthlyDonationDetailsPageState
    extends State<MonthlyDonationDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? selectedPaymentMethod;
  bool agreedToTerms = false;

  final List<String> paymentMethods = [
    'UPI',
    'Credit/Debit Card',
    'NetBanking'
  ];

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

  Widget _buildSummaryCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Donation Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Amount', '₹${widget.amount}/month'),
            _buildSummaryRow('Category', widget.category),
            _buildSummaryRow('Duration', widget.duration),
            const Divider(height: 32),
            _buildSummaryRow(
              'Total Commitment',
              _calculateTotalCommitment(),
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  String _calculateTotalCommitment() {
    if (widget.duration == 'Ongoing') {
      return '₹${widget.amount}/month (ongoing)';
    }

    int months = 0;
    if (widget.duration == '3 months') months = 3;
    if (widget.duration == '6 months') months = 6;
    if (widget.duration == '1 year') months = 12;

    int totalAmount = int.tryParse(widget.amount) ?? 0;
    totalAmount *= months;

    return '₹$totalAmount (${widget.duration})';
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
              color: isBold ? Colors.teal.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoForm() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 16),
            ...paymentMethods
                .map((method) => _buildPaymentOption(method))
                .toList(),
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      agreedToTerms = value!;
                    });
                  },
                  activeColor: Colors.teal.shade700,
                ),
                Expanded(
                  child: Text(
                    'I authorize automatic monthly payments according to the terms and conditions. I understand I can cancel anytime.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
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

  Widget _buildPaymentOption(String method) {
    bool isSelected = selectedPaymentMethod == method;
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.teal.shade700 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.teal.shade50 : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              _getPaymentIcon(method),
              color: isSelected ? Colors.teal.shade700 : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Text(
              method,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.teal.shade700 : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.teal.shade700,
              ),
          ],
        ),
      ),
    );
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'UPI':
        return Icons.phone_android;
      case 'Credit/Debit Card':
        return Icons.credit_card;
      case 'NetBanking':
        return Icons.account_balance;
      default:
        return Icons.payment;
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade700),
            const SizedBox(width: 8),
            const Text('Monthly Donation Confirmed'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you, ${_nameController.text}!',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                'Your monthly donation of ₹${widget.amount} has been set up successfully. You will receive a confirmation email shortly at ${_emailController.text}.',
              ),
              const SizedBox(height: 16),
              Text(
                'Your first payment will be processed today, and subsequent payments will be automatically debited on the same date each month.',
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(
              'Return to Home',
              style: TextStyle(color: Colors.teal.shade700),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Complete Your Monthly Donation'),
        backgroundColor: Colors.teal.shade700,
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSummaryCard(),
                    const SizedBox(height: 20),
                    _buildPersonalInfoForm(),
                    const SizedBox(height: 20),
                    _buildPaymentSection(),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: !agreedToTerms || selectedPaymentMethod == null
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // Process payment and show confirmation
                                _showConfirmationDialog();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Confirm Monthly Donation',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Secure Payment | 256-bit encryption',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
