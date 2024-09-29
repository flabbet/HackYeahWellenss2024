import 'dart:async';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int time;
  const CountdownTimer(this.time, {super.key});

  @override
  State<StatefulWidget> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  double maxSeconds = 0;
  double seconds = 0;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void startTimer() {
    if(maxSeconds != widget.time){
    _timer?.cancel();
    maxSeconds = widget.time.toDouble();
    seconds = widget.time.toDouble();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (seconds > 1) {
          seconds--;
        } else {
          Navigator.of(context).pop();
        }
      });
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    startTimer();

    

    return 
         ValueListenableBuilder(
             valueListenable: _valueNotifier,
             builder: (_, double value, __) => Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Text(
                       '${formatMinutes(seconds)}:${(formatSeconds(seconds))}',
                       style: const TextStyle(
                           fontSize: 60),
                     ),
                   ],
                 ));
  
  
  }
  
  formatMinutes(double seconds) {
    return (seconds / 60).floor();
  }
  
  formatSeconds(double seconds) {
    return (seconds - formatMinutes(seconds) * 60).toInt();
  }
}
