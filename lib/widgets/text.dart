import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/functions.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello Mohin",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          Consumer<Functions>(builder: (context, functions, child) {
            return Text(
              "${functions.pending()} tasks are pending",
              style: const TextStyle(color: Colors.grey),
            );
          })
        ],
      ),
    );
  }
}
