import 'package:app_12/components/general/guide_box.dart';
import 'package:flutter/material.dart';
import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:app_12/pages/flashcards_page.dart';
import 'package:provider/provider.dart';

// Function to load a flashcards session based on the selected topic.
loadSession({required BuildContext context, required String topic}) {
  Provider.of<FlashcardsNotifier>(context, listen: false)
      .setTopic(topic: topic);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const FlashcardsPage()));
}

// Function to show the guide box dialog.
runGuideBox({required BuildContext context}) {
  showDialog(context: context, builder: (context) => GuideBox());
}
