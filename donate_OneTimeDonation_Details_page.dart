
// Donate_OneTime_Details_page.dart
import 'package:flutter/material.dart';
import 'Donate_OneTimeDonation_Payment_page.dart';

class OneTimeDetailsPage extends StatefulWidget {
  final String amount;
  final String category;

  const OneTimeDetailsPage({
    Key? key,
    required this.amount,
    required this.category,
  }) : super(key: key);

  @override
  _OneTimeDetailsPageState createState() => _OneTimeDetailsPageState();
}

class _OneTimeDetailsPageState extends State<OneTimeDetailsPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool isAnonymous = false;
  bool receiptRequired = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _panController.dispose();
    _messageController.dispose();
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

  Widget _buildDonorSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Donate Anonymously'),
            subtitle:
                const Text('Your personal information will not be displayed'),
            value: isAnonymous,
            onChanged: (value) {
              setState(() => isAnonymous = value);
            },
            tileColor: Colors.white,
            activeColor: Colors.teal.shade700,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(height: 20),
          if (!isAnonymous) ...[
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration('Full Name', Icons.person),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _emailController,
              decoration: _buildInputDecoration('Email', Icons.email),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter your email';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _phoneController,
              decoration: _buildInputDecoration('Phone Number', Icons.phone),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true)
                  return 'Please enter your phone number';
                if (value!.length < 10)
                  return 'Please enter a valid phone number';
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _panController,
              decoration: _buildInputDecoration(
                  'PAN Number (Optional)', Icons.credit_card),
              textCapitalization: TextCapitalization.characters,
            ),
          ],
          const SizedBox(height: 15),
          TextFormField(
            controller: _messageController,
            decoration: _buildInputDecoration(
                'Add a Personal Message (Optional)', Icons.message),
            maxLines: 3,
          ),
          const SizedBox(height: 15),
          CheckboxListTile(
            title: const Text('I need a receipt for tax purposes'),
            subtitle: const Text('A receipt will be sent to your email'),
            value: receiptRequired,
            onChanged: (value) {
              setState(() => receiptRequired = value ?? true);
            },
            activeColor: Colors.teal.shade700,
            tileColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.teal.shade700),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.teal.shade700, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Donor Details'),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.receipt_long, color: Colors.teal.shade700),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Donation Summary',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              _buildSummaryRow('Amount', '₹${widget.amount}'),
                              _buildSummaryRow('Category', widget.category),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDonorSection(),
                      const SizedBox(height: 40),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Back'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>OneTimePaymentPage(
                                        amount: widget.amount,
                                        category: widget.category,
                                        name: isAnonymous ? 'Anonymous' : _nameController.text,
                                        email: _emailController.text,
                                        phone: _phoneController.text,
                                        pan: _panController.text,
                                        message: _messageController.text,
                                        isAnonymous: isAnonymous,
                                        receiptRequired: receiptRequired,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade700,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Continue to Payment'),
                            ),
                          ],
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
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}