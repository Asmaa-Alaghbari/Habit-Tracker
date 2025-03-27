import 'package:flutter/material.dart';
import 'package:habit_tracker/homepage.dart';

void main() => runApp(HabitTrackerApp());

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Homepage(),
    );
  }
}
