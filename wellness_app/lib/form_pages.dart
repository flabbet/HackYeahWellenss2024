import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness_app/custom_input_field.dart';
import 'package:wellness_app/homepage.dart';

class FirstPage extends StatelessWidget {
  static var controller = TextEditingController();
  const FirstPage({super.key});

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
                text: "Mood Buddy",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    " will help you track your mood and feel better every day!",
                style: TextStyle(fontSize: 24))
          ])),
          const Text.rich(textAlign: TextAlign.center,
              const TextSpan(children: [
            TextSpan(text: "To start,\n", style: TextStyle(fontSize: 24,)),
            TextSpan(text: "enter your name ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextSpan(text: "below:", style: TextStyle(fontSize: 24))
          ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomInputField()],
          )
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  static var controller = TextEditingController();
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Second Page'),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              label: Text('phone'),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 1, color: Colors.blue))),
        ),
      ],
    );
  }
}

class FourthPage extends StatelessWidget {
  static var controller = TextEditingController();
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Fourth Page'),
        ),
        TextFormField(
          controller: controller,
          onFieldSubmitted: (s) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FinalScreen(),
                settings: RouteSettings(
                  arguments: {
                    'first': FirstPage.controller.text,
                    'second': SecondPage.controller.text,
                    'fourth': FourthPage.controller.text
                  },
                )));
          },
          decoration: InputDecoration(
              label: Text('Password'),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 1, color: Colors.blue))),
        ),
      ],
    );
  }
}
