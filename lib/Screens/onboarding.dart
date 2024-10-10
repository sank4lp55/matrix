import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc package
import 'package:matrix/Screens/homescreen.dart';
import 'package:matrix/Widgets/matrix_button.dart';
import '../Blocs/event_bloc.dart';
import '../utils/constants.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  void _handleGetStarted(BuildContext context) {
    // Dispatch the LoadEvents event to fetch the events
    context.read<EventBloc>().add(LoadEvents());

    // Navigate to Homescreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Homescreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final screenPadding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.onboardingImage,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenPadding.top * 0.9,
                  ),
                  child: SvgPicture.asset(
                    ImageConstants.namedLogo,
                    height: screenSize.height * 0.035,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                          child: Container(
                            padding: EdgeInsets.all(screenSize.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dive into the World of Thrilling Events!",
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 0.07,
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.01),
                                Text(
                                  "Discover and manage events effortlessly. Connect with organizers, view details, and RSVP with just a few taps with MATRIX!",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: screenSize.width * 0.045,
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.03),
                                MatrixButton(
                                  onTap: () => _handleGetStarted(context),
                                  text: "Get Started!",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
