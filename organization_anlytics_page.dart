import 'package:flutter/material.dart';

class NgoViewAnalyticsPage extends StatelessWidget {
  const NgoViewAnalyticsPage({super.key});

  // Mock function to fetch data dynamically
  Future<List<Map<String, dynamic>>> fetchAnalyticsData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return [
      {
        "title": "Total Patients Recovered",
        "value": 250,
        "percentage": "62%",
        "color": Colors.teal,
      },
      {
        "title": "Deteriorated Conditions",
        "value": 50,
        "percentage": "12%",
        "color": Colors.red,
      },
      {
        "title": "Overall Improvement",
        "value": "78%",
        "color": Colors.blue,
      },
      {
        "title": "Cases This Month",
        "value": 120,
        "color": Colors.orange,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Analytics',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchAnalyticsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No analytics data available.'));
                  }
                  final analyticsData = snapshot.data!;
                  return ListView.builder(
                    itemCount: analyticsData.length,
                    itemBuilder: (context, index) {
                      final item = analyticsData[index];
                      return _buildAnalyticsCard(
                        title: item['title'],
                        value: item['value'],
                        percentage: item['percentage'],
                        color: item['color'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required dynamic value,
    String? percentage,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(Icons.bar_chart, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Value: $value',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  if (percentage != null)
                    Text(
                      'Percentage: $percentage',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}