# Habit Tracker App

**Track, Build, and Maintain Your Daily Habits!**

A Flutter-based mobile application designed to help users build and track daily habits. Create
custom habits, set reminders, and monitor your progress over time. Perfect for personal development,
fitness goals, or productivity tracking.

## Table of Contents

- [Project Details](#project-details)
- [Features](#features)
- [How to Use](#how-to-use)
- [Requirements](#requirements)
- [Code Structure](#code-structure)
- [References](#references)

---

## Project Details

- **Start Date**: 31/03/2025
- **Last Update**: 07/04/2025
- **Programming Language**: Dart (Flutter)
- **Tool Used**: Android Studio
- **App Type**: Mobile (Android/iOS), Cross-Platform
- **Theme**: Teal & BlueGrey Color Scheme

---

## Features

✅ **Add Custom Habits** – Name, description, and reminders  
✅ **Reminder System** – Set repeat days and times  
✅ **Clean UI** – Card-based habit list with intuitive controls  
✅ **Delete Habits** – Confirmation dialog before removal  
✅ **Responsive Design** – Works on different screen sizes

---

## How to Use

### Installation

1. **Clone the repository**:
   ```bash
   git https://github.com/Asmaa-Alaghbari/Habit-Tracker
   ```
2. **Open in IDE** (Android Studio / VS Code).
3. **Run the app**:
   ```bash
   flutter run
   ```

### Usage Guide

1. **Home Screen**:
    - Displays all habits in a scrollable list.
    - Empty state shows an "Add Habit" prompt.

2. **Adding a Habit**:
    - Tap the **+** (FAB) button.
    - Fill in:
        - **Title** (Required)
        - **Description** (Required)
        - **Reminder Toggle** (Enable for repeat habits) (Optional)
    - If reminders are enabled:
        - Select **days** (e.g., Mon, Wed, Fri).
        - Pick a **time** via time picker.
    - Press **"Add Habit"** to save.

3. **Deleting a Habit**:
    - Tap the **🗑️ (Delete)** icon on a habit card.
    - Confirm deletion in the dialog.

---

## Requirements

- **Flutter SDK** (Latest Stable Version)
- **Android/iOS Emulator** or Physical Device
- **Dart** (Included with Flutter)
- **VS Code / Android Studio** (Recommended)

---

## Code Structure

| File/Class       | Description                                                            |
|------------------|------------------------------------------------------------------------|
| `main.dart`      | App entry point, sets up `MaterialApp` with theme.                     |
| `homepage.dart`  | Main screen with habit list, FAB, and delete logic.                    |
| `add_habit.dart` | Form for creating new habits with validation.                          |
| `habits` List    | Stores habit data (`name`, `description`, `repeatDays`, `repeatTime`). |
| `_formatDays()`  | Converts `['Monday',...]` → `"Mon, Wed, Fri"`.                         |
| `_selectTime()`  | Opens time picker and updates UI.                                      |
| `_deleteHabit()` | Removes a habit from the list with SnackBar feedback.                  |

---

## References

- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design Guidelines](https://material.io/design)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [TimeOfDay Class (Flutter)](https://api.flutter.dev/flutter/material/TimeOfDay-class.html)
