import 'package:app_12/components/flashcards_page/card_1.dart';
import 'package:app_12/components/flashcards_page/card_2.dart';
import 'package:app_12/components/flashcards_page/progress_bar.dart';
import 'package:app_12/components/flashcards_page/return_button.dart';
import 'package:app_12/enum/slide_direction.dart';
import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:app_12/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Flashcards page to gather element and display flashcards.
class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  @override
  void initState() {
    // Ensure it finished build before proceeding.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final flashcardsNNotifier =
          Provider.of<FlashcardsNotifier>(context, listen: false);
      // Generate flashcards data based on the selected topic.
      flashcardsNNotifier.generateAllSelectedTrans();
      // Load the first question,
      // SlideDirection here is just a placeholder, will be ignored as it is first card.
      flashcardsNNotifier.generateCurrentTran(
          context: context, direction: SlideDirection.rightAway);

      // Initialize the first card sliding animation.
      flashcardsNNotifier.runSlideCard1();

      // Display the guide box if the user has enabled it.
      if (flashcardsNNotifier.currentPref) {
        runGuideBox(context: context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
        builder: (_, notifier, __) => Scaffold(
                body: IgnorePointer(
              // Ignore touches during animation.
              ignoring: notifier.ignoreTouches,
              // Container for making gradient background.
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark
                ])),
                child: const Stack(
                  children: [
                    ReturnButton(),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ProgressBar()),
                    Card2(),
                    Card1(),
                  ],
                ),
              ),
            )));
  }
}
