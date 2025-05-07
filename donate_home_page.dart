import 'package:flutter/material.dart';
// Import your page files
import 'donate_OneTimeDonation_page.dart';
import 'donate_monthly_support_page.dart';
// import 'donate_monthly_page.dart';
// import 'sponsor_patient_page.dart';
// import 'donate_essentials_page.dart';

class DonationHomePage extends StatelessWidget {
  const DonationHomePage({Key? key, required int user_id}) : super(key: key);

  Widget _buildGradientCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.teal.withOpacity(0.6),
            Colors.transparent,
          ],
          radius: 0.6,
        ),
      ),
    );
  }

  Widget _buildAmountButton(BuildContext context, String amount) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        // Navigate to quick donation with pre-selected amount
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OneTimeAccountPage()),
        );
      },
      child:
          Text('₹$amount', style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPaymentMethod(String name, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildTestimonial(String text, String author) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"$text"',
              style: const TextStyle(
                  color: Colors.white, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Text(
              '- $author',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationOption(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    Widget destinationPage,
  ) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Icon(icon, color: Colors.teal, size: 32),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text('Support Our Mission',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              // Navigate to donation receipts page
              // TODO: Add your receipts page navigation
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(top: -100, right: -100, child: _buildGradientCircle(200)),
          Positioned(bottom: -50, left: -50, child: _buildGradientCircle(180)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  const Text(
                    'Transform Lives Through Your Generosity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your donation provides essential support, medication, and care to those in need. Together, we can make recovery possible for everyone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 32),

                  // Quick Donation Amounts
                  Card(
                    color: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Make a Quick Donation',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildAmountButton(context, '500'),
                              _buildAmountButton(context, '1000'),
                              _buildAmountButton(context, '5000'),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.teal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OneTimeAccountPage()),
                                  );
                                },
                                child: const Text('Custom',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Donation Options
                  _buildDonationOption(
                    context,
                    'One-Time Donation',
                    Icons.attach_money,
                    'Make an immediate impact with your contribution.',
                    const OneTimeAccountPage(),
                  ),
                  _buildDonationOption(
                    context,
                    'Monthly Support',
                    Icons.repeat,
                    'Join our community of monthly donors and create lasting change.',
                    const MonthlyDonationPage(),
                  ),
                  _buildDonationOption(
                    context,
                    'Sponsor a Patient',
                    Icons.favorite,
                    'Support an individual\'s complete recovery journey.',
                    const OneTimeAccountPage(),
                  ),
                  _buildDonationOption(
                    context,
                    'Donate Essentials',
                    Icons.card_giftcard,
                    'Contribute food, clothes, books, and other necessities.',
                    const OneTimeAccountPage(),
                  ),

                  const SizedBox(height: 24),

                  // Impact Stats
                  Card(
                    color: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: const [
                          Text(
                            'Our Impact',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text('500+ Lives Changed',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16)),
                          Text('10,000+ Meals Provided',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16)),
                          Text('1000+ Medical Treatments',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16)),
                          Text('5000+ Essential Items Distributed',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Testimonials
                  const Text(
                    'Success Stories',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildTestimonial(
                    'The support I received changed my life. I am now able to live independently and pursue my dreams.',
                    'Rahul S.',
                  ),
                  const SizedBox(height: 12),
                  _buildTestimonial(
                    'Thanks to the donors, I received the medical treatment I desperately needed.',
                    'Priya M.',
                  ),

                  const SizedBox(height: 24),

                  // Payment Methods
                  const Text(
                    'Accepted Payment Methods',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPaymentMethod('UPI', Icons.phone_android),
                      _buildPaymentMethod('Cards', Icons.credit_card),
                      _buildPaymentMethod('NetBanking', Icons.account_balance),
                      _buildPaymentMethod('PayPal', Icons.payment),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // CTA Buttons
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OneTimeAccountPage()),
                      );
                    },
                    child: const Text(
                      'Donate Now',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: Add navigation to fund usage page
                    },
                    child: const Text('Learn More About Fund Usage'),
                  ),

                  // Transparency Link
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    onPressed: () {
                      // TODO: Add navigation to transparency reports
                    },
                    child: const Text('View Transparency Reports'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
