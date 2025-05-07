import 'package:flutter/material.dart';
import 'doctor_login_page.dart';
import 'patient_login_page.dart';
import 'organization_login_page.dart';
import 'donate_page.dart';
import 'admin_login_page.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal[700]!,
              Colors.teal[700]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background circles
            ..._buildAnimatedBackgroundCircles(),

            // Main content
            SafeArea(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Animated Logo Section
                      TweenAnimationBuilder(
                        duration: const Duration(seconds: 2),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.health_and_safety_rounded,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Welcome Text with Animation
                      TweenAnimationBuilder(
                        duration: const Duration(seconds: 1),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.teal[100],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Careआवास',
                              style: TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pacifico',
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      // Role Selection Cards
                      Expanded(
                        child: ListView(
                          children: [
                            _buildRoleCard(
                              'Doctor',
                              Icons.medical_services_rounded,
                              [Colors.blue[400]!, Colors.blue[600]!],
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DoctorLoginPage(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildRoleCard(
                              'Patient',
                              Icons.person_rounded,
                              [Colors.green[400]!, Colors.green[600]!],
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PatientLoginPage(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildRoleCard(
                              'NGO',
                              Icons.business_rounded,
                              [Colors.orange[400]!, Colors.orange[600]!],
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OrganizationLoginPage(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Admin Login Card - ADDED HERE
                            _buildRoleCard(
                              'Admin',
                              Icons.admin_panel_settings_rounded,
                              [Colors.purple[400]!, Colors.purple[600]!],
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminLoginPage(),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                // ✅ Add this "children" list
                                SizedBox(height: 20), // Spacing

                                /// 📢 **Donate Now Section**
                                Text(
                                  "What to Donate?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(height: 15), // Spacing

                                /// **Donate Now Button with Hyperlink to DonatePage**
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DonateLoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Donate Now",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors.blue, // Hyperlink-style color
                                      decoration: TextDecoration
                                          .underline, // Underline to indicate a clickable link
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedBackgroundCircles() {
    return [
      Positioned(
        top: -100,
        right: -100,
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 20),
          tween: Tween(begin: 0.0, end: 2 * 3.14),
          builder: (context, double value, child) {
            return Transform.rotate(
              angle: value,
              child: child,
            );
          },
          child: _buildGradientCircle(300),
        ),
      ),
      Positioned(
        bottom: -150,
        left: -150,
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 25),
          tween: Tween(begin: 0.0, end: 2 * 3.14),
          builder: (context, double value, child) {
            return Transform.rotate(
              angle: -value,
              child: child,
            );
          },
          child: _buildGradientCircle(400),
        ),
      ),
      // Additional background circles
      Positioned(
        top: -50,
        left: -50,
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 15),
          tween: Tween(begin: 0.0, end: 2 * 3.14),
          builder: (context, double value, child) {
            return Transform.rotate(
              angle: value,
              child: child,
            );
          },
          child: _buildGradientCircle(200),
        ),
      ),
      Positioned(
        bottom: -100,
        right: -100,
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 30),
          tween: Tween(begin: 0.0, end: 2 * 3.14),
          builder: (context, double value, child) {
            return Transform.rotate(
              angle: -value,
              child: child,
            );
          },
          child: _buildGradientCircle(250),
        ),
      ),
    ];
  }

  Widget _buildGradientCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    String title,
    IconData icon,
    List<Color> gradientColors,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: gradientColors[1].withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: gradientColors[0],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[1].withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: gradientColors[1],
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    offset: const Offset(1, 1),
                    blurRadius: 2,
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
