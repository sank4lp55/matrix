import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix/Screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Initial opacity

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    // Start the fade-in animation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0; // Fade in the logo
      });
    });

    // Wait for 2 more seconds after the logo is fully visible
    Future.delayed(const Duration(seconds: 3), () {
      _navigateToOnboarding();
    });
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1), // Duration of the fade-in
          child: SvgPicture.asset(
            'assets/icons/logo_named.svg',
            width: 170,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
