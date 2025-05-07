import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'organization_ThankYou_page.dart';

class DonationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> donation;

  const DonationDetailsPage({Key? key, required this.donation}) : super(key: key);

  String _formatCurrency(dynamic amount) {
    final formatter = NumberFormat.currency(symbol: '₹');
    return formatter.format(double.tryParse(amount.toString()) ?? 0);
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('MMMM dd, yyyy - hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isAnonymous = donation['is_anonymous'] == true;
    final hasMessage = donation['personal_message'] != null && 
                     donation['personal_message'].toString().isNotEmpty;
    final isItemDonation = donation['donation_type'] == 'item';
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donation Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        actions: [
          if (!isAnonymous)
            IconButton(
              icon: const Icon(Icons.mail, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThankYouMessagePage(
                      //donorId: donation['donor_id'],
                      donorName: donation['donor_name'],
                      donationAmount: donation['amount'],
                      donationDate: donation['donation_date'],
                    ),
                  ),
                );
              },

              
              tooltip: 'Send Thank You',
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
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isItemDonation ? 'Item Donation' : 'Monetary Donation',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    donation['category'] ?? 'Other',
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                  backgroundColor: Colors.teal,
                                  padding: const EdgeInsets.all(0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isItemDonation ? 'Estimated Value:' : 'Amount:',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        _formatCurrency(donation['amount']),
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.teal.withOpacity(0.1),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Icon(
                                    isItemDonation ? Icons.card_giftcard : Icons.monetization_on,
                                    color: Colors.teal,
                                    size: 36,
                                  ),
                                ),
                              ],
                            ),
                            if (isItemDonation && donation['item_description'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Row(
                                  children: [
                                    const Icon(Icons.inventory_2, color: Colors.grey, size: 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        donation['item_description'],
                                        style: TextStyle(color: Colors.grey[800]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Donor Information
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Donor Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (isAnonymous)
                              const ListTile(
                                leading: Icon(Icons.person_off, color: Colors.grey),
                                title: Text('Anonymous Donor'),
                                subtitle: Text('Donor chose to remain anonymous'),
                                contentPadding: EdgeInsets.zero,
                              )
                            else
                              Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.person,
                                    'Name',
                                    donation['donor_name'] ?? 'Not provided',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildInfoRow(
                                    Icons.email,
                                    'Email',
                                    donation['donor_email'] ?? 'Not provided',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildInfoRow(
                                    Icons.phone,
                                    'Phone',
                                    donation['donor_phone'] ?? 'Not provided',
                                  ),
                                  if (donation['pan_number'] != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: _buildInfoRow(
                                        Icons.badge,
                                        'PAN',
                                        donation['pan_number'],
                                      ),
                                    ),
                                ],
                              ),
                            if (hasMessage)
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.format_quote, color: Colors.teal, size: 20),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Message from Donor',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        donation['personal_message'],
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[800],
                                        ),
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
                    
                    // Transaction Details
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Transaction Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              Icons.confirmation_number,
                              'Donation ID',
                              donation['donation_id'].toString(),
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              Icons.calendar_today,
                              'Date & Time',
                              _formatDate(donation['donation_date']),
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              Icons.payment,
                              'Payment Method',
                              donation['payment_method'] ?? 'Not specified',
                            ),
                            if (donation['transaction_id'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: _buildInfoRow(
                                  Icons.receipt_long,
                                  'Transaction ID',
                                  donation['transaction_id'],
                                ),
                              ),
                            if (donation['tax_receipt_number'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: _buildInfoRow(
                                  Icons.receipt,
                                  'Tax Receipt Number',
                                  donation['tax_receipt_number'],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Utilization Details Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Utilization Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              Icons.category,
                              'Category',
                              donation['category'] ?? 'General',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              Icons.verified,
                              'Status',
                              donation['status'] ?? 'Received',
                              statusColor: donation['status'] == 'Utilized' 
                                  ? Colors.green 
                                  : donation['status'] == 'Partially Utilized' 
                                      ? Colors.orange 
                                      : Colors.blue,
                            ),
                            if (donation['utilized_amount'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: _buildInfoRow(
                                  Icons.account_balance_wallet,
                                  'Utilized Amount',
                                  _formatCurrency(donation['utilized_amount']),
                                ),
                              ),
                            if (donation['utilized_date'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: _buildInfoRow(
                                  Icons.event_available,
                                  'Utilization Date',
                                  _formatDate(donation['utilized_date']),
                                ),
                              ),
                            if (donation['project_name'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: _buildInfoRow(
                                  Icons.business_center,
                                  'Project',
                                  donation['project_name'],
                                ),
                              ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: Colors.teal[700]),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Donors will be notified when their donation is utilized in a project. You can update utilization details from the admin dashboard.',
                                      style: TextStyle(
                                        color: Colors.teal[700],
                                        fontSize: 13,
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
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.picture_as_pdf),
                            label: const Text('Download Receipt'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.teal,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.teal),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Downloading donation receipt...'),
                                  backgroundColor: Colors.teal,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.update),
                            label: const Text('Update Status'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              // Show dialog to update donation status
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Update Utilization Status'),
                                  content: const Text('This feature will allow you to update the utilization status of this donation and notify the donor.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: const Text('Go to Admin Panel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Navigate to admin panel
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? statusColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              statusColor != null
                  ? Chip(
                      label: Text(
                        value,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      backgroundColor: statusColor,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}