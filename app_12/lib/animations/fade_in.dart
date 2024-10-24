import 'package:flutter/material.dart';

/// FadeIn widget applies a fade-in effect with both scaling and opacity animations to a child widget.

class FadeIn extends StatefulWidget {
  const FadeIn({required this.child, super.key});

  final Widget child;

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation, _opacityAnimation;

  @override
  initState() {
    // Initializing the AnimationController.
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    super.initState();

    // Tween for scale animation
    // CurvedAnimation applies an easing function to smooth the animation.
    _scaleAnimation = Tween<double>(begin: 0.90, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutSine));

    // Tween for opacity animation
    _opacityAnimation = Tween<double>(begin: 0.50, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutSine));

    // Starts the animation.
    _animationController.forward();
  }

  @override
  dispose() {
    // Disposes the controller to free resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Opacity(
        opacity: _opacityAnimation.value,
        child: Transform(
          transform: Matrix4.identity()..scale(_scaleAnimation.value),
          child: widget.child,
        ),
      ),
    );
  }
}
