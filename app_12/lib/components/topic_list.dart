import 'package:app_12/components/topic_tile.dart';
import 'package:app_12/notifier/topic_selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicList extends StatelessWidget {
  const TopicList({
    super.key,
    required this.size,
    required List<String> topics,
  }) : _topics = topics; // Initializing the _topics list.

  final Size size;
  final List<String> _topics;

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicSelectionNotifier>(
      builder: (_, notifier, __) => Padding(
        padding: const EdgeInsets.all(13.0),
        child: CustomScrollView(slivers: [
          // The app bar as the instruction placeholder.
          SliverAppBar(
            automaticallyImplyLeading:
                false, // custom return button is used instead.
            backgroundColor: Colors.transparent,
            expandedHeight: size.width * 0.20,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(size.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    // Mode, may be abstracted to resued.
                    Text(
                      "Translation - flashcard",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: size.width * 0.06,
                          color: Colors.grey[500]),
                    ),
                    // Instruction.
                    Text(
                      "Please select the essay you would like to review.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.03,
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Grid to display the topic tiles.
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  childCount: _topics.length,
                  // Detect taps on each topic tile.
                  (context, index) => GestureDetector(
                      // Set the selected topic in the notifier when tapped.
                      onTap: () {
                        notifier.setTopic(_topics[index]);
                      },
                      // Creates a TopicTile for each topic.
                      child: TopicTile(topic: _topics[index]))),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.01,
                  mainAxisSpacing: MediaQuery.of(context).size.width * 0.01)),
          // An additional app bar at the bottom to avoid occlusion from dropdown menu.
          SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            expandedHeight: size.height * 0.1,
          ),
        ]),
      ),
    );
  }
}
