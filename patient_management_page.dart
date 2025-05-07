

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientManagementPage extends StatefulWidget {
  final int ngoId;
  const PatientManagementPage({required this.ngoId, super.key});

  @override
  _PatientManagementPageState createState() => _PatientManagementPageState();
}

class _PatientManagementPageState extends State<PatientManagementPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int age = 0;
  String mobile = '';
  String email = '';
  String addictionType = '';
  String password = '';
  String? selectedDoctor;
  List<Map<String, dynamic>> doctorList = [];
  bool isLoading = false;
  bool _isPasswordVisible = false;

  // Medical history related variables
  final List<String> predefinedMedicalConditions = [
    'Diabetes',
    'Asthma',
    'High Blood Pressure',
    'Low Blood Pressure',
    'Heart Disease',
    'Arthritis',
    'Thyroid Disorder',
    'Cancer',
    'Respiratory Issues',
    'Other'
  ];
  List<String> selectedConditions = [];
  TextEditingController otherConditionController = TextEditingController();
  bool showOtherField = false;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  @override
  void dispose() {
    otherConditionController.dispose();
    super.dispose();
  }

  Future<void> fetchDoctors() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://172.21.81.6:3000/doctors');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> doctorsData = json.decode(response.body);

        setState(() {
          doctorList = doctorsData
              .map((doctor) => {
                    'doctor_id': doctor['doctor_id'].toString(),
                    'name': doctor['name']
                  })
              .toList();
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to fetch doctors.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addPatient() async {
  final url = Uri.parse('http://172.21.81.6:3000/patient');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'age': age,
      'mobile': mobile,
      'email': email,
      'addiction_type': addictionType,
      'password': password,
      'doctor_id': selectedDoctor,
      'history': json.encode(selectedConditions), // Convert list to JSON string
    }),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Patient added successfully! ID: ${responseData['patient_id']}')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to add patient.')),
    );
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Patient Management',
          style: TextStyle(color: Colors.white),
        ),
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
                            Text(
                              'Add a Patient',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                            ),
                            const SizedBox(height: 32),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                ),
                              ),
                              onChanged: (value) => name = value,
                              validator: (value) =>
                                  value!.isEmpty ? 'Name is required' : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Age',
                                prefixIcon: const Icon(Icons.numbers,
                                    color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  age = int.tryParse(value) ?? 0,
                              validator: (value) =>
                                  value!.isEmpty ? 'Age is required' : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                prefixIcon:
                                    const Icon(Icons.phone, color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                ),
                              ),
                              onChanged: (value) => mobile = value,
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon:
                                    const Icon(Icons.email, color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                ),
                              ),
                              onChanged: (value) => email = value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (!value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Enter a valid email (must contain @ and .)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Addiction Type',
                                prefixIcon: const Icon(Icons.healing,
                                    color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                ),
                              ),
                              onChanged: (value) => addictionType = value,
                              validator: (value) => value!.isEmpty
                                  ? 'Addiction type is required'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Medical History',
                                    prefixIcon: const Icon(
                                        Icons.medical_information,
                                        color: Colors.teal),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.teal, width: 2),
                                    ),
                                  ),
                                  hint: const Text('Select Medical Conditions'),
                                  value: null,
                                  items: predefinedMedicalConditions
                                      .map((String condition) {
                                    return DropdownMenuItem<String>(
                                      value: condition,
                                      child: Text(condition),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      if (newValue != null) {
                                        if (newValue == 'Other') {
                                          showOtherField = true;
                                        } else {
                                          if (!selectedConditions
                                              .contains(newValue)) {
                                            selectedConditions.add(newValue);
                                          }
                                        }
                                      }
                                    });
                                  },
                                  validator: (value) => selectedConditions
                                              .isEmpty &&
                                          !showOtherField
                                      ? 'Please select at least one medical condition'
                                      : null,
                                ),
                                const SizedBox(height: 8),
                                if (selectedConditions.isNotEmpty)
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        selectedConditions.map((condition) {
                                      return Chip(
                                        label: Text(condition),
                                        deleteIcon:
                                            const Icon(Icons.close, size: 20),
                                        onDeleted: () {
                                          setState(() {
                                            selectedConditions
                                                .remove(condition);
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                if (showOtherField) ...[
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: otherConditionController,
                                    decoration: InputDecoration(
                                      labelText: 'Other Medical Condition',
                                      prefixIcon: const Icon(Icons.edit_note,
                                          color: Colors.teal),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.teal, width: 2),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          if (otherConditionController
                                              .text.isNotEmpty) {
                                            setState(() {
                                              selectedConditions.add(
                                                  otherConditionController
                                                      .text);
                                              otherConditionController.clear();
                                              showOtherField = false;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          selectedConditions.add(value);
                                          otherConditionController.clear();
                                          showOtherField = false;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon:
                                    const Icon(Icons.lock, color: Colors.teal),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.teal,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2),
                                ),
                              ),
                              onChanged: (value) => password = value,
                              obscureText: !_isPasswordVisible,
                              validator: (value) => value!.isEmpty
                                  ? 'Password is required'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.teal))
                                : DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Assign Doctor',
                                      prefixIcon: const Icon(
                                          Icons.medical_services,
                                          color: Colors.teal),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.teal, width: 2),
                                      ),
                                    ),
                                    value: selectedDoctor,
                                    items: doctorList.map((doctor) {
                                      return DropdownMenuItem<String>(
                                        value: doctor['doctor_id'],
                                        child: Text(doctor['name']!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDoctor = value;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Please select a doctor'
                                        : null,
                                  ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  addPatient();
                                }
                              },
                              child: const Text(
                                'Add Patient',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
}
