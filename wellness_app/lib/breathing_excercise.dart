import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:wellness_app/dashboard.dart';
import 'package:wellness_app/timer.dart';

class BreathingPage extends StatefulWidget{
  final int time;
  final String title;
  BreathingPage(this.time, this.title);

  @override
  State<StatefulWidget> createState() => BreathingPageState(); 
}

class BreathingPageState extends State<BreathingPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(widget.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
            ),
            SizedBox(
              width: 300,
              height: 400,
              child: RiveAnimation.asset("assets/Mubu_Mood.riv", stateMachines: ["States"], onInit: _onRiveInit,)),
            CountdownTimer(widget.time, onFinished: () => gk.currentState!.setState(() {
              DashboardState.activeEmotion = 4;
            })),
          ],
        ),
      ));
  }
   

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, "States");
    artboard.addController(controller!);

    var emotion = controller.inputs.first as SMINumber;
    emotion.value = (DashboardState.activeEmotion).toDouble();
  }
}