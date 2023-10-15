import 'package:flutter/material.dart';
import 'bottomsheet.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (BuildContext context) {
              return CustomBottomSheet(
                titleController: TextEditingController(),
                descriptionController: TextEditingController(),
                selectedTime: TimeOfDay.now(),
              );
            },
          );
        },
        child: const Text(
          "Add new task",
          style: TextStyle(letterSpacing: 2),
        ),
      ),
    );
  }
}
