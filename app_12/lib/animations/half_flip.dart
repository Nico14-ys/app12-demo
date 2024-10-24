import 'dart:math'; // for pi value
import 'package:flutter/material.dart';

/// HalfFlip widget applied a 180-degree horizontal flip animation to a child widget.
class HalfFlip extends StatefulWidget {
  const HalfFlip(
      {required this.child,
      required this.animate, // Controls whether the animation should be triggered.
      required this.reset, // Determines if the animation should be reset.
      required this.flipFromHalfWay, // Decides if the flip should start from halfway (90 degrees).
      required this.animationCompleted, // Callback when the animation completes.
      super.key});

  final Widget child;
  final bool animate;
  final bool reset;
  final bool flipFromHalfWay;
  final VoidCallback animationCompleted;

  @override
  State<HalfFlip> createState() => _HalfFlipState();
}

class _HalfFlipState extends State<HalfFlip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    // Initializing the AnimationController.
    // Listener to check if the animation has completed, and then trigger callback.
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..addListener(() {
        if (_animationController.isCompleted) {
          widget.animationCompleted.call();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    // Disposes the controller to free resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HalfFlip oldWidget) {
    // Reset the animation if the reset flag is true.
    if (widget.reset) {
      _animationController.reset();
    }

    // Start the animation if the animate flag is true.
    if (widget.animate) {
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double rotationAdjustment = 0;
    if (widget.flipFromHalfWay) {
      // If flipFromHalfWay is true, adjust the rotation by 90 degrees. (for card 2)
      rotationAdjustment = pi / 2;
    }

    return AnimatedBuilder(
      animation: _animationController,
      // Apply flip animation by rotating along the Y-axis.
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY((_animationController.value * pi) / 2)
          ..rotateY(rotationAdjustment), // Rotation for card 2.
        child: widget.child,
      ),
    );
  }
}
