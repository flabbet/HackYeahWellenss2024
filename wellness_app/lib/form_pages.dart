import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:wellness_app/custom_input_field.dart';
import 'package:wellness_app/dashboard.dart';
import 'package:wellness_app/homepage.dart';
import 'package:flutter/src/widgets/image.dart' as flutter_img;

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
              child: SizedBox(
                width: 300,
                height: 150,
                child: RiveAnimation.asset("assets/Logo.riv"))),
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

class PickOneFormPage extends StatefulWidget
{
  final String title;
  final PageController pageController;
  final List<TileData>? tiles;
  const PickOneFormPage({super.key, this.title = "", this.tiles = null, required this.pageController});
  
  @override
  State<StatefulWidget> createState() => PickOneFormPageState();

  
}

class PickOneFormPageState extends State<PickOneFormPage> {
  static var controller = TextEditingController();
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Text(widget.title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          Center(
            child: SizedBox(
              height: 500,
              child: GridView.count(
                  crossAxisCount: 2, // Determines the number of columns,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(widget.tiles?.length ?? 0, (index) {
                    return GridTile(
                      child: GestureDetector(
                        onTap: () => {
                          setState(() {
                            selected = index;
                          })
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: 
                                selected != index ? Colors.transparent : Theme.of(context).colorScheme.primary),
                            color: Theme.of(context).colorScheme.surfaceContainerHigh
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.tiles![index].image != null ? flutter_img.Image.asset(widget.tiles![index].image!, width: 96, height: 96,) : Container(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(widget.tiles![index].title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14), textAlign: TextAlign.center),
                              ),
                            ],
                          ),
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
                    widget.pageController.jumpToPage(widget.pageController.page!.toInt() + 1)
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

class TileData
{
  String title;
  String? image;

  TileData(this.title, this.image);
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
              child: SizedBox(
                width: 300,
                height: 150,
                child: RiveAnimation.asset("assets/Logo.riv"))),
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