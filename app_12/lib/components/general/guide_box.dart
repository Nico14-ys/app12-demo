import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// GuideBox is an alert dialog that provides guides for using different revision mode, like gestures.
// May be abstracted and reused
class GuideBox extends StatefulWidget {
  const GuideBox({super.key});

  @override
  State<GuideBox> createState() => _GuideBoxState();
}

class _GuideBoxState extends State<GuideBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.1),
        actions: [
          Theme(
            data:
                Theme.of(context).copyWith(highlightColor: Colors.transparent),
            child: CheckboxListTile(
                // Text asking the user if they want to show the gesture guide every time.
                title: Text(
                  "Always show gesture guidance.",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: MediaQuery.sizeOf(context).width * 0.025),
                ),
                // The current value of the checkbox is controlled by notifier's currentPref,
                // which is saved in shared preference.
                value: notifier.currentPref,
                // When checkbox is clicked, it triggers the notifier to update the preference.
                onChanged: (bool? value) {
                  Provider.of<FlashcardsNotifier>(context, listen: false)
                      .setShowGuideDialog(value!);
                },
                controlAffinity: ListTileControlAffinity.leading),
          )
        ],
      ),
    );
  }
}
