import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 213, 213, 213),
        body: Center(
            child: Column(
          children: [
            Padding(padding: EdgeInsets.all(25.0)),
            SizedBox(height: 48),
            Text('12',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ))
          ],
        )));
  }
}
