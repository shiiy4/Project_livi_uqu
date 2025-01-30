import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/validation_screen.dart';
import 'screens/success_screen.dart';
import 'screens/employee_home_Screen.dart';
import 'screens/surveys_screen.dart';
import 'screens/burnout_survey_screen.dart';
import 'screens/personal_report_screen.dart';
import 'screens/burnout_report_view_screen.dart' as report_view;
import 'screens/manager_home_screen.dart';
import 'screens/manage_survey_screen.dart';
import 'screens/manage_users_screen.dart';
import 'screens/manager_employees_reports_screen.dart';
import 'screens/manager_view_survey_screen.dart';
import 'screens/manager_edit_survey_screen.dart';
import 'screens/new_survey_screen.dart';
import 'screens/add_user_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/privacy_security_settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // بيانات المستخدمين
  final Map<String, Map<String, String>> usersData = {
    'ahmed.ali@example.com': {
      'password': 'password123',
      'role': 'Manager',
      'name': 'Ahmed Ali',
      'phone': '+966 50 000 0000',
    },
    'sara.mohammed@example.com': {
      'password': 'password123',
      'role': 'Manager',
      'name': 'Sara Mohammed',
      'phone': '+966 55 111 1111',
    },
    'employee@example.com': {
      'password': 'password123',
      'role': 'Employee',
      'name': 'Employee User',
      'phone': '+966 50 222 2222',
    },
  };

  bool isLoggedIn = false;
  Map<String, String>? currentUserData;

  // دالة تسجيل الدخول
  void login(String email, String password) {
    if (usersData.containsKey(email) &&
        usersData[email]!['password'] == password) {
      setState(() {
        isLoggedIn = true;
        currentUserData = {
          ...usersData[email]!,
          'email': email,
        };
      });
    } else {
      // رسالة خطأ في حالة تسجيل الدخول الفاشل
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isManager = currentUserData?['role'] == 'Manager';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Livi App',
      home: isLoggedIn
          ? (isManager ? const ManagerHomeScreen() : const EmployeeHomeScreen())
          : LoginScreen(onLogin: login),
      routes: {
        '/login': (context) => LoginScreen(onLogin: login),
        '/validation': (context) => const ValidationScreen(),
        '/success': (context) => const SuccessScreen(),
        '/employee_home': (context) => const EmployeeHomeScreen(),
        '/surveys': (context) => const SurveysScreen(),
        '/burnout_survey': (context) => const BurnoutSurveyScreen(),
        '/personal_reports': (context) => const PersonalReportScreen(),
        '/burnout_report_view': (context) => report_view.BurnoutReportViewScreen(
              diagnosis: 'Needs Monitoring', // تأكد من تمرير التشخيص المناسب
            ),
        '/manager_home': (context) => const ManagerHomeScreen(),
        '/manage_survey': (context) => const ManageSurveyScreen(),
        '/manage_users': (context) => const ManageUsersScreen(),
        '/manager_employees_reports': (context) =>
            const ManagerEmployeesReportsScreen(),
        '/manager_view_survey': (context) => const ManagerViewSurveyScreen(
              surveyTitle: "Survey Title",
              surveyDetails: "Survey Details",
            ),
        '/manager_edit_survey': (context) => const ManagerEditSurveyScreen(
              surveyTitle: "Survey Title",
            ),
        '/new_survey': (context) => const NewSurveyScreen(),
        '/add_user': (context) => const AddUserScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/new_password': (context) => const NewPasswordScreen(),
        '/profile': (context) => ProfileScreen(
              userData: currentUserData ?? {},
            ),
        '/privacy_security_settings': (context) =>
            const PrivacySecuritySettingsScreen(),
      },
    );
  }
}