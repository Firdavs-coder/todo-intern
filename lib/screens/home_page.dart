import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/functions.dart';
import 'package:todo/widgets/stepper.dart';

import '../widgets/appbar.dart';
import '../widgets/bottom.dart';
import '../widgets/search.dart';
import '../widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 1800), () {
      setState(() {
        isLoaded = true;
      });
      context.read<Functions>().obtainData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(),
          SearchWidget(),
          isLoaded
              ? const CustomStepper()
              : const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const BottomButton(),
    );
  }
}
