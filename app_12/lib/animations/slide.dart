import 'package:app_12/configs/constants.dart';
import 'package:app_12/enum/slide_direction.dart';
import 'package:flutter/material.dart';

/// Slide widget applies a sliding animation in given directions to its child widget.
class Slide extends StatefulWidget {
  const Slide(
      {required this.child,
      required this.direction, // The direction the widget will slide.
      this.animate = true, // Determines if the animation should be triggered.
      this.reset, // Determines if the animation should be reset.
      this.animationCompleted, // Optional callback when the animation completes.
      super.key});

  final Widget child;
  final SlideDirection direction;
  final bool animate;
  final bool? reset;
  final VoidCallback? animationCompleted;

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    // Initializing the AnimationController.
    // Listener to check if the animation has completed, and then trigger callback.
    _animationController = AnimationController(
        duration: const Duration(milliseconds: aSlideAwayDuration), vsync: this)
      ..addListener(() {
        if (_animationController.isCompleted) {
          widget.animationCompleted?.call();
        }
      });

    // Start the animation if the animate flag is true.
    if (widget.animate) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  didUpdateWidget(covariant oldWidget) {
    // Reset the animation if the reset flag is true.
    if (widget.reset == true) {
      _animationController.reset();
    }
    // Trigger the animation if the animate flag is true.
    if (widget.animate) {
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // Disposes the controller to free resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final Animation<Offset> animation;
    Tween<Offset> tween;

    // Define the tween based on the slide direction.
    switch (widget.direction) {
      case SlideDirection.leftAway:
        tween =
            Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0));
        break;

      case SlideDirection.rightAway:
        tween =
            Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0));
        break;

      case SlideDirection.leftIn:
        tween =
            Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;

      case SlideDirection.rightIn:
        tween =
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;

      case SlideDirection.upIn:
        tween =
            Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;

      case SlideDirection.none:
        tween =
            Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0));
        break;
    }

    // Use a curved animation for smooth transitions.
    animation = tween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Apple animation.
    return SlideTransition(
      position: animation,
      child: widget.child,
    );
  }
}
