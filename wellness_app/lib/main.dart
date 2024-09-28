import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:wellness_app/dashboard.dart';
import 'package:wellness_app/form_pages.dart';
import 'package:wellness_app/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mubu',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          surfaceContainerHigh: Color.fromARGB(255, 45, 44, 44),
          onSurfaceVariant: Color.fromARGB(255, 156, 156, 156), 
          primary: Color.fromARGB(255, 241, 183, 76),
          surfaceContainerLowest: Color.fromARGB(255, 32, 32, 32),
          onSurface: Color.fromARGB(255, 255, 255, 255),
          secondary: Color.fromARGB(255, 241, 183, 76),
          ),
          fontFamily: "Outfit",
        useMaterial3: true,
      ),
      home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  List<Widget> pages = [];

  _HomeScreenState()
  {
    pages.add(FirstPage(pageController));
    pages.add(PickOneFormPage(title: "Choose your favorite  activity", pageController: pageController));
    pages.add(PickOneFormPage(title: "What’s your go-to stress reliever?", pageController: pageController,));
    pages.add(PickOneFormPage(title: "What’s your main goal?", pageController: pageController,));
    pages.add(SummaryPage(onStartClicked: () => {

    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => MoodPicker(OnBoardingFormData(name: FirstPage.controller.text)),
    ),
  )
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: PageView(
                  pageSnapping: true,
                  controller: pageController, 
                  physics: NeverScrollableScrollPhysics(), 
                  children: pages,
                  padEnds: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}