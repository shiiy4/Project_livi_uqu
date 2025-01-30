import 'dart:io'; // لإدارة الملفات
import 'package:path_provider/path_provider.dart'; // لتحديد مسار التخزين المناسب
import 'package:open_file/open_file.dart'; // لفتح الملفات بعد الحفظ
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BurnoutReportViewScreen extends StatelessWidget {
  final String diagnosis; // التشخيص الناتج من الخوارزمية

   BurnoutReportViewScreen({Key? key, required this.diagnosis}) : super(key: key);

  // التوصيات بناءً على التشخيص
  final Map<String, String> recommendations = {
    "Normal": "You are doing well! Keep maintaining a healthy work-life balance. "
        "Make sure to take regular breaks and continue with your current work habits.",
    "Needs Monitoring": "Your burnout level is moderate. Consider taking short breaks throughout the day, "
        "practicing mindfulness, and adjusting your workload to avoid further exhaustion.",
    "At Risk": "Your burnout level is high. It's crucial to seek support from professionals, "
        "prioritize self-care, and take necessary steps to prevent further issues."
  };

  // لون التشخيص بناءً على الحالة
  Color getDiagnosisColor() {
    switch (diagnosis) {
      case "At Risk":
        return Colors.red;
      case "Needs Monitoring":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  // توليد ملف PDF
  Future<void> generatePdf() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Personal Report on Burnout:",
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text("Overall Burnout Status: $diagnosis",
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: diagnosis == "At Risk"
                          ? PdfColors.red
                          : diagnosis == "Needs Monitoring"
                              ? PdfColors.orange
                              : PdfColors.green)),
              pw.SizedBox(height: 10),
              pw.Text(
                "This report is generated based on your responses to the Burnout Survey. "
                "It provides insights into your current state of burnout and offers personalized recommendations to support your mental health.",
              ),
              pw.SizedBox(height: 20),
              pw.Text("Recommendations:",
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text(recommendations[diagnosis] ?? "No recommendations available."),
            ],
          ),
        ),
      );

      // تحديد المسار المناسب لنظام التشغيل لحفظ التقرير
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/burnout_report.pdf';
      final file = File(filePath);

      // حفظ التقرير بصيغة PDF
      await file.writeAsBytes(await pdf.save());

      // فتح التقرير بعد الحفظ
      OpenFile.open(filePath);

      print("PDF saved successfully at: $filePath");
    } catch (e) {
      print("Error while generating PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Personal Reports",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Report on Burnout:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Overall Burnout Status: $diagnosis",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: getDiagnosisColor()),
            ),
            const SizedBox(height: 10),
            const Text(
              "This report is generated based on your responses to the Burnout Survey. "
              "It provides insights into your current state of burnout and offers personalized recommendations to support your mental health.",
            ),
            const SizedBox(height: 20),
            const Text(
              "Recommendations:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              recommendations[diagnosis] ?? "No recommendations available.",
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: generatePdf,
                child: const Text("Download PDF"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}