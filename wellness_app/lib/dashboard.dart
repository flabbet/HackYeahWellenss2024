import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:wellness_app/breathing_excercise.dart';
import 'package:wellness_app/form_pages.dart';

class Dashboard extends StatefulWidget {
  final OnBoardingFormData formData;
  Dashboard(this.formData);

  @override
  State<StatefulWidget> createState() => DashboardState(formData);
}

class DashboardState extends State<Dashboard> {
  static int activeEmotion = 1;
  final OnBoardingFormData formData;

  final breathingAction = EmotionAction("Breathing exercise", (c) => BreathingPage());
  
  DashboardState(this.formData);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const Text("Today's mood"),
                  Text("${MoodPickerState.emotions[activeEmotion - 1]}", style: TextStyle(fontSize: 40, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                  FilledButton(onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MoodPicker(formData)))
                  }, 
                  child: 
                  const Row(
                    children: [
                      Text("My mood has changed"),
                      Icon(Icons.arrow_right_alt)
                    ],
                  ), 
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surfaceContainerHigh),
                    foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onSurfaceVariant)))
                ],),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: RiveAnimation.asset("assets/Mubu_Mood.riv", stateMachines: ["States"], onInit: _onRiveInit))
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text.rich(TextSpan(
                  children: [
                    TextSpan(text: "Here's what you can do when "),
                    TextSpan(text: "${MoodPickerState.emotions[activeEmotion - 1]}", style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
              Column(
                children: 
              List.generate(1, (index) {
                return FilledButton(child: Text(breathingAction.actionName), onPressed: ()=> {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: 
                    breathingAction.widgetToPush))
                });
              })
              ),
              ]
            ),
          )
        ],
      ),
      )));
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, "States");
    artboard.addController(controller!);

    (controller.inputs.first as SMINumber).value = activeEmotion.toDouble();
  }
}

class MoodPicker extends StatefulWidget {
  final OnBoardingFormData formData;

  const MoodPicker(this.formData);

  @override
  State<StatefulWidget> createState() => MoodPickerState(formData);
}

class MoodPickerState extends State<MoodPicker> {
  int? _value;
  final OnBoardingFormData formData;

  SMINumber? _emotion;

  static const emotions = ["Happy", "Sad", "Angry", "Calm", "Anxious", "Scared"];
  MoodPickerState(this.formData){
    _value = DashboardState.activeEmotion - 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, bottom: 70),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hi, ${formData.name}",
                  style: TextStyle(fontSize: 40), textAlign: TextAlign.center),
              SizedBox(
                width: 500,
                height: 380,
                child: RiveAnimation.asset(
                  "assets/Mubu_Mood.riv",
                  stateMachines: ["States"],
                  onInit: _onRiveInit,
                ),
              ),
              const Text("What's your mood today?",
                  style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 20.0,
                children: List<Widget>.generate(
                  6,
                  (int index) {
                    return SizedBox(
                      width: 100,
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        showCheckmark: false,
                        label: SizedBox(
                            width: 100,
                            child: Text(emotions[index],
                                textAlign: TextAlign.center)),
                        selected: _value == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : 0;
                            DashboardState.activeEmotion = (_value! + 1);
                            _emotion!.value =
                                DashboardState.activeEmotion.toDouble();
                          });
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 20),
              FilledButton(
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard(formData)))
                  },
                  child: Text("Save", style: TextStyle(fontSize: 20)))
            ],
          ),
        ),
      ),
    ));
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, "States");
    artboard.addController(controller!);

    _emotion = controller.inputs.first as SMINumber;
    _emotion!.value = (_value! + 1).toDouble();
  }
}

class EmotionAction
{
  String actionName;
  Widget Function(BuildContext) widgetToPush;

  EmotionAction(this.actionName, this.widgetToPush); 
}