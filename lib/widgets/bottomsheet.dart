import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/model.dart';
import 'package:todo/provider/functions.dart';

// ignore: must_be_immutable
class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedTime,
    this.isEdit = false,
    this.index = 0,
  });

  TextEditingController titleController;
  TextEditingController descriptionController;
  bool isEdit;
  int index;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.titleController.text);
    descriptionController =
        TextEditingController(text: widget.descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextFormField(
              controller: titleController,
              maxLength: 400,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: "Title",
                labelStyle: TextStyle(fontSize: 14),
              ),
              validator: (value) {
                if (value!.isEmpty || value == "") {
                  return 'Title form is not valid';
                }
                return null;
              },
            ),
            //
            const SizedBox(height: 15),
            //
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: TextFormField(
                controller: descriptionController,
                minLines: null,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: "Description",
                  labelStyle: TextStyle(fontSize: 14),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            //
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  widget.selectedTime = (await showTimePicker(
                      context: context, initialTime: widget.selectedTime))!;
                },
                child: const Text("Time"),
              ),
            ),
            //
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"),
                  ),
                  Consumer<Functions>(builder: (context, functions, child) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ToDoItem newItem = ToDoItem(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: widget.selectedTime,
                            isCompleted: widget.isEdit
                                ? functions.items[widget.index].isCompleted
                                : false,
                          );
                          if (widget.isEdit) {
                            functions.addItem(newItem, widget.index);
                          } else {
                            functions.addItem(newItem);
                          }
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Save"),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
