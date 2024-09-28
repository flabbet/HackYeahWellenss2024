import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness_app/custom_input_field.dart';
import 'package:wellness_app/dashboard.dart';
import 'package:wellness_app/homepage.dart';

class FirstPage extends StatelessWidget {
  static var controller = TextEditingController();
  final PageController pageController;
  
  const FirstPage(this.pageController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/Logo.svg")),
          const Text.rich(
              textAlign: TextAlign.center,
              const TextSpan(children: [
                TextSpan(
                    text: "Mubu",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        " will help you track your mood and feel better every day!",
                    style: TextStyle(fontSize: 24))
              ])),
          const Text.rich(
              textAlign: TextAlign.center,
              const TextSpan(children: [
                TextSpan(
                    text: "To start,\n",
                    style: TextStyle(
                      fontSize: 24,
                    )),
                TextSpan(
                    text: "enter your name ",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextSpan(text: "below:", style: TextStyle(fontSize: 24))
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomInputField(controller: controller, onSubmit: () => {
              pageController.jumpToPage(pageController.page!.toInt() + 1),
              FocusManager.instance.primaryFocus?.unfocus()
            })],
          )
        ],
      ),
    );
  }
}

class PickOneFormPage extends StatelessWidget {
  static var controller = TextEditingController();
  final String title;
  final PageController pageController;
  const PickOneFormPage({super.key, this.title = "", required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Text(title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          Center(
            child: SizedBox(
              height: 500,
              child: GridView.count(
                  crossAxisCount: 2, // Determines the number of columns,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(6, (index) {
                    return GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              Theme.of(context).colorScheme.surfaceContainerHigh,
                        ),
                        child: Center(
                          child: Text('Tile $index'),
                        ),
                      ),
                    );
                  })),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
                onPressed: () => {},
                child: Text(
                  "SKIP",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                )),
            Container(
              width: 170,
              height: 50,
              child: FilledButton(
                  onPressed: () => {
                    pageController.jumpToPage(pageController.page!.toInt() + 1)
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Next", style: TextStyle(fontSize: 20)),
                        Icon(Icons.arrow_right_alt_rounded, size: 30)
                      ])),
            )
          ]),
        ]));
  }
}

class SummaryPage extends StatelessWidget {
  static var controller = TextEditingController();
  final Function() onStartClicked;
  const SummaryPage({super.key, required this.onStartClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/Logo.svg")),
          const Text("You're all set!", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),
          const Text("Lets's get started on your first mood check-in", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24)),
          FilledButton(onPressed: () => {
            onStartClicked()
          }, child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text("Start Now!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          ))
        ],
      ),
    );
  }
}

class OnBoardingFormData
{
  String name;

  OnBoardingFormData({required this.name});
}