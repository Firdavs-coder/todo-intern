import 'dart:math';

import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/model.dart';
import 'package:todo/provider/functions.dart';

import '../constants/colors.dart';
import 'bottomsheet.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});
  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Consumer<Functions>(
          builder: (context, functions, child) {
            return functions.items.isNotEmpty
                ? EnhanceStepper(
                    physics: const ClampingScrollPhysics(),
                    key: Key(Random.secure().nextDouble().toString()),
                    currentStep: _currentStep,
                    onStepTapped: (index) {
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    controlsBuilder: (context, details) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: () => functions.complete(_currentStep),
                              style: ButtonStyle(
                                backgroundColor: buttoBackgroundColor,
                              ),
                              icon: const Icon(Icons.check, size: 15),
                              label: Text(
                                  functions.items[_currentStep].isCompleted
                                      ? "Incomplete"
                                      : "Complete",
                                  style: const TextStyle(fontSize: 10)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Are you sure to delete this todo item ?",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              try {
                                                functions.delete(_currentStep);
                                              } catch (e) {}
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Delete"),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: buttoBackgroundColor),
                              icon: const Icon(Icons.delete, size: 15),
                              label: const Text("Delete",
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: TextButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isDismissible: false,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    ToDoItem item =
                                        functions.items[_currentStep];

                                    return CustomBottomSheet(
                                      titleController: TextEditingController(
                                          text: item.title),
                                      descriptionController:
                                          TextEditingController(
                                              text: item.description),
                                      selectedTime:
                                          functions.items[_currentStep].date,
                                      isEdit: true,
                                      index: _currentStep,
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                  backgroundColor: buttoBackgroundColor),
                              icon: const Icon(Icons.edit, size: 15),
                              label: const Text("Edit",
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    steps: functions.items
                        .asMap()
                        .map((index, value) {
                          return MapEntry(
                            index,
                            EnhanceStep(
                              icon: CircleAvatar(
                                backgroundColor: value.isCompleted
                                    ? Colors.green
                                    : Colors.deepPurple,
                                radius: 15,
                                child: Icon(
                                  value.isCompleted ? Icons.check : Icons.alarm,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              isActive: _currentStep == index,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.title,
                                    style: value.isCompleted
                                        ? const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey,
                                          )
                                        : null,
                                  ),
                                  Text(
                                    value.date.format(context),
                                    style: value.isCompleted
                                        ? const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey,
                                            fontSize: 13,
                                          )
                                        : const TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              content: Text(value.description),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
