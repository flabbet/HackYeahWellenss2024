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

  final breathingAction = EmotionAction("Breathing exercise", 5, (c) => BreathingPage(60 * 5, "Slowly take a deep breaths"));
  final meditateAction = EmotionAction("Meditate", 15, (c) => BreathingPage(5, "Lay down, close your eyes and clear your mind"));
  final journalAction = EmotionAction("Journal", 10, (c) => BreathingPage(60 * 10, "Write down the most recent event in your life"));
  final napAction = EmotionAction("Short nap", 20, (c) => BreathingPage(20 * 60, "Zzzzzz..."));
  final sprintAction = EmotionAction("Sprint as fast as you can", 5, (c) => BreathingPage(5 * 60, "Sprint!"));
  final nameAction = EmotionAction("5-4-3-2-1 Coping Technique", 5, (c) => BreathingPage(5 * 60, "Identify 5 things you can see, 4 things you can touch, 3 things you can hear, 2 things you can smell, and 1 thing you can taste"));
  final takeAwalk = EmotionAction("Take a walk", 30, (c) => BreathingPage(30 * 60, "Take a slow mindful walk"));

  final happyActions = [];
  final sadActions = [];
  final angryActions = [];
  final calmActions = [];
  final anxiousActions = [];
  final scaredActions = [];

  final List<List<dynamic>> activeEmotionActions = [];
  
  DashboardState(this.formData){
    sadActions.add(breathingAction);
    anxiousActions.add(meditateAction);
    anxiousActions.add(takeAwalk);
    happyActions.add(journalAction);
    angryActions.add(sprintAction);
    scaredActions.add(nameAction);
    calmActions.add(journalAction);
    sadActions.add(napAction);

    activeEmotionActions.add(happyActions);
    activeEmotionActions.add(sadActions);
    activeEmotionActions.add(angryActions);
    activeEmotionActions.add(calmActions);
    activeEmotionActions.add(anxiousActions);
    activeEmotionActions.add(scaredActions);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
      padding: EdgeInsets.all(20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Container(
              child: Column(
                children: [
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(text: "Here's what you can do when "),
                      TextSpan(text: "${MoodPickerState.emotions[activeEmotion - 1]}", style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
                    SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: 
                List.generate(activeEmotionActions[activeEmotion - 1].length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      height: 61,
                      decoration:
                      BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${activeEmotionActions[activeEmotion - 1][index].actionName}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                Text("${activeEmotionActions[activeEmotion - 1][index].time} minutes", style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant))
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.play_circle_fill_outlined, 
                              color: Theme.of(context).colorScheme.onSurface, size: 26),
                               onPressed: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: activeEmotionActions[activeEmotion - 1][index].widgetToPush)
                                )
                            }),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                ),
                ]
              ),
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
  int time;
  Widget Function(BuildContext) widgetToPush;

  EmotionAction(this.actionName, this.time, this.widgetToPush); 
}