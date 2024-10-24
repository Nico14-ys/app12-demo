import 'package:app_12/pages/trans_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:app_12/animations/fade_in.dart';

// RevisionTile is the box widget for each revision mode.
class RevisionTile extends StatelessWidget {
  const RevisionTile({super.key, required this.topic});

  final String topic;

  @override
  Widget build(BuildContext context) {
    // Using FadeIn animation for the widget.
    return FadeIn(
        child: GestureDetector(
      // Navigates to the TransSelectionPage when tapped.
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TransSelectionPage()));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: 20,
            top: MediaQuery.of(context).size.height * 0.3,
            bottom: 20),
        width: MediaQuery.of(context).size.height * 0.6 * 0.6,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(topic),
      ),
    ));
  }
}
