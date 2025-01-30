import 'package:flutter/material.dart';

class ManagerEmployeesReportsScreen extends StatelessWidget {
  const ManagerEmployeesReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Employees Reports",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // الرجوع إلى الصفحة السابقة
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // الانتقال لصفحة الإشعارات
              // الأكشن عند الضغط على الإشعارات
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDE4D7),
              Color(0xFFFAD2E1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reports List",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildReportCard(
                      context,
                      "Nora Ali",
                      "Stress: Moderate (60%)",
                      "Anxiety: Mild (40%)",
                      "Burnout: High (70%)",
                      Colors.red,
                    ),
                    const SizedBox(height: 10),
                    _buildReportCard(
                      context,
                      "Fatima Khalid",
                      "Stress: Low (20%)",
                      "Anxiety: Moderate (50%)",
                      "Burnout: Low (30%)",
                      Colors.green,
                    ),
                    const SizedBox(height: 10),
                    _buildReportCard(
                      context,
                      "Sara Omar",
                      "Stress: Moderate (60%)",
                      "Anxiety: High (70%)",
                      "Burnout: Moderate (50%)",
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context,
    String name,
    String stressLevel,
    String anxietyLevel,
    String burnoutLevel,
    Color indicatorColor,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: indicatorColor,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stressLevel),
            Text(anxietyLevel),
            Text(burnoutLevel),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.visibility, color: Colors.blue),
          onPressed: () {
            Navigator.pushNamed(context, '/report_details'); // الانتقال إلى صفحة التقرير
          },
        ),
      ),
    );
  }
}