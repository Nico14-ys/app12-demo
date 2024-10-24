import 'package:app_12/components/trans_selection_page/bar_widget.dart';
import 'package:app_12/components/trans_selection_page/menu_widget.dart';
import 'package:app_12/components/trans_selection_page/mode_selection.dart';
import 'package:app_12/notifier/flashcards_notifier.dart';
import 'package:app_12/notifier/topic_selection_notifier.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// CustomDropDown is a StatefulWidget that displays a selection bar with a dropdown menu.
// When clicked, it reveals different mode selection options in the dropdown.
class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  final OverlayPortalController _tooltipController = OverlayPortalController();

  /// Link to align the bar with the dropdown menu.
  final _link = LayerLink();
  final double modeHeight = 100;

  /// width of the bar after the widget rendered
  double? _buttonWidth;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link, // Link that connects the bar to its overlay.
      child: OverlayPortal(
          controller:
              _tooltipController, // Controls showing/hiding the overlay.
          overlayChildBuilder: (BuildContext context) {
            // Menu widget.
            return CompositedTransformFollower(
              link:
                  _link, // Align the follower (dropdown) with the target (bar).
              followerAnchor: Alignment.bottomLeft,
              targetAnchor: Alignment.topLeft,
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: TapRegion(
                  onTapOutside: (tap) {
                    // Close the dropdown when tapping outside of it.
                    // Hide the dropdown.
                    _tooltipController.toggle();
                    // Toggle the state of the menu to show appropriate arrows.
                    Provider.of<TopicSelectionNotifier>(context, listen: false)
                        .ToggleMenu();
                  },
                  child: MenuWidget(
                      height: modeHeight * 3 + 13 * 4, // 13 is the spacing
                      width: _buttonWidth,
                      child: Column(
                        children: [
                          // ModeSelection for '順序' (Sequential mode).
                          ModeSelection(
                              mode: "Sequential",
                              description:
                                  "Each card will appear in a fixed order, and each card will only appear once.",
                              width: MediaQuery.of(context).size.width,
                              height: modeHeight),
                          Spacer(),
                          // ModeSelection for '隨機' (Random mode).
                          ModeSelection(
                              mode: "Random",
                              description:
                                  "Each card will appear in a random order, and each card will only appear once.",
                              width: MediaQuery.of(context).size.width,
                              height: modeHeight),
                          Spacer(),
                          // ModeSelection for '智慧循環' (Smart Loop mode).
                          ModeSelection(
                              mode: "Smart Loop",
                              description:
                                  "Each card will appear in a random order and will repeat until you answer correctly.",
                              width: MediaQuery.of(context).size.width,
                              height: modeHeight)
                        ],
                      )),
                ),
              ),
            );
          },
          // Bar Widget that show current mode and toggles the menu.
          child: Consumer<TopicSelectionNotifier>(
            builder: (_, notifier1, __) => BarWidget(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07,
              onTap: onTap, // When tapped, trigger the onTap function.
              child: Consumer<FlashcardsNotifier>(
                builder: (_, notifier, __) => Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0),
                  child: Row(
                    children: [
                      // Display the current mode.
                      Text("Mode：" +
                          notifier.mode.keys.firstWhere(
                              (k) => notifier.mode[k] == true,
                              orElse: () => "")),
                      Spacer(),
                      // Arrow icon indicates how will the menu be toggled when bar is tapped.
                      // Is notified once toggled to change icon.
                      notifier1.menuOpened
                          ? Icon(Iconsax.arrow_down_1_copy)
                          : Icon(Iconsax.arrow_up_2_copy)
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  // onTap toggles the dropdown menu and saves the bar's width for alignment.
  void onTap() {
    // Change the state of menuOpened in notifier in order to correctly show arrow
    Provider.of<TopicSelectionNotifier>(context, listen: false).ToggleMenu();
    _buttonWidth = context.size?.width;
    _tooltipController.toggle();
  }
}
