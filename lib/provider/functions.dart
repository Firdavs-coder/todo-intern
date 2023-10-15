import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants/model.dart';

class Functions with ChangeNotifier {
  List<ToDoItem> storageData = [];
  List<ToDoItem> items = [];

  void addItem(ToDoItem item, [int? index]) {
    if (index != null) {
      items[index] = item;
      storageData[index] = item;
    } else {
      items.add(item);
      storageData.add(item);
    }
    saveData();
    notifyListeners();
  }

  void complete(int index) {
    ToDoItem item = items[index];
    items[index] = ToDoItem(
      title: item.title,
      description: item.description,
      date: item.date,
      isCompleted: !item.isCompleted,
    );
    storageData[index] = ToDoItem(
      title: item.title,
      description: item.description,
      date: item.date,
      isCompleted: !item.isCompleted,
    );
    saveData();
    notifyListeners();
  }

  void delete(int index) {
    items.removeAt(index);
    storageData.removeAt(index);
    saveData();
    notifyListeners();
  }

  int pending() {
    return items
        .where((element) => element.isCompleted == false)
        .toList()
        .length;
  }

  void search(String query) {
    final suggestions = storageData.where((item) {
      final title = item.title.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    });
    items = suggestions.toList();
    notifyListeners();
  }

  Future<void> obtainData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> data = jsonDecode(prefs.getStringList("data")![0]);
    data.forEach((element) {
      storageData.add(ToDoItem(
        title: element['title'],
        description: element['desciption'],
        date: TimeOfDay(
            hour: int.parse(element['date'].toString().split(":")[0]),
            minute: int.parse(element['date'].toString().split(":")[1])),
        isCompleted: element['isCompleted'],
      ));
    });
    items = storageData;
    notifyListeners();
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> jsonData = [];

    storageData.forEach((element) {
      jsonData.add({
        "title": element.title,
        "desciption": element.description,
        "date": "${element.date.hour}:${element.date.minute}",
        "isCompleted": element.isCompleted
      });
    });

    prefs.setStringList("data", [jsonEncode(jsonData)]);
  }
}
