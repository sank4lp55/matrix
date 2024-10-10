
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/Blocs/event_bloc.dart';
import 'package:matrix/Repositories/event_repopsitory.dart';
import 'package:matrix/Screens/onboarding.dart';
import 'package:matrix/temp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventBloc(EventRepository()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffA2B69FFF)),
          useMaterial3: true,
          primaryColor: Color(0xff0f2208),
        ),
        home: OnboardingPage(),
      ),
    );
  }
}