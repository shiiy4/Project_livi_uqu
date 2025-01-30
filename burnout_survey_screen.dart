import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'dart:convert';

class BurnoutSurveyScreen extends StatefulWidget {
  const BurnoutSurveyScreen({super.key});

  @override
  _BurnoutSurveyScreenState createState() => _BurnoutSurveyScreenState();
}

class _BurnoutSurveyScreenState extends State<BurnoutSurveyScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Do you feel mentally exhausted at work?",
      "suggestions": [
        "Positive: Sometimes tired, Manageable, Not too bad",
        "Negative: Mentally drained, Exhausted, Overwhelmed"
      ]
    },
    {
      "question": "Do you find that everything you do at work requires a great deal of effort?",
      "suggestions": [
        "Positive: Worth it, Challenging but fine, Mostly manageable",
        "Negative: Always a struggle, Too much effort, Overwhelming"
      ]
    },
    {
      "question": "After a day at work, do you find it hard to recover your energy?",
      "suggestions": [
        "Positive: Rechargeable, Easily recovered, Mostly rested",
        "Negative: Never rested, Constantly tired, Drained"
      ]
    },
    {
      "question": "Do you feel physically exhausted at work?",
      "suggestions": [
        "Positive: Physically fine, Manageable fatigue, Occasionally tired",
        "Negative: Heavy body, Worn out, Drained"
      ]
    },
    {
      "question": "When you get up in the morning, do you lack the energy to start a new day at work?",
      "suggestions": [
        "Positive: Energized, Ready to go, Generally motivated",
        "Negative: No motivation, Dreading it, Low energy"
      ]
    },
    {
      "question": "Do you want to be active at work but find it difficult to manage?",
      "suggestions": [
        "Positive: Mostly engaged, Driven, Manageable",
        "Negative: Lost drive, Can’t keep up, Lacking energy"
      ]
    },
    {
      "question": "Do you quickly get tired when exerting yourself at work?",
      "suggestions": [
        "Positive: Good stamina, Generally strong, Rarely fatigued",
        "Negative: Easily fatigued, No stamina, Drained quickly"
      ]
    },
    {
      "question": "Do you feel mentally exhausted and drained at the end of your workday?",
      "suggestions": [
        "Positive: Refreshed, Energized, Fine",
        "Negative: Drained, Exhausted, Burned out"
      ]
    },
    {
      "question": "Do you struggle to find enthusiasm for your work?",
      "suggestions": [
        "Positive: Enthusiastic, Motivated, Passionate",
        "Negative: Unmotivated, No passion, Disengaged"
      ]
    },
    {
      "question": "Do you feel indifferent about your job?",
      "suggestions": [
        "Positive: Invested, Interested, Connected",
        "Negative: Detached, Uncaring, Apathetic"
      ]
    },
    {
      "question": "Are you cynical about the impact your work has on others?",
      "suggestions": [
        "Positive: Positive outlook, Purposeful, Meaningful",
        "Negative: Cynical, Doesn’t matter, Unimportant"
      ]
    },
    {
      "question": "Do you have trouble staying focused at work?",
      "suggestions": [
        "Positive: Focused, Attentive, On task",
        "Negative: Distracted, Unfocused, Easily sidetracked"
      ]
    },
    {
      "question": "Do you struggle to think clearly at work?",
      "suggestions": [
        "Positive: Clear-minded, Alert, Sharp",
        "Negative: Foggy mind, Confused, Unclear"
      ]
    },
    {
      "question": "Are you forgetful and easily distracted at work?",
      "suggestions": [
        "Positive: Sharp memory, Alert, Focused",
        "Negative: Forgetful, Easily distracted, Unfocused"
      ]
    },
    {
      "question": "Do you have trouble concentrating while working?",
      "suggestions": [
        "Positive: Good focus, Productive, Attentive",
        "Negative: Lose focus, Unfocused, Easily distracted"
      ]
    },
    {
      "question": "Do you make mistakes at work because your mind is on other things?",
      "suggestions": [
        "Positive: Few errors, Focused, On task",
        "Negative: Frequent errors, Not focused, Easily distracted"
      ]
    },
    {
      "question": "Do you feel unable to control your emotions at work?",
      "suggestions": [
        "Positive: Emotionally stable, Calm, Balanced",
        "Negative: Emotional outbursts, Irritable, Unstable"
      ]
    },
    {
      "question": "Do you feel that you no longer recognize yourself in your emotional reactions at work?",
      "suggestions": [
        "Positive: Self-aware, Emotionally balanced, Stable",
        "Negative: Not myself, Changed, Emotionally strained"
      ]
    },
    {
      "question": "Do you become irritable when things don’t go your way at work?",
      "suggestions": [
        "Positive: Patient, Flexible, Adaptable",
        "Negative: Easily frustrated, Quick-tempered, Irritable"
      ]
    },
    {
      "question": "Do you feel sad or upset at work without knowing why?",
      "suggestions": [
        "Positive: Emotionally balanced, Stable, Positive",
        "Negative: Unexplained sadness, Emotional, Low mood"
      ]
    },
  ];

  final Map<int, TextEditingController> controllers = {
    for (int i = 0; i < 20; i++) i: TextEditingController()
  };

  bool isLoading = false;

  Future<void> submitSurvey() async {
    setState(() {
      isLoading = true;
    });

    List<String> answers = controllers.values.map((controller) => controller.text.trim()).toList();

    if (answers.contains("") || answers.length != questions.length) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please answer all questions before submitting.")),
      );
      return;
    }

    final url = Uri.parse('https://livi-9.onrender.com/analyze');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'answers': answers}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        String diagnosis = result['diagnosis'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BurnoutReportViewScreen(diagnosis: diagnosis),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Unable to analyze data. Status Code: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Burnout Survey"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questions[index]['question'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "Suggested answers:",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                ...List.generate(
                  questions[index]['suggestions'].length,
                  (i) => Text("- ${questions[index]['suggestions'][i]}"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controllers[index],
                  decoration: InputDecoration(
                    hintText: "Type your answer here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : submitSurvey,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.send),
      ),
    );
  }
}

class BurnoutReportViewScreen extends StatelessWidget {
  final String diagnosis;

  BurnoutReportViewScreen({super.key, required this.diagnosis});

  final Map<String, String> recommendations = {
    "Normal": "You are doing well! Keep maintaining a healthy work-life balance. "
        "Make sure to take regular breaks and continue with your current work habits.",
    "Needs Monitoring": "Your burnout level is moderate. Consider taking short breaks throughout the day, "
        "practicing mindfulness, and adjusting your workload to avoid further exhaustion.",
    "At Risk": "Your burnout level is high. It's crucial to seek support from professionals, "
        "prioritize self-care, and take necessary steps to prevent further issues."
  };

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

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/burnout_report.pdf';
      final file = File(filePath);

      await file.writeAsBytes(await pdf.save());

      OpenFile.open(filePath);
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
          "Burnout Report",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
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