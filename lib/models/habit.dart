class Habit {
  String name;
  String description;
  int streak;
  bool completed;

  Habit({
    required this.name,
    required this.description,
    this.streak = 0,
    this.completed = false,
  });

  void incrementStreak() {
    streak++;
  }

  void resetStreak() {
    streak = 0;
  }

  void toggleCompleted() {
    completed = !completed;
  }
}


