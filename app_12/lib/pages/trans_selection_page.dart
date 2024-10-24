import 'package:app_12/components/flashcards_page/return_button.dart';
import 'package:app_12/components/topic_list.dart';
import 'package:app_12/components/trans_selection_page/custom_drop_down.dart';
import 'package:app_12/components/trans_selection_page/start_button.dart';
import 'package:app_12/data/trans.dart';
import 'package:app_12/notifier/topic_selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Page of topic list to allow user to select a topic and start a revision session.
class TransSelectionPage extends StatefulWidget {
  const TransSelectionPage({super.key});

  @override
  State<TransSelectionPage> createState() => _TransSelectionPageState();
}

class _TransSelectionPageState extends State<TransSelectionPage> {
  // List of unique topics.
  final List<String> _topics = [];
  @override
  void initState() {
    // Ensure widget is fully built.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    // Populate topics list by iterating over questions.
    for (var t in trans) {
      // If the topic is not included yet.
      if (!_topics.contains(t.topic)) {
        _topics.add(t.topic);
      }
    }
    _topics.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<TopicSelectionNotifier>(
      builder: (_, notifier, __) => Scaffold(
        backgroundColor: Theme.of(context).hintColor,
        body: Stack(
          children: [
            // Taps on topic list is disabled when the menu is open.
            AbsorbPointer(
              absorbing: notifier.menuOpened,
              // Lists of topics.
              child: TopicList(size: size, topics: _topics),
            ),

            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Dropdown for mode selection.
                      const CustomDropDown(),
                      const Spacer(),

                      // Button to start session.
                      Consumer<TopicSelectionNotifier>(
                        builder: (_, notifier, __) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: StartButton(
                            topic: notifier.topic,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

            // Button to return to previous page.
            ReturnButton()
          ],
        ),
      ),
    );
  }
}
