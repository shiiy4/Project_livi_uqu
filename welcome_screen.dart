import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDE4D7), Color(0xFFFAD2E1)], // الألوان المتدرجة
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100), // مكان الشعار 
            // صورة الشعار
            Center(
              child: Image.asset(
                'assets/logo.png', // ضفت الصورة في مجلد assets
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            
            const SizedBox(height: 40),
          
            const Text(
              'WELCOME TO LIVI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black54, 
                fontFamily: 'Poppins', 
              ),
            ),
            const SizedBox(height: 20), // قللت المسافة بين النص وزر Log in
            // زر Log In
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // الانتقال للشاشة التالية
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFB58576), 
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFB58576), // لون النص داخل الزر
                ),
              ),
            ),
            const SizedBox(height: 20), 
            // اختيار اللغة
            const Text(
              'English | العربية',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54, // لون أسود خفيف
                fontFamily: 'Poppins', 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
