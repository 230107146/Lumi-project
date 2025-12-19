import 'package:flutter/material.dart';

enum AddictionType { counter, timer }

class Habit {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final int dailyGoal;
  final int currentProgress;
  final AddictionType type;

  const Habit({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.dailyGoal,
    required this.currentProgress,
    required this.type,
  });
}
