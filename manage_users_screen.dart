import 'package:flutter/material.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Manage Users",
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
              // الأكشن عند الضغط على الإشعارات
              Navigator.pushNamed(context, '/notifications'); // الانتقال لصفحة الإشعارات
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
              // كارد المستخدمين
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Users List",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // الأكشن عند الضغط على زر +
                               Navigator.pushNamed(context, '/add_user'); // التنقل إلى صفحة Add User
                            },
                            icon: const Icon(Icons.add, color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // قائمة المستخدمين
                      ListView(
                        shrinkWrap: true,
                        children: [
                          _buildUserCard(
                            context,
                            "Nora Ali",
                            "Nora1@gmail.com",
                            "Employee",
                            true,
                          ),
                          const SizedBox(height: 10),
                          _buildUserCard(
                            context,
                            "Fatima Khalid",
                            "Fatima42@gmail.com",
                            "Employee",
                            false,
                          ),
                          const SizedBox(height: 10),
                          _buildUserCard(
                            context,
                            "Sara Omar",
                            "SaraO@gmail.com",
                            "Employee",
                            true,
                          ),
                          const SizedBox(height: 10),
                          _buildUserCard(
                            context,
                            "Wafaa Mohammad",
                            "Wafaa2@gmail.com",
                            "Manager",
                            true,
                          ),
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

  Widget _buildUserCard(
    BuildContext context,
    String name,
    String email,
    String role,
    bool isActive,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFFAD2E1),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        isActive ? "Active" : "Inactive",
                        style: TextStyle(
                          fontSize: 14,
                          color: isActive ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: isActive ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // الأكشن عند الضغط على تعديل
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // الأكشن عند الضغط على حذف
                _showDeleteConfirmation(context, name); // استدعاء دالة نافذة التأكيد
              },
            ),
          ],
        ),
      ),
    );
  }
}
void _showDeleteConfirmation(BuildContext context, String userName) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Employee"),
        content: Text("Are you sure you want to delete $userName?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // إغلاق النافذة بدون تنفيذ أي إجراء
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              // تنفيذ عملية الحذف هنا
              Navigator.pop(context); // إغلاق النافذة
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$userName has been deleted.")),
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
