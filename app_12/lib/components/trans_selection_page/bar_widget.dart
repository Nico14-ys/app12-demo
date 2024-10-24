import 'package:flutter/material.dart';

/// ButtonWidget is a custom selection bar.
// It is combined with MenuWidget in CustomDropDown to form a complete drop down widget.
class BarWidget extends StatelessWidget {
  const BarWidget({
    super.key,
    this.height = 48,
    this.width,
    this.onTap, // Callback function to be triggered on tap.
    this.child,
  });

  final double? height;
  final double? width;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(shape: StadiumBorder(), shadows: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3), spreadRadius: 5, blurRadius: 7)
      ]),
      child: SizedBox(
        height: height,
        width: width,
        child: Material(
          color: Colors.white,
          shape: StadiumBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: StadiumBorder(),
            child: Center(
              child: child ?? const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
