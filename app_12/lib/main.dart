import 'package:app_12/configs/constants.dart';
import 'package:app_12/configs/themes.dart';
import 'package:app_12/notifier/theme_controller.dart';
import 'package:app_12/notifier/topic_selection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/navigation_page.dart';
import 'notifier/flashcards_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure that Flutter engine is fully initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  /// Retrieve the shared preferences.
  final prefs = await SharedPreferences.getInstance();

  /// Theme controller which will get the currently selected theme from shared preferences
  final themeController = ThemeController(prefs);

  // Initialize and run the app using multiple providers for state management
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlashcardsNotifier(prefs)),
        ChangeNotifierProvider(create: (_) => TopicSelectionNotifier())
      ],
      child: MyApp(
        themeController: themeController,
      )));
}

/// Main app widget.
class MyApp extends StatefulWidget {
  MyApp({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder listens to changes in the theme controller.
    return AnimatedBuilder(
        animation: widget.themeController,
        builder: (context, _) {
          return ThemeControllerProvider(
            controller: widget.themeController,
            child: MaterialApp(
              theme: _buildCurrentTheme(),
              debugShowCheckedModeBanner: true,
              // First page when opened.
              home: const NavigationPage(),
            ),
          );
        });
  }

  /// Returns the theme based on the user's current selection in the ThemeController.
  ThemeData _buildCurrentTheme() {
    switch (widget.themeController.currentTheme) {
      case "BlueTheme":
        return themeColor(blueTheme);
      case "GreenTheme":
      default:
        return themeColor(greenTheme);
    }
  }
}
