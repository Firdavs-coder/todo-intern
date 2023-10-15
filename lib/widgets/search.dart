import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/functions.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  SearchWidget({
    super.key,
  });

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final functions = Provider.of<Functions>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
      child: TextField(
        onChanged: (query) => functions.search(query),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          prefixIcon: Icon(
            Icons.search_outlined,
            size: 20,
            color: Colors.deepPurple,
          ),
          suffixIcon: Icon(
            Icons.filter_list,
            size: 20,
            color: Colors.deepPurple,
          ),
          hintText: "Search tasks",
        ),
      ),
    );
  }
}
