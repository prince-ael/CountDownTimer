import 'package:flutter/material.dart';
import 'dart:async';

class CountDownTimer extends StatefulWidget {
  final int tickInterval;
  final int totalElapsedTimeInSeconds;
  final TextStyle style;

  CountDownTimer({
    this.style = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.blue,
    ),
    this.tickInterval = 1,
    this.totalElapsedTimeInSeconds = 120,
  });
  @override
  CountDownTimerState createState() {
    return CountDownTimerState();
  }
}

class CountDownTimerState extends State<CountDownTimer> {
  int _timeRemaining;

  void callback(Timer timer) {
    if (_timeRemaining == 0) {
      timer.cancel();
      return;
    }
    setState(() {
      _timeRemaining = _timeRemaining - widget.tickInterval;
    });
  }

  List<String> twoDigitMinute() {
    final duration = Duration(seconds: _timeRemaining);
    return [
      duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
      duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
    ];
  }

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.totalElapsedTimeInSeconds;
    Timer.periodic(Duration(seconds: widget.tickInterval), callback);
  }

  @override
  Widget build(BuildContext context) {
    final minAndSec = twoDigitMinute();
    return Text(
      "${minAndSec[0]} : ${minAndSec[1]}",
      style: widget.style,
    );
  }
}
