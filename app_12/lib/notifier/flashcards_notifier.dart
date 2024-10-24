import 'dart:math';
import 'package:app_12/components/flashcards_page/result_box.dart';
import 'package:app_12/configs/constants.dart';
import 'package:app_12/enum/slide_direction.dart';
import 'package:flutter/material.dart';
import 'package:app_12/structure/tran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_12/data/trans.dart';

/// Notifier class to manage the state and behavior of flashcards.
class FlashcardsNotifier extends ChangeNotifier {
  /* OPERATION CODE. */
  /// The current topic for the flashcards.
  String topic = "";

  /// Set the current topic for flashcards.
  setTopic({required String topic}) {
    this.topic = topic;
    notifyListeners();
  }

  // With two Tran object,
  //users sees a seamless transition between corresponding sides of the objects.

  /// Question to be displayed first (card 1); updates for smooth transition of next question.
  Tran tran1 =
      Tran(topic: " ", sentence: " ", original: [0, 0], translations: [" "]);

  /// A copy of tran1; shows its back side (card 2) when tran1 is updated.
  Tran tran2 =
      Tran(topic: " ", sentence: " ", original: [0, 0], translations: [" "]);
  List<Tran> selectedTrans = [];

  /// Tally for correct and incorrect answers, and total cards
  int correctTally = 0, incorrectTally = 0, cardTally = 0;

  // Previous question saved for smart loop.
  late Tran? previous;

  bool isFirstCard = true;
  bool isRoundCompleted = false;

  /// Generate the list of selected translations based on the current topic.
  generateAllSelectedTrans() {
    // Reset variables.
    selectedTrans.clear();
    correctTally = 0;
    incorrectTally = 0;
    isFirstCard = true;
    // Update variables.
    selectedTrans = trans.where((element) => element.topic == topic).toList();
    cardTally = selectedTrans.length;
    resetProgressBar();
  }

  /// Generate the current question to display
  generateCurrentTran(
      {required BuildContext context, required SlideDirection direction}) {
    /// Index of question to display.
    final int r;

    // When there is still questions not displayed.
    if (selectedTrans.isNotEmpty) {
      // If in mode that cards are shuffled.
      if (mode["Random"]! || mode["Smart Loop"]!) {
        r = Random().nextInt(selectedTrans.length);
      } else {
        r = 0;
      }

      // Update tran1.
      tran1 = selectedTrans[r];

      // Note that the slide direction indicates the PREVIOUS card's correctness,
      // and it shouldn't be counted for the first card.

      // Add back the previous card if was incorrect
      if (mode["Smart Loop"]! &&
          direction == SlideDirection.rightAway &&
          !isFirstCard) {
        // Avoid duplication when user has multiple incorrect on same question.
        if (!selectedTrans.contains(previous)) {
          selectedTrans = selectedTrans + [previous!];
        }
        cardTally++; // One extra card will be added for each incorrect.
      }

      // If smart loop, save the previous card.
      if (mode["Smart Loop"]!) {
        previous = selectedTrans[r];
      }

      selectedTrans.removeAt(r);

      // Count the tally with slide direction.
      if (!isFirstCard) {
        if (direction == SlideDirection.rightAway) {
          incorrectTally++;
        } else {
          correctTally++;
        }
      } else {
        // Update once first card is passed.
        isFirstCard = false;
      }
    } else {
      // else of [selectedTrans.isNotEmpty] - Case for last card.
      if (direction == SlideDirection.rightAway) {
        selectedTrans = [previous!] + selectedTrans;
        cardTally++;
        incorrectTally++;
      } else {
        correctTally++;
      }

      if (selectedTrans.isEmpty || correctTally + incorrectTally == cardTally) {
        isRoundCompleted = true;

        // Display dialog for statistics.
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
              context: context,
              builder: (context) => const ResultBox(),
              barrierDismissible:
                  false // Prevents dialog from closing on tap outside
              );
        });
      }
    }

    calculateCompletedPercentage();

    Future.delayed(const Duration(milliseconds: aSlideAwayDuration), () {
      tran2 = tran1;
    });
  }

  /// Reset the state for a new round.
  reset() {
    isFirstCard = true;
    isRoundCompleted = false;
    notifyListeners();
  }

  /* STATISTICS CODE. */
  /// Completion percentage
  double percentageComplete = 0.0;

  /// Calculate and update percentage.
  calculateCompletedPercentage() {
    percentageComplete = (correctTally + incorrectTally) / cardTally;
    notifyListeners();
  }

  /// Reset percentage to zero to update progress bar after a round.
  resetProgressBar() {
    percentageComplete = 0.0;
    notifyListeners();
  }

  /* MODE CODE. */
  /// Mode settings for flashcard display
  Map<String, bool> mode = {
    "Random": false,
    "Sequential": true,
    "Smart Loop": false
  };

  /// Set the mode for displaying flashcards
  setMode(String key) {
    mode.updateAll((name, value) => value = false);
    mode[key] = true;
    notifyListeners();
  }

  /* ANIMATION CODE. */

  SlideDirection swipedDirection = SlideDirection.none;

  bool ignoreTouches = true;

  setIgnoreTouch({required bool ignore}) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  // Flags for whether animations should be ran.
  bool slideCard1 = false,
      flipCard1 = false,
      flipCard2 = false,
      swipeCard2 = false;

  // Flags for whether animation controllers should be reset.
  bool resetSlideCard1 = false,
      resetFlipCard1 = false,
      resetFlipCard2 = false,
      resetSwipeCard2 = false;

  // Listeners rebuild the widget when notified, which the animation will proceed.

  // Set flags to run animation slide card 1.
  runSlideCard1() {
    resetSlideCard1 = false;
    slideCard1 = true;
    notifyListeners();
  }

  // Set flags to run animation flip card 1.
  runFlipCard1() {
    resetFlipCard1 = false;
    flipCard1 = true;
    notifyListeners();
  }

  // Set flags to reset card 1 animation controller.
  resetCard1() {
    resetSlideCard1 = true;
    resetFlipCard1 = true;
    slideCard1 = false;
    flipCard1 = false;
  }

  runFlipCard2() {
    resetFlipCard2 = false;
    flipCard2 = true;
    notifyListeners();
  }

  // Pass in swipe direction to count correctness.
  runSwipeCard2({required SlideDirection direction}) {
    swipedDirection = direction;
    resetSwipeCard2 = false;
    swipeCard2 = true;
    notifyListeners();
  }

  resetCard2() {
    resetFlipCard2 = true;
    resetSwipeCard2 = true;
    flipCard2 = false;
    swipeCard2 = false;
  }

  /* GUIDE BOX CODE */
  static const showGuideDialogKey = 'showGuideDialog';
  final SharedPreferences _prefs;
  bool _currentPref;

  FlashcardsNotifier(this._prefs)
      :
        // load theme from preferences on initialization
        _currentPref = _prefs.getBool(showGuideDialogKey) ?? true;

  /// get the current pref
  bool get currentPref => _currentPref;

  setShowGuideDialog(bool b) {
    print("changed");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _currentPref = b;

      // notify the app that the pref was changed
      notifyListeners();
    });

    // store updated pref on disk
    _prefs.setBool(showGuideDialogKey, b);
  }
}
