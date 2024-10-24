import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:app_12/pages/flashcards_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ResultBox is a dialog that displays the results after a round of flashcards.
class ResultBox extends StatelessWidget {
  const ResultBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.2),
        title: Center(
            widthFactor: 1,
            heightFactor: 2,
            // Calculate and display the percentage of correct answers.
            child: Text(
              "${(notifier.correctTally / notifier.cardTally * 100).toStringAsFixed(1)}%",
              style:
                  TextStyle(fontSize: MediaQuery.sizeOf(context).width * 0.15),
            )),
        actions: [
          // Message indicating the end of the round.
          Center(
            child: Text(
              "Round completed！",
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: MediaQuery.sizeOf(context).width * 0.03,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // Spacing.
          SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.03,
          ),
          // Display the tally for corrent and incorrect cards.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Correct：${notifier.correctTally}',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: MediaQuery.sizeOf(context).width * 0.03),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.07,
              ),
              Text('Incorrect：${notifier.incorrectTally}',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: MediaQuery.sizeOf(context).width * 0.03))
            ],
          ),
          // Spacing.
          SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.04,
          ),
          // Options.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Retrying the round with same setting.
              ElevatedButton(
                  onPressed: () {
                    notifier.reset();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FlashcardsPage()));
                  },
                  child: Text('Try Again',
                      style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).width * 0.03))),
              // Spacing.
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.03,
              ),
              // Going back to selection page
              ElevatedButton(
                  onPressed: () {
                    notifier.reset();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width * 0.03),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
