import 'package:flutter/material.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  String _habitName = ''; // Habit name
  String _habitDescription = ''; // Habit description
  bool _habitRepeat = false; // Reminder habit
  final List<String> _selectedDays = []; // Selected days for the habit
  TimeOfDay _selectedTime = TimeOfDay.now(); // Selected time for the habit
  final TextEditingController _timeController =
      TextEditingController(); // Controller for the time input field

  // List of days of the week
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  // Initialize the time controller with the current time
  @override
  void initState() {
    super.initState();
    _timeController.text = _formatTime(_selectedTime);
  }

  // Dispose of the time controller when the widget is removed from the widget tree
  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  // Format the time to a string
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // Show the time picker dialog
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.teal[400]!),
          ),
          child: child!,
        );
      },
    );

    // Update the selected time if the user picked a new time
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _formatTime(_selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Your New Habit',
            style: TextStyle(
              fontFamily: 'Sans Serif',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[850],
            ),
          ),
        ),
        backgroundColor: Colors.teal[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: 'Habit Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _habitName = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _habitDescription = value!;
                },
              ),
              const SizedBox(height: 20),
              // Reminder toggle switch
              Row(
                children: [
                  Text(
                    'Do you need a reminder?',
                    style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeColor: Colors.teal[400],
                      activeTrackColor: Colors.teal[200],
                      inactiveThumbColor: Colors.grey[850],
                      inactiveTrackColor: Colors.grey[300],
                      value: _habitRepeat,
                      onChanged: (value) {
                        setState(() {
                          _habitRepeat = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // If reminder is enabled, show day and time selection
              if (_habitRepeat) ...[
                const SizedBox(height: 20),
                Text(
                  'Select days you want to be reminded:',
                  style: TextStyle(fontSize: 16, color: Colors.teal[700]),
                ),
                const SizedBox(height: 8),
                // Day selection chips
                Wrap(
                  spacing: 8, // Horizontal spacing between chips
                  runSpacing: 8, // Vertical spacing between chips
                  children:
                      _daysOfWeek.map((day) {
                        // Check if the day is selected
                        final isSelected = _selectedDays.contains(day);
                        return FilterChip(
                          label: Text(day),
                          selected: isSelected,
                          selectedColor: Colors.teal[100],
                          checkmarkColor: Colors.teal[800],
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDays.add(day);
                              } else {
                                _selectedDays.remove(day);
                              }
                            });
                          },
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),
                // Time picker
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time, color: Colors.teal[400]),
                      onPressed: () => _selectTime(context),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectTime(context),
                  validator: (value) {
                    if (_habitRepeat && (value == null || value.isEmpty)) {
                      return 'Please select a time';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 30),
              // Button to add the habit
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, {
                      'name': _habitName,
                      'description': _habitDescription,
                      'repeat': _habitRepeat,
                      'repeatDays': _habitRepeat ? _selectedDays : null,
                      'repeatTime':
                          _habitRepeat ? _formatTime(_selectedTime) : null,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Add Habit',
                  style: TextStyle(
                    color: Colors.teal[400],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
