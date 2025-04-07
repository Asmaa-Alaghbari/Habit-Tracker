import 'package:flutter/material.dart';
import 'package:habit_tracker/add_habit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> habits = []; // List to store habit data
  final Map<int, bool> _expandedDescriptions =
      {}; // Map to track expanded descriptions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Track Your Habits 📝')),
        backgroundColor: Colors.teal[200],
        elevation: 0, // Remove shadow
      ),
      body:
          habits.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, size: 50, color: Colors.teal[200]),
                    const SizedBox(height: 20), // Space between icon and text
                    Text(
                      'No habits yet!',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Click the + button to add a new habit',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              // Display the list of habits
              : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  final isExpanded = _expandedDescriptions[index] ?? false;
                  final descriptionLines = habit['description']!.split('\n');
                  final firsLine = descriptionLines.first;
                  final remainingLines =
                      descriptionLines.length > 1
                          ? descriptionLines.sublist(1).join('\n')
                          : null;

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[100],
                        child: Text(
                          habit['name']![0], // Display first letter of habit name
                          style: TextStyle(color: Colors.teal[800]),
                        ),
                      ),
                      title: Text(
                        habit['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(firsLine),

                          if (isExpanded && remainingLines != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(remainingLines),
                            ),

                          if (remainingLines != null)
                            // Expandable text
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _expandedDescriptions[index] = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? 'Show less' : 'Show more',
                                style: TextStyle(
                                  color: Colors.teal[600],
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),

                          if (habit['repeat'] == true) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Reminder: ${_formatDays(habit['repeatDays'])} at ${habit['repeatTime']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.teal[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                      trailing: IconButton(
                        // Right icon for delete
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmationDialog(index),
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[200],
        onPressed: () async {
          final newHabit = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabit()),
          );

          // Add the new habit to the list if it's not null
          if (newHabit != null) {
            setState(() {
              habits.add(newHabit);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Format the days for display
  String _formatDays(List<String>? days) {
    if (days == null || days.isEmpty) return 'No days selected';

    // Convert full day names to abbreviations
    final abbreviatedDays =
        days.map((day) {
          return day.substring(0, 3); // Take first 3 letters (Mon, Tue, etc.)
        }).toList();

    return abbreviatedDays.join(', ');
  }

  // Delete the habit from the list
  void _deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
      _expandedDescriptions.remove(index); // Remove the expanded state
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Habit deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Show a confirmation dialog before deleting a habit
  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete", textAlign: TextAlign.center),
          content: Text(
            "Are you sure you want to delete the habit '${habits[index]['name']}'?",
          ),
          actions: [
            TextButton(
              // Delete button
              onPressed: () {
                Navigator.of(context).pop();
                _deleteHabit(index);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),

            TextButton(
              // Cancel button
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
