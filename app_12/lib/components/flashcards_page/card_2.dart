import 'dart:math'; // for pi value
import 'package:app_12/animations/half_flip.dart'; // for half flip animation.
import 'package:app_12/animations/slide.dart'; // for slide animation.
import 'package:app_12/enum/slide_direction.dart'; // for defining slide directions.
import 'package:app_12/notifier/flashcards_notifier.dart'; // for managing flashcard state.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Card 2 is back side of flashcard, it performs the flip animation and shows the answer.
class Card2 extends StatelessWidget {
  const Card2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => GestureDetector(
        // Detect horizontal drag gestures to swipe the card.
        onHorizontalDragEnd: (details) {
          // Swiped right, note that card 2 is flipped.
          if (details.primaryVelocity! > 20) {
            notifier.runSwipeCard2(
                direction: SlideDirection.leftAway); // Slide away current card.
            notifier.runSlideCard1(); // Slide in next card.
            notifier.setIgnoreTouch(
                ignore:
                    true); // Disable touch interaction during the transition.
            notifier.generateCurrentTran(
                context: context,
                direction: SlideDirection
                    .rightAway); // Generate new translation and pass into the notifier the direction to cound the correctness.
          }
          // Swiped left, note that card 2 is flipped.
          if (details.primaryVelocity! < -20) {
            notifier.runSwipeCard2(direction: SlideDirection.rightAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentTran(
                context: context, direction: SlideDirection.leftAway);
          }
        },
        child: HalfFlip(
          animate: notifier.flipCard2,
          reset: notifier.resetFlipCard2,
          flipFromHalfWay:
              true, // Start the flip from halfway point as back side.
          animationCompleted: () {
            // Enable touch interaction again after the animation completes.
            notifier.setIgnoreTouch(ignore: false);
          },
          child: Slide(
            animationCompleted: () {
              // Reset card 2 to prepare for next card.
              notifier.resetCard2();
            },
            reset: notifier.resetSwipeCard2,
            animate: notifier.swipeCard2,
            direction: notifier.swipedDirection,
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
                  child: Transform(
                      transform: Matrix4.rotationY(
                          pi), // Display words in right orientation as card 2 is flipped.
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Original sentence.
                            Center(
                                child: RichText(
                                    text: TextSpan(
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w100,
                                  height: 1.1),
                              children: <TextSpan>[
                                TextSpan(
                                    text: notifier.tran2.sentence.substring(
                                        0, notifier.tran2.original[0])),
                                TextSpan(
                                    text: notifier.tran2.sentence.substring(
                                        notifier.tran2.original[0],
                                        notifier.tran2.original[1]),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                    )),
                                TextSpan(
                                    text: notifier.tran2.sentence
                                        .substring(notifier.tran2.original[1])),
                              ],
                            ))),
                            // Translation answer in a concave style using shadow.
                            Center(
                              child: FittedBox(
                                child: Text(
                                    notifier.tran2.translations.join(" / "),
                                    style: TextStyle(
                                      fontSize: 60.0,
                                      height: 1.5,
                                      color: Theme.of(context).cardColor,
                                      shadows: [
                                        Shadow(
                                          color: Theme.of(context).shadowColor,
                                          offset: Offset(-1.5, -1.5),
                                          blurRadius: 0,
                                        ),
                                        Shadow(
                                          color: Theme.of(context).shadowColor,
                                          offset: Offset(-1.5, 0),
                                          blurRadius: 0,
                                        ),
                                        Shadow(
                                          color: Theme.of(context).shadowColor,
                                          offset: Offset(0, -1.5),
                                          blurRadius: 0,
                                        ),
                                        Shadow(
                                          color:
                                              Theme.of(context).highlightColor,
                                          offset: Offset(1.5, 0),
                                          blurRadius: 0,
                                        ),
                                        Shadow(
                                          color:
                                              Theme.of(context).highlightColor,
                                          offset: Offset(0, 1.5),
                                          blurRadius: 0,
                                        ),
                                        Shadow(
                                          color:
                                              Theme.of(context).highlightColor,
                                          offset: Offset(1.5, 1.5),
                                          blurRadius: 0,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            // Title of essay it belongs to.
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '《${notifier.topic}》',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ))
                          ]))),
            ),
          ),
        ),
      ),
    );
  }
}
