import 'dart:async';

import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget {
  const LoadingText({super.key});

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText> {
  // set text message
  final List _mssg = [
    "Loading      ",
    "Loading .    ",
    "Loading . .  ",
    "Loading . . ."
  ];

  // track text message
  int _currentTextMssg = 0;

  // animation timing
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Start the timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentTextMssg = (_currentTextMssg + 1) % _mssg.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            _mssg[_currentTextMssg],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 100, 100, 255),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const CircularProgressIndicator(
            color: Color.fromARGB(255, 100, 100, 255),
            strokeCap: StrokeCap.round,
          )
        ],
      ),
    );
  }
}
