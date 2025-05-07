import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AssignTherapyPage extends StatefulWidget {
  final String patientId;
  final String patientName;

  const AssignTherapyPage({
    Key? key,
    required this.patientId,
    required this.patientName,
  }) : super(key: key);

  @override
  _AssignTherapyPageState createState() => _AssignTherapyPageState();
}

class _AssignTherapyPageState extends State<AssignTherapyPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _customDosageController = TextEditingController();
  
  String _selectedTherapyType = 'Medication';
  String _selectedActivity = '';
  String _selectedDosage = 'None';
  bool _isLoading = false;

  final List<String> _therapyTypes = [
    'Medication', 'Counseling', 'Group Therapy', 'Physical Activity', 'Meditation', 'Other'
  ];
  
  final Map<String, List<String>> _activitiesByType = {
    'Medication': ['Disulfiram', 'Naltrexone', 'Methadone', 'Other'],
    'Counseling': ['Individual Therapy', 'Cognitive Behavioral Therapy', 'Other'],
    'Group Therapy': ['Support Group', 'Other'],
    'Physical Activity': ['Yoga', 'Gym Session', 'Other'],
    'Meditation': ['Guided Meditation', 'Breathing Exercises', 'Other'],
    'Other': ['Art Therapy', 'Music Therapy', 'Other']
  };

  final List<String> _dosageOptions = [
    'None', 
    '50 mg', 
    '100 mg', 
    '150 mg', 
    '200 mg', 
    '250 mg', 
    'Custom'
  ];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    _selectedActivity = _activitiesByType[_selectedTherapyType]![0];
  }

  Future<void> _submitTherapy() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // Determine final dosage
    String finalDosage = _selectedDosage == 'Custom' 
        ? _customDosageController.text 
        : _selectedDosage;

    final therapyData = {
      'patient_id': widget.patientId,
      'treatmentDate': _dateController.text,
      'therapyType': _selectedTherapyType,
      'activity': _selectedActivity,
      'dosage': finalDosage == 'None' ? '' : finalDosage,
      'notes': _notesController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://172.21.81.6:3000/assign_therapy'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(therapyData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Therapy assigned successfully')),
        );
        _notesController.clear();
        _customDosageController.clear();
        _selectedDosage = 'None';
      } else {
        throw Exception('Failed to assign therapy: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assign Therapy: ${widget.patientName}',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.teal.shade800,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal.shade800,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Patient ID:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.patientId.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Date Picker
                        _buildFormCard(
                          icon: Icons.calendar_today,
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Colors.teal.shade800,
                                        onPrimary: Colors.white,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedDate = picked;
                                  _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                                });
                              }
                            },
                            child: TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                border: InputBorder.none,
                              ),
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Therapy Type Dropdown
                        _buildFormCard(
                          icon: Icons.medical_services,
                          child: DropdownButtonFormField<String>(
                            value: _selectedTherapyType,
                            decoration: InputDecoration(
                              labelText: 'Therapy Type',
                              border: InputBorder.none,
                            ),
                            items: _therapyTypes.map((type) => 
                              DropdownMenuItem(
                                value: type, 
                                child: Text(type),
                              )
                            ).toList(),
                            onChanged: (value) => setState(() {
                              _selectedTherapyType = value!;
                              _selectedActivity = _activitiesByType[_selectedTherapyType]![0];
                            }),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a therapy type';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Activity Dropdown
                        _buildFormCard(
                          icon: Icons.list,
                          child: DropdownButtonFormField<String>(
                            value: _selectedActivity,
                            decoration: InputDecoration(
                              labelText: 'Activity',
                              border: InputBorder.none,
                            ),
                            items: _activitiesByType[_selectedTherapyType]!.map((activity) => 
                              DropdownMenuItem(
                                value: activity, 
                                child: Text(activity),
                              )
                            ).toList(),
                            onChanged: (value) => setState(() => _selectedActivity = value!),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select an activity';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Dosage Dropdown
                        _buildFormCard(
                          icon: Icons.medication,
                          child: DropdownButtonFormField<String>(
                            value: _selectedDosage,
                            decoration: InputDecoration(
                              labelText: 'Dosage',
                              border: InputBorder.none,
                            ),
                            items: _dosageOptions.map((dosage) => 
                              DropdownMenuItem(
                                value: dosage, 
                                child: Text(dosage),
                              )
                            ).toList(),
                            onChanged: (value) => setState(() => _selectedDosage = value!),
                          ),
                        ),

                        // Custom Dosage Field (shown when 'Custom' is selected)
                        if (_selectedDosage == 'Custom')
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              _buildFormCard(
                                icon: Icons.edit,
                                child: TextFormField(
                                  controller: _customDosageController,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Custom Dosage',
                                    border: InputBorder.none,
                                  ),
                                  validator: _selectedDosage == 'Custom' 
                                    ? (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a custom dosage';
                                        }
                                        return null;
                                      }
                                    : null,
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 16),

                        // Notes Field
                        _buildFormCard(
                          icon: Icons.notes,
                          child: TextFormField(
                            controller: _notesController,
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              border: InputBorder.none,
                            ),
                            maxLines: 3,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Submit Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: _submitTherapy,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _isLoading 
                                      ? const CircularProgressIndicator(color: Colors.teal)
                                      : const Text(
                                          'Assign Therapy',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create form cards with consistent styling
  Widget _buildFormCard({required IconData icon, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.teal.shade800,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _notesController.dispose();
    _customDosageController.dispose();
    super.dispose();
  }
}