import 'package:flutter/material.dart';

class OneTimePaymentPage extends StatefulWidget {
  final String amount;
  final String category;
  final String name;
  final String email;
  final String phone;
  final String pan;
  final String message;
  final bool isAnonymous;
  final bool receiptRequired;

  const OneTimePaymentPage({
    Key? key,
    required this.amount,
    required this.category,
    required this.name,
    required this.email,
    required this.phone,
    required this.pan,
    required this.message,
    required this.isAnonymous,
    required this.receiptRequired,
  }) : super(key: key);

  @override
  _OneTimePaymentPageState createState() => _OneTimePaymentPageState();
}

class _OneTimePaymentPageState extends State<OneTimePaymentPage> {
  String? selectedPaymentMethod;
  bool showQRCode = false;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'UPI',
      'icon': Icons.qr_code,
      'description': 'Pay using any UPI app'
    },
    {
      'name': 'Credit Card',
      'icon': Icons.credit_card,
      'description': 'Visa, Mastercard, RuPay'
    },
    {
      'name': 'Debit Card',
      'icon': Icons.credit_card,
      'description': 'All major banks supported'
    },
    {
      'name': 'Net Banking',
      'icon': Icons.account_balance,
      'description': '100+ banks available'
    },
    {
      'name': 'PayPal',
      'icon': Icons.payment,
      'description': 'Pay using PayPal account'
    }
  ];

  Widget _buildDonationSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.receipt_long, color: Colors.teal.shade700),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Donation Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildSummaryRow(
                'Amount', '₹${widget.amount}', Icons.currency_rupee),
            _buildSummaryRow('Category', widget.category, Icons.category),
            if (!widget.isAnonymous)
              _buildSummaryRow('Donor', widget.name, Icons.person),
            _buildSummaryRow(
              'Receipt Required',
              widget.receiptRequired ? 'Yes' : 'No',
              Icons.receipt,
            ),
            if (!widget.isAnonymous && widget.email.isNotEmpty)
              _buildSummaryRow('Email', widget.email, Icons.email),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final bool isSelected = selectedPaymentMethod == method['name'];

    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isSelected ? Colors.teal.shade50 : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            selectedPaymentMethod = method['name'];
            showQRCode = method['name'] == 'UPI';
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  method['icon'],
                  color:
                      isSelected ? Colors.teal.shade700 : Colors.grey.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.teal.shade700 : Colors.black,
                      ),
                    ),
                    Text(
                      method['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Colors.teal.shade700,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return AnimatedOpacity(
      opacity: showQRCode ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: showQRCode
          ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Scan to Pay ₹${widget.amount}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/upi_qr.png', // Add the QR image to your assets
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '8299204178@ptsbi',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Scan with any UPI app',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 72,
              ),
              const SizedBox(height: 16),
              Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your donation of ₹${widget.amount} has been received',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Text(
                'Transaction ID: ${_generateTransactionId()}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.grey,
                ),
              ),
              if (widget.receiptRequired) ...[
                const SizedBox(height: 8),
                const Text(
                  'Receipt has been sent to your email',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Done'),
            ),
            ElevatedButton(
              onPressed: _shareReceipt,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
              ),
              child: const Text('Share Receipt'),
            ),
          ],
        );
      },
    );
  }

  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'DON${timestamp.substring(timestamp.length - 8)}';
  }

  void _shareReceipt() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'Receipt sharing functionality will be implemented here'),
        backgroundColor: Colors.teal.shade700,
      ),
    );
  }

  Future<void> _processDonation() async {
    if (selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
                  ),
                  const SizedBox(height: 16),
                  const Text('Processing your donation...'),
                ],
              ),
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    _showSuccessDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDonationSummaryCard(),
            const SizedBox(height: 24),
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...paymentMethods.map(_buildPaymentMethodCard).toList(),
            const SizedBox(height: 16),
            _buildQRCodeSection(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _processDonation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Proceed to Pay',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
