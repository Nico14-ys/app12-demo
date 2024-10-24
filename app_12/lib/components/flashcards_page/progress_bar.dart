import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ProgressBar displays a progress indicator based on the question completion percentage.
class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double beginValue = 0.0, endValue = 0.0;

  @override
  void initState() {
    // Initialize the animation controller.
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FlashcardsNotifier, double>(
        // Select the percentageComplete from FlashcardsNotifier.
        selector: (_, notifier) => notifier.percentageComplete,
        builder: (_, percentageComplete, __) {
          endValue = percentageComplete;
          // Create a tween animation from the beginValue to the endValue.
          var animation = Tween<double>(begin: beginValue, end: endValue)
              .animate(CurvedAnimation(
                  parent: _controller, curve: Curves.easeInOutCirc));

          _controller.reset();
          _controller.forward();
          beginValue =
              endValue; // Set the beginValue to the current endValue for the next animation cycle.

          return SafeArea(
              child: AnimatedBuilder(
            animation: _controller, // Listen to changes in the animation.
            builder: (context, child) => Padding(
              padding: const EdgeInsets.all(13),
              child: LinearProgressIndicator(
                minHeight: MediaQuery.of(context).size.height * 0.003,
                value: animation
                    .value, // Set the current value of the progress indicator.
              ),
            ),
          ));
        });
  }
}
