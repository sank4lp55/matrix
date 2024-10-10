import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG rendering
import 'package:matrix/Screens/homescreen.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/Fusion festival 2009.jpeg", // Change this to your event-related onboarding image
              fit: BoxFit.cover, // Make sure the image covers the entire screen
            ),
          ),
          // Foreground content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // SVG logo
                      SvgPicture.asset(
                        'assets/icons/logo_named.svg', // Path to your SVG file
                        height: 30, // Adjust height as needed
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(), // You can remove this if not needed
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Glassmorphism effect container
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2), // Semi-transparent background
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // Blur effect
                            child: Container(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dive into the World of Thrilling Events!",
                                    style: theme.textTheme.displaySmall?.copyWith(
                                      color: Colors.white, // Change text color to contrast with background
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Discover and manage events effortlessly. Connect with organizers, view details, and RSVP with just a few taps with MATRIX!",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.white, // Change text color to contrast with background
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: double.infinity,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeScreen()),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(10), // Ensure InkWell has the same border radius
                                      child: Container(
                                        width: double.infinity,
                                        height: 56, // Adjust height as needed
                                        decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius: BorderRadius.circular(10), // Rounded corners
                                        ),
                                        child: Center( // Center the text within the container
                                          child: Text(
                                            "Get Started",
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              color: theme.colorScheme.onPrimary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
