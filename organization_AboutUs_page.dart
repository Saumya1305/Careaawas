// import 'package:flutter/material.dart';

// class AboutUsPage extends StatelessWidget {
//   const AboutUsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           // Sliver App Bar with gradient
//           SliverAppBar(
//             expandedHeight: 200.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Color(0xFF5cdbca), Color(0xFF208a7d)],
//                 ),
//               ),
//               child: FlexibleSpaceBar(
//                 title: const Text(
//                   'About Us',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 background: Stack(
//                   children: [
//                     // Bubble decorations
//                     Positioned(
//                       top: -50,
//                       right: -30,
//                       child: Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: -20,
//                       left: 30,
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                     // Logo center
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Text(
//                             'CAREAAWAS',
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               letterSpacing: 1.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Content
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const _SectionTitle(title: 'Our Mission'),
//                   const _ContentCard(
//                     content: 'At Careaawas, we empower rehabilitation centers with innovative management solutions, making recovery journeys smoother and more effective for both patients and healthcare providers.',
//                   ),

//                   const SizedBox(height: 24),
//                   const _SectionTitle(title: 'Who We Are'),
//                   const _ContentCard(
//                     content: 'Careaawas is a comprehensive rehabilitation center management platform developed by healthcare professionals and technology experts. We understand the unique challenges faced by addiction treatment facilities and designed our solution to address these specific needs.',
//                   ),

//                   const SizedBox(height: 24),
//                   _BubbleFeatureGrid(),

//                   const SizedBox(height: 24),
//                   const _SectionTitle(title: 'Our Approach'),
//                   const _ContentCard(
//                     content: 'We believe in a holistic approach to addiction management. Our platform integrates clinical workflows, administrative tasks, and patient engagement tools to create a seamless ecosystem for recovery. By reducing administrative burden, we help professionals focus more on what matters most - patient care.',
//                   ),

//                   const SizedBox(height: 24),
//                   _TestimonialCard(),

//                   const SizedBox(height: 24),
//                   const _SectionTitle(title: 'Our Commitment'),
//                   const _ContentCard(
//                     content: 'We are committed to maintaining the highest standards of data security, privacy, and ethical practices. We regularly update our platform based on user feedback and evolving best practices in addiction treatment.',
//                   ),

//                   const SizedBox(height: 30),
//                   _ContactSection(),

//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;

//   const _SectionTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF208a7d),
//         ),
//       ),
//     );
//   }
// }

// class _ContentCard extends StatelessWidget {
//   final String content;

//   const _ContentCard({required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Text(
//         content,
//         style: const TextStyle(
//           fontSize: 16,
//           height: 1.6,
//           color: Color(0xFF2a3b47),
//         ),
//       ),
//     );
//   }
// }

// class _BubbleFeatureItem extends StatelessWidget {
//   final IconData icon;
//   final String title;

//   const _BubbleFeatureItem({required this.icon, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF5cdbca), Color(0xFF33b9a6)],
//             ),
//             borderRadius: BorderRadius.circular(40),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF33b9a6).withOpacity(0.3),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 32,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//             color: Color(0xFF2a3b47),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _BubbleFeatureGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: GridView.count(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         crossAxisCount: 3,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 20,
//         children: const [
//           _BubbleFeatureItem(
//             icon: Icons.people_alt_outlined,
//             title: 'Patient Management',
//           ),
//           _BubbleFeatureItem(
//             icon: Icons.calendar_today_outlined,
//             title: 'Scheduling',
//           ),
//           _BubbleFeatureItem(
//             icon: Icons.description_outlined,
//             title: 'Documentation',
//           ),
//           _BubbleFeatureItem(
//             icon: Icons.analytics_outlined,
//             title: 'Analytics',
//           ),
//           _BubbleFeatureItem(
//             icon: Icons.medication_outlined,
//             title: 'Medication Tracking',
//           ),
//           _BubbleFeatureItem(
//             icon: Icons.notifications_active_outlined,
//             title: 'Alerts',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TestimonialCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFF5cdbca), Color(0xFF208a7d)],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF33b9a6).withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Text(
//             '"Careaawas has revolutionized how we manage our rehabilitation center. The streamlined workflows and patient tracking features have improved our outcomes by 40% while reducing administrative work."',
//             style: TextStyle(
//               fontSize: 16,
//               height: 1.6,
//               color: Colors.white,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           SizedBox(height: 16),
//           Text(
//             '- Dr. Sarah Johnson, Recovery Hope Center',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ContactSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Connect With Us',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF208a7d),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     backgroundColor: const Color(0xFF33b9a6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Request Demo',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: const BorderSide(color: Color(0xFF33b9a6), width: 2),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Contact Us',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF33b9a6),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Center(
//             child: Text(
//               'Email: support@careaawas.com | Phone: (800) 123-4567',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF2a3b47),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade800,
        ),
        child: Stack(
          children: [
            _buildBackgroundDecorations(),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CAREAAWAS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Empowering Rehabilitation Centers',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildMissionSection(),
                        const SizedBox(height: 24),
                        _buildWhoWeAreSection(),
                        const SizedBox(height: 24),
                        _buildFeatureGrid(),
                        const SizedBox(height: 24),
                        _buildApproachSection(),
                        const SizedBox(height: 24),
                        _buildTestimonialSection(),
                        const SizedBox(height: 24),
                        _buildCommitmentSection(),
                        const SizedBox(height: 24),
                        _buildValueProposition(),
                      ],
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

  Widget _buildMissionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Our Mission',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'At Careaawas, we empower rehabilitation centers with innovative management solutions, making recovery journeys smoother and more effective for both patients and healthcare providers.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhoWeAreSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Who We Are',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Careaawas is a comprehensive rehabilitation center management platform developed by healthcare professionals and technology experts. We understand the unique challenges faced by addiction treatment facilities and designed our solution to address these specific needs.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Solutions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: const [
              _FeatureItem(
                icon: Icons.people_alt_outlined,
                title: 'Patient Management',
              ),
              _FeatureItem(
                icon: Icons.calendar_today_outlined,
                title: 'Scheduling',
              ),
              _FeatureItem(
                icon: Icons.description_outlined,
                title: 'Documentation',
              ),
              _FeatureItem(
                icon: Icons.analytics_outlined,
                title: 'Analytics',
              ),
              _FeatureItem(
                icon: Icons.medication_outlined,
                title: 'Medication Tracking',
              ),
              _FeatureItem(
                icon: Icons.notifications_active_outlined,
                title: 'Alerts',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApproachSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Our Approach',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'We believe in a holistic approach to addiction management. Our platform integrates clinical workflows, administrative tasks, and patient engagement tools to create a seamless ecosystem for recovery. By reducing administrative burden, we help professionals focus more on what matters most - patient care.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Success Stories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '"Careaawas has revolutionized how we manage our rehabilitation center. The streamlined workflows and patient tracking features have improved our outcomes by 40% while reducing administrative work."',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '- Dr. Sarah Johnson, Recovery Hope Center',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommitmentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Our Commitment',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'We are committed to maintaining the highest standards of data security, privacy, and ethical practices. We regularly update our platform based on user feedback and evolving best practices in addiction treatment.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueProposition() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why Choose Careaawas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildValueItem('Comprehensive Platform',
              'All-in-one solution for rehabilitation center management'),
          _buildValueItem('Data-Driven Insights',
              'Advanced analytics to improve patient outcomes'),
          _buildValueItem('Secure & Compliant',
              'Industry-standard security measures and compliance'),
          _buildValueItem('24/7 Support',
              'Round-the-clock technical assistance and training'),
        ],
      ),
    );
  }

  Widget _buildValueItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.teal.shade600, Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.teal.shade600, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
