import 'package:flutter/material.dart';
import 'package:habit_tracker/add_habit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Habit Tracker')),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No habits yet!'),
            Text('Click the + button to add a new habit.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHabit()),
          );
        },
        child: Icon(Icons.add, color: Colors.blueGrey),
      ),
    );
  }
}
