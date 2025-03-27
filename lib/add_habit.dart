import 'package:flutter/material.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  // Form key for validation and saving form data
  final _formKey = GlobalKey<FormState>();
  String _habitName = '';
  String _habitDescription = '';
  bool _habitRepeat = false;
  String _habitRepeatDay = '';
  String _habitRepeatTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
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
        backgroundColor: Colors.orange[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 20,
                decoration: InputDecoration(labelText: 'Habit Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _habitName = value!;
                },
              ),
              TextFormField(
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Habit Description'),
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
              // Do you want to remind yourself to do this habit?
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'Do you need a reminder?',
                      style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          activeColor: Colors.orange[400],
                          activeTrackColor: Colors.orange[200],
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
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(context, {
                        'name': _habitName,
                        'description': _habitDescription,
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    'Add Habit',
                    style: TextStyle(color: Colors.orange[200], fontSize: 16),
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
