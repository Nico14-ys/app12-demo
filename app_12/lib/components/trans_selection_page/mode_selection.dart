import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ModeSelection widget is used to display each mode.
class ModeSelection extends StatefulWidget {
  const ModeSelection(
      {super.key,
      required this.mode, // Mode name to display.
      required this.description,
      required this.height,
      required this.width});

  final String mode;
  final String description;
  final double height;
  final double width;

  @override
  State<ModeSelection> createState() => _ModeSelectionState();
}

class _ModeSelectionState extends State<ModeSelection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
        builder: (_, notifier, __) => GestureDetector(
              onTap: () =>
                  notifier.setMode(widget.mode), // Update the mode when tapped.
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(13),
                      // Highlight the box with a blue border if the current mode is selected.
                      border: notifier.mode[widget.mode]!
                          ? Border.all(color: Colors.blueAccent, width: 3)
                          : Border.all(color: Colors.transparent, width: 3),
                    ),
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.8,
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mode,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text(widget.description,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 13))
                          ],
                        )),
                      ),
                    )),
              ),
            ));
  }
}
