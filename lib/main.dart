import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/Blocs/event_bloc.dart';
import 'package:matrix/Repositories/event_repopsitory.dart';
import 'package:matrix/Screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => EventBloc(EventRepository()),
        child: HomeScreen(),
      ),
    );
  }
}
