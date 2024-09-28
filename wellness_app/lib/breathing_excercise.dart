import 'package:flutter/material.dart';
import 'package:wellness_app/timer.dart';

class BreathingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BreathingPageState(); 
}

class BreathingPageState extends State<BreathingPage>
{
  @override
  Widget build(BuildContext context) {
    return CountdownTimer();
  }
   
}