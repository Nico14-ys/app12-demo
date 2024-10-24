import 'package:app_12/animations/half_flip.dart'; // for half flip animation.
import 'package:app_12/animations/slide.dart'; // for slide animation.
import 'package:app_12/enum/slide_direction.dart'; // for defining slide directions.
import 'package:app_12/notifier/flashcards_notifier.dart'; // for managing flashcard state.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Card 1 is the front side of flashcard, it shows the question and will flip when double clicked.
class Card1 extends StatelessWidget {
  const Card1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      // Listen to changes in the FlashcardsNotifier.
      builder: (_, notifier, __) => GestureDetector(
        onDoubleTap: () {
          // On double tap, run the flip animation for card 1 and disable touch interaction.
          notifier.runFlipCard1();
          notifier.setIgnoreTouch(ignore: true);
        },
        child: HalfFlip(
          animate: notifier.flipCard1,
          reset: notifier.resetFlipCard1,
          flipFromHalfWay: false, // Start the flip from the beginning.
          // Once card 1 has flipped to a perpendicular position,
          // reset card 1 for next card to slide in and start to flip card 2.
          animationCompleted: () {
            notifier.resetCard1();
            notifier.runFlipCard2();
          },
          child: Slide(
            animationCompleted: () {
              // Enable touch interaction again after the animation completes.
              notifier.setIgnoreTouch(ignore: false);
            },
            reset: notifier.resetSlideCard1,
            animate: notifier.slideCard1 && !notifier.isRoundCompleted,
            direction: SlideDirection.upIn,
            child: Center(
              child: Container(
                // Responsive size.
                width: size.width * 0.85,
                height: size.width * 0.85 * 0.6,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Question.
                      Text('試解釋以下文句中的粗體字。\n',
                          style: TextStyle(
                              fontSize: size.width * 0.025,
                              color: Theme.of(context).primaryColor)),
                      // Original sentence.
                      RichText(
                          text: TextSpan(
                        style: TextStyle(
                            fontSize: size.width * 0.1,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w100,
                            height: 1.1),
                        children: <TextSpan>[
                          TextSpan(
                              text: notifier.tran1.sentence
                                  .substring(0, notifier.tran1.original[0])),
                          TextSpan(
                              text: notifier.tran1.sentence.substring(
                                  notifier.tran1.original[0],
                                  notifier.tran1.original[1]),
                              style: const TextStyle(
                                fontWeight: FontWeight
                                    .w900, // Bold text for translation part.
                              )),
                          TextSpan(
                              text: notifier.tran1.sentence
                                  .substring(notifier.tran1.original[1])),
                        ],
                      )),
                      // Title of essay it belongs to.
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '《${notifier.topic}》',
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: Theme.of(context).primaryColor,
                            ),
                          ))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
