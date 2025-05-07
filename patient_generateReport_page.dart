// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pdfWidgets;
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'doctor_patient_Vital_page.dart';

// class GenerateReportPage extends StatelessWidget {
//   final Map<String, dynamic> vitals;
//   const GenerateReportPage({Key? key, required this.vitals}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Generate Report')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildPatientInfo(),
//             SizedBox(height: 20),
//             _buildVitalsSummary(),
//             SizedBox(height: 20),
//             _buildGeneratePDFButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientInfo() {
//     return Card(
//       elevation: 3,
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Patient Name: John Doe",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             Text("Age: 45"),
//             Text("Medical ID: #123456"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVitalsSummary() {
//     return Card(
//       elevation: 3,
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Health Vitals",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text("Heart Rate: ${vitals["heartRate"] ?? "-- BPM"}"),
//             Text("Oxygen Level: ${vitals["oxygenLevel"] ?? "--%"}"),
//             Text("Steps: ${vitals["steps"] ?? "--"}"),
//             Text("Sleep: ${vitals["sleep"] ?? "-- hrs"}"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGeneratePDFButton(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () => _generatePDF(context),
//         child: Text("Generate PDF Report"),
//       ),
//     );
//   }

//   Future<void> _generatePDF(BuildContext context) async {
//     final pdf = pdfWidgets.Document();
//     pdf.addPage(
//       pdfWidgets.Page(
//         build: (context) => pdfWidgets.Column(
//           children: [
//             pdfWidgets.Text("Patient Report",
//                 style: pdfWidgets.TextStyle(
//                     fontSize: 20, fontWeight: pdfWidgets.FontWeight.bold)),
//             pdfWidgets.SizedBox(height: 20),
//             pdfWidgets.Text("Patient Name: John Doe"),
//             pdfWidgets.Text("Age: 45"),
//             pdfWidgets.Text("Medical ID: #123456"),
//             pdfWidgets.SizedBox(height: 20),
//             pdfWidgets.Text("Heart Rate: ${vitals["heartRate"] ?? "-- BPM"}"),
//             pdfWidgets.Text("Oxygen Level: ${vitals["oxygenLevel"] ?? "--%"}"),
//             pdfWidgets.Text("Steps: ${vitals["steps"] ?? "--"}"),
//             pdfWidgets.Text("Sleep: ${vitals["sleep"] ?? "-- hrs"}"),
//           ],
//         ),
//       ),
//     );

//     final output = await getApplicationDocumentsDirectory();
//     final file = File("${output.path}/report.pdf");
//     await file.writeAsBytes(await pdf.save());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("PDF saved at ${file.path}")),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pdfWidgets;
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'doctor_patient_Vital_page.dart';

// class GenerateReportPage extends StatelessWidget {
//   final Map<String, dynamic> vitals;
//   const GenerateReportPage({Key? key, required this.vitals}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Generate Report')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             SizedBox(height: 20),
//             _buildPatientInfo(),
//             SizedBox(height: 20),
//             _buildVitalsSummary(),
//             SizedBox(height: 20),
//             _buildGeneratePDFButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Center(
//       child: Column(
//         children: [
//           Icon(Icons.local_hospital, size: 50, color: Colors.blueAccent),
//           SizedBox(height: 10),
//           Text("Medical Report", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//           Divider(thickness: 2, color: Colors.blueAccent),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientInfo() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Patient Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text("Name: John Doe", style: TextStyle(fontSize: 16)),
//             Text("Age: 45", style: TextStyle(fontSize: 16)),
//             Text("Medical ID: #123456", style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVitalsSummary() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Health Vitals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             _buildVitalRow("Heart Rate", "${vitals["heartRate"] ?? "-- BPM"}"),
//             _buildVitalRow("Oxygen Level", "${vitals["oxygenLevel"] ?? "--%"}"),
//             _buildVitalRow("Steps", "${vitals["steps"] ?? "--"}"),
//             _buildVitalRow("Sleep", "${vitals["sleep"] ?? "-- hrs"}"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildVitalRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//           Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
//         ],
//       ),
//     );
//   }

//   Widget _buildGeneratePDFButton(BuildContext context) {
//     return Center(
//       child: ElevatedButton.icon(
//         onPressed: () => _generatePDF(context),
//         icon: Icon(Icons.picture_as_pdf),
//         label: Text("Generate PDF Report"),
//         style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
//       ),
//     );
//   }

//   Future<void> _generatePDF(BuildContext context) async {
//     final pdf = pdfWidgets.Document();
//     pdf.addPage(
//       pdfWidgets.Page(
//         build: (context) => pdfWidgets.Column(
//           crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
//           children: [
//             pdfWidgets.Text("Medical Report", style: pdfWidgets.TextStyle(fontSize: 24, fontWeight: pdfWidgets.FontWeight.bold)),
//             pdfWidgets.Divider(thickness: 2),
//             pdfWidgets.Text("Patient Name: John Doe", style: pdfWidgets.TextStyle(fontSize: 18)),
//             pdfWidgets.Text("Age: 45", style: pdfWidgets.TextStyle(fontSize: 18)),
//             pdfWidgets.Text("Medical ID: #123456", style: pdfWidgets.TextStyle(fontSize: 18)),
//             pdfWidgets.SizedBox(height: 10),
//             pdfWidgets.Text("Health Vitals", style: pdfWidgets.TextStyle(fontSize: 20, fontWeight: pdfWidgets.FontWeight.bold)),
//             pdfWidgets.SizedBox(height: 5),
//             _buildPDFVitalRow("Heart Rate", vitals["heartRate"] ?? "-- BPM"),
//             _buildPDFVitalRow("Oxygen Level", vitals["oxygenLevel"] ?? "--%"),
//             _buildPDFVitalRow("Steps", vitals["steps"] ?? "--"),
//             _buildPDFVitalRow("Sleep", vitals["sleep"] ?? "-- hrs"),
//           ],
//         ),
//       ),
//     );

//     final output = await getApplicationDocumentsDirectory();
//     final file = File("${output.path}/report.pdf");
//     await file.writeAsBytes(await pdf.save());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("PDF saved at ${file.path}")),
//     );
//   }

//   pdfWidgets.Widget _buildPDFVitalRow(String label, String value) {
//     return pdfWidgets.Padding(
//       padding: pdfWidgets.EdgeInsets.symmetric(vertical: 4),
//       child: pdfWidgets.Row(
//         mainAxisAlignment: pdfWidgets.MainAxisAlignment.spaceBetween,
//         children: [
//           pdfWidgets.Text(label, style: pdfWidgets.TextStyle(fontSize: 16)),
//           pdfWidgets.Text(value, style: pdfWidgets.TextStyle(fontSize: 16, fontWeight: pdfWidgets.FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'doctor_patient_Vital_page.dart';

class GenerateReportPage extends StatelessWidget {
  final Map<String, dynamic> vitals;
  const GenerateReportPage({Key? key, required this.vitals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Report', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0D9488),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF0D9488), const Color(0xFF14B8A6)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Patient Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow("Name", "John Doe"),
                  _buildInfoRow("Age", "45"),
                  _buildInfoRow("Medical ID", "#123456"),
                  const SizedBox(height: 20),
                  const Text(
                    'Health Vitals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow("Heart Rate", "${vitals["heartRate"] ?? "-- BPM"}"),
                  _buildInfoRow("Oxygen Level", "${vitals["oxygenLevel"] ?? "--%"}"),
                  _buildInfoRow("Steps", "${vitals["steps"] ?? "--"}"),
                  _buildInfoRow("Sleep", "${vitals["sleep"] ?? "-- hrs"}"),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _generatePDF(context),
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text("Generate PDF Report"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D9488),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.white70, fontSize: 18)),
        ],
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pdfWidgets.Document();
    pdf.addPage(
      pdfWidgets.Page(
        build: (context) => pdfWidgets.Column(
          crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
          children: [
            pdfWidgets.Text("Medical Report", style: pdfWidgets.TextStyle(fontSize: 24, fontWeight: pdfWidgets.FontWeight.bold)),
            pdfWidgets.Divider(thickness: 2),
            pdfWidgets.Text("Patient Name: John Doe", style: pdfWidgets.TextStyle(fontSize: 18)),
            pdfWidgets.Text("Age: 45", style: pdfWidgets.TextStyle(fontSize: 18)),
            pdfWidgets.Text("Medical ID: #123456", style: pdfWidgets.TextStyle(fontSize: 18)),
            pdfWidgets.SizedBox(height: 10),
            pdfWidgets.Text("Health Vitals", style: pdfWidgets.TextStyle(fontSize: 20, fontWeight: pdfWidgets.FontWeight.bold)),
            pdfWidgets.SizedBox(height: 5),
            _buildPDFVitalRow("Heart Rate", vitals["heartRate"] ?? "-- BPM"),
            _buildPDFVitalRow("Oxygen Level", vitals["oxygenLevel"] ?? "--%"),
            _buildPDFVitalRow("Steps", vitals["steps"] ?? "--"),
            _buildPDFVitalRow("Sleep", vitals["sleep"] ?? "-- hrs"),
          ],
        ),
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/report.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF saved at ${file.path}")),
    );
  }

  pdfWidgets.Widget _buildPDFVitalRow(String label, String value) {
    return pdfWidgets.Padding(
      padding: pdfWidgets.EdgeInsets.symmetric(vertical: 4),
      child: pdfWidgets.Row(
        mainAxisAlignment: pdfWidgets.MainAxisAlignment.spaceBetween,
        children: [
          pdfWidgets.Text(label, style: pdfWidgets.TextStyle(fontSize: 16)),
          pdfWidgets.Text(value, style: pdfWidgets.TextStyle(fontSize: 16, fontWeight: pdfWidgets.FontWeight.bold)),
        ],
      ),
    );
  }
}