import 'package:app_12/data/rev_mode.dart';
import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:app_12/notifier/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_12/components/revision_tile.dart';
import 'package:provider/provider.dart';

// HomePage is a list of revision modes.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _modes = [];
  @override
  // Extract unique revision modes from revMode data and sort them.
  void initState() {
    for (var m in revMode) {
      if (!_modes.contains(m.mode)) {
        _modes.add(m.mode);
      }
    }
    _modes.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // For testing, will be moved to setting pages later.
        Consumer<FlashcardsNotifier>(
            builder: (_, notifier, __) => CheckboxListTile(
                value: notifier.currentPref,
                onChanged: (bool? value) {
                  Provider.of<FlashcardsNotifier>(context, listen: false)
                      .setShowGuideDialog(value!);
                })),
        // For testing, will be moved to setting pages later.
        ElevatedButton(
            onPressed: () {
              ThemeController.of(context).setTheme('GreenTheme');
            },
            child: const Text("change theme colour")),
        Expanded(
          child: ListView.builder(
            itemCount: _modes.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // Create a revision tile for each mode.
              return RevisionTile(topic: _modes[index]);
            },
          ),
        )
      ],
    );
  }
}
