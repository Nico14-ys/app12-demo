import 'package:app_12/utils/methods.dart';
import 'package:flutter/material.dart';

/// StartButten widget is used to start a session for the given topic.
class StartButton extends StatelessWidget {
  const StartButton({super.key, required this.topic});

  final String topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: ShapeDecoration(shape: StadiumBorder(), shadows: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3), spreadRadius: 5, blurRadius: 7)
      ]),
      child: ElevatedButton(
        child: Text("Start!"),
        style: ButtonStyle(),
        onPressed: () {
          // Calling the `loadSession` to start flashcard,
          // passing the current context and the topic.
          loadSession(context: context, topic: topic);
        },
      ),
    );
  }
}
