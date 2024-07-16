import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_vision/views/auth/login.dart';
import 'package:the_vision/views/onboarding.dart';

class TheVisionApp extends StatelessWidget {
  const TheVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> checkOnboarding() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('hasSeenOnboarding') ?? false;
    }

    return GetMaterialApp(
      title: 'The Vision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade900),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: checkOnboarding(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!
                ? const LoginScreen()
                : const OnboardingScreen();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const TheVisionApp());
}
