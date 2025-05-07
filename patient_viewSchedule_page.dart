import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Color Constants
class AppColors {
  static const Color primaryTeal = Color(0xFF009688);
  static const Color lightTeal = Color(0xFF4DB6AC);
  static const Color darkTeal = Color(0xFF00695C);
  static const Color accentWhite = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
}

// Mock data for treatments
class TreatmentSchedule {
  final String patientName;
  final String treatment;
  final String time;
  final String type;
  final String therapist;

  TreatmentSchedule({
    required this.patientName,
    required this.treatment,
    required this.time,
    required this.type,
    required this.therapist,
  });
}

class ViewSchedulePage extends StatefulWidget {
  const ViewSchedulePage({super.key});

  @override
  _ViewSchedulePageState createState() => _ViewSchedulePageState();
}

class _ViewSchedulePageState extends State<ViewSchedulePage>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  DateTime? _searchedDate;
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Treatment Type Filtering
  final List<String> _selectedTreatmentTypes = [];
  final List<String> _availableTreatmentTypes = [
    'Addiction Recovery',
    'Behavioral Therapy',
    'Treatment Assessment'
  ];

  // Mock treatment data
  final Map<String, List<TreatmentSchedule>> treatmentSchedules = {
    '2025-01-29': [
      TreatmentSchedule(
        patientName: 'John Doe',
        treatment: 'Group Therapy Session',
        time: '10:00 AM',
        type: 'Addiction Recovery',
        therapist: 'Dr. Smith',
      ),
      TreatmentSchedule(
        patientName: 'Sarah Wilson',
        treatment: 'Individual Counseling',
        time: '2:00 PM',
        type: 'Behavioral Therapy',
        therapist: 'Dr. Johnson',
      ),
    ],
    '2025-01-25': [
      TreatmentSchedule(
        patientName: 'Mike Brown',
        treatment: 'Medication Review',
        time: '11:30 AM',
        type: 'Treatment Assessment',
        therapist: 'Dr. Davis',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  // Month Navigation Methods
  void _navigateToPreviousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
    });
  }

  void _navigateToNextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
    });
  }

  // Treatment Type Filter Toggle
  void _toggleTreatmentTypeFilter(String type) {
    setState(() {
      if (_selectedTreatmentTypes.contains(type)) {
        _selectedTreatmentTypes.remove(type);
      } else {
        _selectedTreatmentTypes.add(type);
      }
    });
  }

  // Date Search Method
  void _searchDate() {
    String input = _searchController.text;
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(input);
      if (parsedDate.month == _selectedDate.month &&
          parsedDate.year == _selectedDate.year) {
        setState(() {
          _searchedDate = parsedDate;
        });
      } else {
        setState(() {
          _searchedDate = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Date not in the current month!')),
        );
      }
    } catch (e) {
      setState(() {
        _searchedDate = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid date format! Use dd/MM/yyyy')),
      );
    }
  }

  // Calendar Utility Methods
  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  List<TreatmentSchedule> _getTreatmentsForDate(DateTime date) {
    String dateKey = DateFormat('yyyy-MM-dd').format(date);
    return treatmentSchedules[dateKey] ?? [];
  }

  List<TreatmentSchedule> _getFilteredTreatments(DateTime date) {
    List<TreatmentSchedule> treatments = _getTreatmentsForDate(date);

    if (_selectedTreatmentTypes.isEmpty) return treatments;

    return treatments
        .where((treatment) => _selectedTreatmentTypes.contains(treatment.type))
        .toList();
  }

  // Treatment Details Modal
  void _showTreatmentDetails(BuildContext context, DateTime date) {
    List<TreatmentSchedule> treatments = _getFilteredTreatments(date);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.darkTeal, AppColors.primaryTeal],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Treatments for ${DateFormat('MMMM d, yyyy').format(date)}',
              style: TextStyle(
                color: AppColors.accentWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            treatments.isEmpty
                ? Center(
                    child: Text(
                      'No treatments scheduled',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      children: treatments
                          .map((treatment) => Container(
                                margin: EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.lightTeal.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color:
                                        AppColors.accentWhite.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          treatment.patientName,
                                          style: TextStyle(
                                            color: AppColors.accentWhite,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          treatment.time,
                                          style: TextStyle(
                                            color: AppColors.accentWhite
                                                .withOpacity(0.7),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      treatment.treatment,
                                      style: TextStyle(
                                        color: AppColors.accentWhite,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Type: ${treatment.type}',
                                      style: TextStyle(
                                        color: AppColors.accentWhite
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Therapist: ${treatment.therapist}',
                                      style: TextStyle(
                                        color: AppColors.accentWhite
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentWhite,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryTeal,
              AppColors.lightTeal,
            ],
          ),
        ),
        child: Column(
          children: [
            // App Bar
            Container(
              padding:
                  EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.darkTeal, AppColors.primaryTeal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Treatment Schedule",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentWhite,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: AppColors.accentWhite,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: AppColors.accentWhite),
                        onPressed: _navigateToPreviousMonth,
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(_selectedDate),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentWhite.withOpacity(0.9),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios,
                            color: AppColors.accentWhite),
                        onPressed: _navigateToNextMonth,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Treatment Type Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _availableTreatmentTypes.map((type) {
                  bool isSelected = _selectedTreatmentTypes.contains(type);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: isSelected,
                      onSelected: (_) => _toggleTreatmentTypeFilter(type),
                      selectedColor: AppColors.darkTeal.withOpacity(0.3),
                      backgroundColor: Colors.transparent,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppColors.accentWhite
                            : AppColors.accentWhite.withOpacity(0.7),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accentWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.accentWhite.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: AppColors.accentWhite),
                  decoration: InputDecoration(
                    labelText: 'Search Date (dd/MM/yyyy)',
                    labelStyle: TextStyle(
                        color: AppColors.accentWhite.withOpacity(0.7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: AppColors.accentWhite),
                      onPressed: _searchDate,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),

            // Calendar Grid
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Week days header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                                .map((day) => Expanded(
                                      child: Center(
                                        child: Text(
                                          day,
                                          style: TextStyle(
                                            color: AppColors.accentWhite
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _getDaysInMonth(
                            _selectedDate.year, _selectedDate.month),
                        itemBuilder: (context, index) {
                          DateTime day = DateTime(_selectedDate.year,
                              _selectedDate.month, index + 1);
                          bool isSelected = _searchedDate != null &&
                              _searchedDate!.day == day.day &&
                              _searchedDate!.month == day.month &&
                              _searchedDate!.year == day.year;

                          bool hasSchedule =
                              _getTreatmentsForDate(day).isNotEmpty;

                          return GestureDetector(
                            onTap: () {
                              _animationController.forward(from: 0.0);
                              setState(() {
                                _selectedDate = day;
                                _showTreatmentDetails(context, day);
                              });
                            },
                            child: AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale:
                                      isSelected ? _scaleAnimation.value : 1.0,
                                  child: Container(
                                    margin: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: isSelected
                                            ? [
                                                AppColors.darkTeal,
                                                AppColors.primaryTeal
                                              ]
                                            : hasSchedule
                                                ? [
                                                    AppColors.lightTeal,
                                                    AppColors.primaryTeal
                                                  ]
                                                : [
                                                    AppColors.accentWhite
                                                        .withOpacity(0.1),
                                                    AppColors.accentWhite
                                                        .withOpacity(0.05)
                                                  ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: isSelected ? 8 : 4,
                                          offset: Offset(0, isSelected ? 4 : 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.accentWhite,
                                            ),
                                          ),
                                        ),
                                        if (hasSchedule)
                                          Positioned(
                                            right: 4,
                                            top: 4,
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: AppColors.accentWhite,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

