import 'package:flutter/material.dart';
import 'privacy_security_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profile",
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
              Navigator.pushNamed(context, '/notifications'); // صفحة الإشعارات
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDE4D7), Color(0xFFFAD2E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة الملف الشخصي
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue[200],
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // الأكشن عند الضغط على Edit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Edit"),
                ),
                const SizedBox(height: 20),
                // معلومات المستخدم
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
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildInfoRow("Name", userData['name']),
                        _buildInfoRow("Email", userData['email']),
                        _buildInfoRow("Phone Number", userData['phone']),
                        _buildInfoRow("Role", userData['role']),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // إعدادات الحساب
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Change Password"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.pushNamed(context, '/reset_password');
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text("Privacy & Security Settings"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrivacySecuritySettingsScreen(),
      ),
    );
  },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // تفضيلات المستخدم
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    title: const Text("Language"),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // الأكشن عند الضغط
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}