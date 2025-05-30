import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_images/App_images.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFFFAFB),
              Color(0xFFFFD7C599),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.splashLogo,
            height: height / 1,
            width: width / 1,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
