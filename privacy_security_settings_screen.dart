import 'package:flutter/material.dart';

class PrivacySecuritySettingsScreen extends StatefulWidget {
  const PrivacySecuritySettingsScreen({super.key});

  @override
  _PrivacySecuritySettingsScreenState createState() =>
      _PrivacySecuritySettingsScreenState();
}

class _PrivacySecuritySettingsScreenState
    extends State<PrivacySecuritySettingsScreen> {
  bool twoFactorAuth = false;
  bool securityAlerts = false;
  bool enableNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Privacy & Security Settings",
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
              Navigator.pushNamed(context, '/notifications');
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // قسم Security
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
                        "Security",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      SwitchListTile(
                        title: const Text("Two-Factor Authentication"),
                        value: twoFactorAuth,
                        onChanged: (bool value) {
                          setState(() {
                            twoFactorAuth = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text("Security Alerts"),
                        value: securityAlerts,
                        onChanged: (bool value) {
                          setState(() {
                            securityAlerts = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // قسم Notifications
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
                        "Notification",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      SwitchListTile(
                        title: const Text("Enable Notification"),
                        value: enableNotification,
                        onChanged: (bool value) {
                          setState(() {
                            enableNotification = value;
                          });
                        },
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
}