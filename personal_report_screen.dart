import 'package:flutter/material.dart';

class PersonalReportScreen extends StatelessWidget {
  const PersonalReportScreen({super.key});

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
            Navigator.pop(context); // الرجوع إلى الصفحة السابقة
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // الانتقال لصفحة الإشعارات
              // الأكشن عند الضغط
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reports list",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // تقرير الاحتراق الوظيفي فقط
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(
                leading: const Icon(
                  Icons.insert_chart_outlined,
                  size: 40,
                  color: Colors.black54,
                ),
                title: const Text(
                  "Burnout Personal Report",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Generated by AI"),
                trailing: TextButton(
                  onPressed: () {
                    // الانتقال إلى صفحة عرض التقرير
                    Navigator.pushNamed(context, '/burnout_report_view');
                  },
                  child: const Text(
                    "View",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Survey",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: 1, // الصفحة الحالية
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/employee_home'); // الانتقال إلى الصفحة الرئيسية
          }
        },
      ),
    );
  }
}