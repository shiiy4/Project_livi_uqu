import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE4D7), // لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // الأكشن عند الضغط
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // الانتقال لصفحة الإشعارات
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // رسالة الترحيب
              const Text(
                "Hello",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "How is your mental health today?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              // شريط البحث
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // ملخص الحالة النفسية
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Mental Health Status Summary",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "more >",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Current Status: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "Needs Monitoring",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "",
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ],
                      ),
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Burnout Level: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "High (70%)",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ")",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Recommendations:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "- Take a 5-minute break every hour to reduce stress.\n"
                      "- Try guided meditation for 10 minutes daily to manage anxiety.\n"
                      "- Book a counseling session if burnout symptoms persist.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // الأزرار (Surveys، Personal Reports)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // زر Surveys
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/surveys'); // الانتقال إلى صفحة Surveys
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.assignment, size: 30, color: Colors.black),
                        SizedBox(height: 5),
                        Text(
                          "Surveys",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // زر Personal Reports
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/personal_reports'); // الانتقال إلى صفحة التقارير
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.bar_chart, size: 30, color: Colors.black),
                        SizedBox(height: 5),
                        Text(
                          "Personal Reports",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/profile'); // الانتقال إلى صفحة البروفايل
          }
        },
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
      ),
    );
  }
}