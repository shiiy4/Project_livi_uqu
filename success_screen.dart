import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الانتقال التلقائي بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/employee_home');
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDE4D7), Color(0xFFFAD2E1)], // الخلفية المتدرجة
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), // رفع الشعار
            // الشعار
            Image.asset(
              'assets/logo.png',
              height: 120,
            ),
            const SizedBox(height: 20),
            
            const SizedBox(height: 40),
            // الحاوية (Container) الخاصة بالرسالة
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'THANKS!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You Login Successfully',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // أيقونة النجاح
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 120,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
