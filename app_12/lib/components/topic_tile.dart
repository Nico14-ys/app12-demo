import 'package:app_12/notifier/topic_selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TopicTile is the box widget for each essay.
class TopicTile extends StatefulWidget {
  const TopicTile({super.key, required this.topic});

  final String topic;

  @override
  State<TopicTile> createState() => _TopicTileState();
}

class _TopicTileState extends State<TopicTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicSelectionNotifier>(
        builder: (_, notifier, __) => Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  // Highlight the box with a blue border if the current mode is selected.
                  border: widget.topic == notifier.topic
                      ? Border.all(
                          color: Theme.of(context).primaryColorDark, width: 3)
                      : Border.all(color: Colors.transparent, width: 3)),
              child: Center(
                // Size relative to its parent for better spacing.
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  heightFactor: 0.95,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors
                            .white), // To be changed to respective essay title and image.
                    child: Text(widget.topic),
                  ),
                ),
              ),
            ));
  }
}
