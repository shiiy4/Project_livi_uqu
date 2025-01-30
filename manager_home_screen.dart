import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Manager Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // الأكشن عند الضغط على زر القائمة
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // الانتقال لصفحة الإشعارات
              // الأكشن عند الضغط على زر الإشعارات
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط الترحيب
            const Text(
              "Hello, Asmaa",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // حقل البحث
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            // لوحة Burnout Rates
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Employees Mental Health Status Dashboard",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
  padding: const EdgeInsets.symmetric(vertical: 10.0),
  child: PieChart(
    dataMap: {
      "High": 60,
      "Medium": 30,
      "Low": 10,
    },
    animationDuration: const Duration(milliseconds: 800),
    chartRadius: MediaQuery.of(context).size.width / 3.5, // حجم الدائرة
    colorList: [Colors.red, Colors.orange, Colors.green], // ألوان الأقسام
    chartType: ChartType.disc, // جعل الدائرة ممتلئة بالكامل
    legendOptions: const LegendOptions(
      showLegends: false, // إزالة النصوص خارج الدائرة
    ),
    chartValuesOptions: const ChartValuesOptions(
      showChartValues: true, // عرض النصوص داخل الدائرة فقط
      showChartValuesInPercentage: true, // عرض النسب المئوية
      showChartValuesOutside: false, // النصوص داخل الدائرة فقط
      decimalPlaces: 0, // الأرقام بدون كسور عشرية
    ),
  ),
),





                    
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // أزرار التنقل
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildNavigationButton(
                    context,
                    "Manage Surveys",
                    Icons.assignment,
                    () {
                      Navigator.pushNamed(context, '/manage_survey');
                    },
                  ),
                  _buildNavigationButton(
                    context,
                    "Employees Reports",
                    Icons.insert_chart_outlined,
                    () {
                      Navigator.pushNamed(context, '/manager_employees_reports');
                    },
                  ),
                  _buildNavigationButton(
                    context,
                    "User Management",
                    Icons.person,
                    () {
                      Navigator.pushNamed(context, '/manage_users');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black54),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}