import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';

/// ReturnButton is a button for navigating back to the previous screen.
class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(0),
      child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: IconShadow(
            const Icon(
              Iconsax.arrow_left_2_copy,
              color: Colors.white,
            ),
            shadowBlurSigma: 0.3,
            shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
          )),
    ));
  }
}
