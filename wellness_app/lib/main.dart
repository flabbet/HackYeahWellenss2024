import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          surfaceContainerHigh: Color.fromARGB(255, 45, 44, 44),
          onSurfaceVariant: Color.fromARGB(255, 156, 156, 156), 
          primary: Color.fromARGB(255, 241, 183, 76),
          surfaceContainerLowest: Color.fromARGB(255, 32, 32, 32),
          onSurface: Color.fromARGB(255, 255, 255, 255),
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
  var pages =  [ FirstPage(),SecondPage(), FourthPage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('called');
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: PageView(
                  children: pages,
                  onPageChanged: (i){
                    setState(() {
                      currentIndex = i;
                    });
                  },
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