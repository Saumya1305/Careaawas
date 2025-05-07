import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'donate_monthly_support_details_page.dart';

class MonthlyDonationPage extends StatefulWidget {
  const MonthlyDonationPage({Key? key}) : super(key: key);

  @override
  _MonthlyDonationPageState createState() => _MonthlyDonationPageState();
}

class _MonthlyDonationPageState extends State<MonthlyDonationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? selectedAmount;
  final TextEditingController _customAmountController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String? selectedDuration;
  String? selectedCategory;

  final List<String> predefinedAmounts = [
    '200',
    '500',
    '1000',
    '2000',
    '5000'
  ];
  
  final List<String> donationCategories = [
    'Medical Treatment',
    'Education',
    'Food & Nutrition',
    'Emergency Relief'
  ];
  
  final List<String> commitmentPeriods = [
    '3 months',
    '6 months',
    '1 year',
    'Ongoing'
  ];

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
          '₹$amount/month',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.teal.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
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
                  Icons.repeat,
                  color: Colors.teal.shade700,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Monthly Support Creates Lasting Change',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Regular monthly donations help us plan ahead and provide consistent care to those in need.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildImpactTimeline(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactTimeline() {
    return Column(
      children: [
        Row(
          children: [
            _buildTimelinePoint('Month 1', 'Initial support begins'),
            const Expanded(child: Divider(thickness: 2, color: Colors.teal)),
            _buildTimelinePoint('Month 3', 'Visible progress'),
            const Expanded(child: Divider(thickness: 2, color: Colors.teal)),
            _buildTimelinePoint('Month 6', 'Sustainable impact'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Monthly donors make our long-term programs possible',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimelinePoint(String title, String subtitle) {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.teal.shade700,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: 80,
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDonationForm() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Select Monthly Amount',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 10),
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
              labelText: 'Custom Monthly Amount',
              prefixText: '₹',
              suffixText: '/month',
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
          Text(
            'Commitment Period',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedDuration,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            items: commitmentPeriods.map((period) {
              return DropdownMenuItem(
                value: period,
                child: Text(period),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => selectedDuration = value);
            },
            validator: (value) =>
                value == null ? 'Please select a commitment period' : null,
          ),
          const SizedBox(height: 20),
          Text(
            'Donation Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
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

  Widget _buildDonorBenefits() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Donor Benefits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildBenefitItem(Icons.email, 'Quarterly impact reports'),
            _buildBenefitItem(Icons.star, 'Special recognition on our website'),
            _buildBenefitItem(Icons.event, 'Early access to events'),
            _buildBenefitItem(Icons.receipt, 'Annual tax receipt'),
            _buildBenefitItem(Icons.support_agent, 'Dedicated support contact'),
            const SizedBox(height: 12),
            Text(
              'You can modify or cancel your monthly support at any time',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.teal.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
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
            const Text('Why Donate Monthly?'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• Helps us plan ahead for long-term projects'),
              SizedBox(height: 8),
              Text('• Reduces administrative costs'),
              SizedBox(height: 8),
              Text('• Provides stable support for ongoing programs'),
              SizedBox(height: 8),
              Text('• Enables us to respond quickly to emergencies'),
              SizedBox(height: 8),
              Text('• Builds a community of committed supporters'),
              SizedBox(height: 16),
              Text(
                'You can pause or cancel your monthly donation at any time through your account or by contacting us.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
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
        title: const Text('Monthly Support Program'),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildImpactCard(),
                      _buildDonationForm(),
                      const SizedBox(height: 24),
                      _buildDonorBenefits(),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectedAmount != null || _customAmountController.text.isNotEmpty) {
                              // Navigate to details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MonthlyDonationDetailsPage(
                                    amount: selectedAmount ?? _customAmountController.text,
                                    category: selectedCategory ?? 'Not specified',
                                    duration: selectedDuration ?? 'Ongoing',
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select or enter a monthly amount'),
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
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton.icon(
                          onPressed: () {
                            // Show FAQ or explanation
                          },
                          icon: Icon(Icons.help_outline, color: Colors.teal.shade700, size: 16),
                          label: Text(
                            'How monthly donations work',
                            style: TextStyle(color: Colors.teal.shade700),
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
    );
  }
}