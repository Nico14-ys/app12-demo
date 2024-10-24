import 'package:flutter/material.dart';

/// MenuWidget is a custom menu widget.
// It is combined with Button Widget in CustomDropDown to form a complete drop down widget.
class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    this.width,
    this.height,
    required this.child,
  });

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.all(13.0),
        child: child,
        width: width ?? 200,
        height: height ?? 150,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
            shadows: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7)
            ]),
      ),
    );
  }
}
