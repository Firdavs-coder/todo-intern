import 'package:flutter/material.dart';

class ToDoItem with ChangeNotifier {
  String title;
  String description;
  TimeOfDay date;
  bool isCompleted = false;

  ToDoItem({
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });
}
