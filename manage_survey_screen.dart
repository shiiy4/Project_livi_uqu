import 'package:flutter/material.dart';

class ManageSurveyScreen extends StatelessWidget {
  const ManageSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Manage Surveys",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // العودة إلى الصفحة السابقة
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
              // أزرار التنقل العلوية
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/manage_users');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text(
                      "Manage Users",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFAD2E1),
                    ),
                    child: const Text("Manage Survey"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // كارد قائمة الاستبيانات
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العنوان وزر New
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Surveys list",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // الأكشن عند الضغط على New
                              Navigator.pushNamed(context, '/new_survey');
                            },
                            icon: const Icon(Icons.add, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // قائمة الاستبيانات
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildSurveyCard(
                            context,
                            "Survey 1",
                            "20 Questions",
                            "3 Completed Answers",
                            true, // مفعل
                          ),
                          const SizedBox(height: 10),
                          _buildSurveyCard(
                            context,
                            "Survey 2",
                            "20 Questions",
                            "10 Completed Answers",
                            false, // غير مفعل
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // كارد إحصائيات الأداء
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Survey Performance Analytics",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Completed Surveys: "),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.8,
                              color: const Color(0xFFFAD2E1),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("80%"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Most responded to surveys:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text("Survey 2"),
                      const SizedBox(height: 10),
                      const Text(
                        "Employees who have not yet participated:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: const [
                          CircleAvatar(child: Text("N")),
                          SizedBox(width: 10),
                          CircleAvatar(child: Text("S")),
                          SizedBox(width: 10),
                          CircleAvatar(child: Text("F")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurveyCard(
    BuildContext context,
    String title,
    String questionInfo,
    String completedAnswers,
    bool isActive,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: Switch(
          value: isActive,
          onChanged: (value) {
            // الأكشن عند التبديل
          },
          activeColor: const Color.fromARGB(255, 72, 218, 76), // لون زر التفعيل عند التفعيل
          inactiveThumbColor: const Color.fromARGB(255, 118, 100, 100), // لون الزر عند التعطيل
         
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(questionInfo),
            Text(completedAnswers),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.pushNamed(context, '/manager_edit_survey');
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmation(context, title);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String surveyTitle) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Survey"),
          content: Text("Are you sure you want to delete '$surveyTitle'?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("'$surveyTitle' has been deleted.")),
                );
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}