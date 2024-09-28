import 'dart:async';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<StatefulWidget> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  final double maxSeconds = 60;
  double seconds = 60;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  Timer? _timer;

  _CountdownTimerState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (seconds > 1) {
          seconds--;
        } else {
          seconds = maxSeconds;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Timer")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Row(
                children: [
                  DashedCircularProgressBar.aspectRatio(
                    aspectRatio: 1, // width ÷ height
                    valueNotifier: _valueNotifier,
                    progress: (seconds / maxSeconds) * 100,
                    startAngle: 225,
                    sweepAngle: 270,
                    foregroundColor: Colors.green,
                    backgroundColor: const Color(0xffeeeeee),
                    foregroundStrokeWidth: 15,
                    backgroundStrokeWidth: 15,
                    animation: true,
                    seekSize: 6,
                    seekColor: const Color(0xffeeeeee),
                    child: Center(
                      child: ValueListenableBuilder(
                          valueListenable: _valueNotifier,
                          builder: (_, double value, __) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${(seconds).toInt()} s',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 60),
                                  ),
                                ],
                              )),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
