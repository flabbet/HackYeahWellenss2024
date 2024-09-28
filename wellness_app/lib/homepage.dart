import 'package:flutter/material.dart';
import 'package:wellness_app/form_pages.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Final Screen'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('first page data: ${data['first']}'),
            Text('second page data: ${data['second']}'),
            Text('fourth page data: ${data['fourth']}'),
          ],
        ),
      ),
    );
  }
}
