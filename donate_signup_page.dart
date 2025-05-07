import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonateSignupPage extends StatefulWidget {
  const DonateSignupPage({Key? key}) : super(key: key);

  @override
  _DonateSignupPageState createState() => _DonateSignupPageState();
}

class _DonateSignupPageState extends State<DonateSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isPasswordVisible = false;
  String _statusMessage = '';
  String? _selectedUserType;
  String? _selectedMedicineType;
  List<String> _selectedPreferences = [];

  final List<String> _userTypes = [
    'Individual Donor',
    'Hospital',
    'Pharmacy',
    'NGO',
    'Medical Professional'
  ];
  final List<String> _medicineTypes = [
    'Prescription Drugs',
    'Over-the-Counter',
    'Medical Supplies',
    'Equipment'
  ];
  final List<String> _donationPreferences = [
    'Regular Donations',
    'Emergency Supplies',
    'Bulk Donations',
    'International Aid',
    'Local Community Support'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _statusMessage = 'Creating account...';
    });

    final String apiUrl = 'http://172.21.81.6:3000/donate_users';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_type': _selectedUserType,
          'full_name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'medicine_type': _selectedMedicineType,
          'donation_preferences': _selectedPreferences,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        setState(() {
          _statusMessage = 'Account registered successfully!';
        });
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _phoneController.clear();
        _addressController.clear();
        setState(() {
          _selectedUserType = null;
          _selectedMedicineType = null;
          _selectedPreferences = [];
        });
      } else {
        setState(() {
          _statusMessage = 'Failed to register. Please try again.';
        });
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _statusMessage = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Create Donate Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned(top: -100, right: -100, child: _buildGradientCircle(200)),
          Positioned(top: 100, left: -150, child: _buildGradientCircle(150)),
          Positioned(bottom: -50, left: -50, child: _buildGradientCircle(180)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(Icons.medication_rounded,
                                size: 64, color: Colors.teal),
                            const SizedBox(height: 24),
                            Text(
                              'Join Donate',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Create an account to start donating',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 32),

                            DropdownButtonFormField<String>(
                              value: _selectedUserType,
                              decoration: InputDecoration(
                                labelText: 'User Type',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                prefixIcon: const Icon(Icons.person_outline),
                              ),
                              items: _userTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                    value: type, child: Text(type));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedUserType = newValue;
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Please select a user type'
                                  : null,
                            ),

                            const SizedBox(height: 16),
                            _buildTextField(
                                _nameController, 'Full Name', Icons.person),
                            const SizedBox(height: 16),
                            _buildTextField(_emailController, 'Email',
                                Icons.email_outlined),
                            const SizedBox(height: 16),
                            _buildPasswordField(),
                            const SizedBox(height: 16),
                            _buildPhoneField(),
                            const SizedBox(height: 16),
                            _buildTextField(_addressController, 'Address',
                                Icons.location_on_outlined),

                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedMedicineType,
                              decoration: InputDecoration(
                                labelText:
                                    'Preferred Medicine Type for Donation',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                prefixIcon:
                                    const Icon(Icons.medical_services_outlined),
                              ),
                              items: _medicineTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                    value: type, child: Text(type));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedMedicineType = newValue;
                                });
                              },
                            ),

                            const SizedBox(height: 16),
                            // Add the donation preferences checkboxes
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8.0),
                                  child: Text(
                                    'Donation Preferences',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                ...List.generate(
                                  _donationPreferences.length,
                                  (index) => CheckboxListTile(
                                    title: Text(_donationPreferences[index]),
                                    value: _selectedPreferences
                                        .contains(_donationPreferences[index]),
                                    onChanged: (bool? selected) {
                                      setState(() {
                                        if (selected != null && selected) {
                                          _selectedPreferences
                                              .add(_donationPreferences[index]);
                                        } else {
                                          _selectedPreferences.remove(
                                              _donationPreferences[index]);
                                        }
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                              ),
                              onPressed: _signup,
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),

                            const SizedBox(height: 16),
                            Text(
                              _statusMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _statusMessage.contains('Error') ||
                                          _statusMessage.contains('Failed')
                                      ? Colors.red
                                      : _statusMessage.isEmpty
                                          ? Colors.transparent
                                          : Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon:
            Icon(Icons.phone, color: const Color.fromARGB(255, 19, 19, 19)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 16, 16, 16), width: 2),
        ),
        labelStyle: TextStyle(color: const Color.fromARGB(255, 27, 28, 28)),
      ),
      autovalidateMode:
          AutovalidateMode.onUserInteraction, // Auto validate while typing
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        } else if (value.length > 10) {
          return 'Phone number cannot exceed 10 digits';
        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
          return 'Enter a valid 10-digit phone number';
        }
        return null; // No error if valid
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      obscureText: !_isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

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
}
