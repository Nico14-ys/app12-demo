import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the currently selected theme, saves changed theme preferences to disk.
class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  ThemeController(this._prefs)
      :
        // Load theme from preferences on initialization.
        _currentTheme = _prefs.getString(themePrefKey) ?? 'BlueTheme';

  final SharedPreferences _prefs;
  String _currentTheme;

  /// Get the current theme.
  String get currentTheme => _currentTheme;

  void setTheme(String theme) {
    _currentTheme = theme;

    // Notify the app that the theme was changed.
    notifyListeners();

    // Store updated theme on disk.
    _prefs.setString(themePrefKey, theme);
  }

  /// Get the controller from any page of your app.
  static ThemeController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>()
            as ThemeControllerProvider;
    return provider.controller;
  }
}

/// Provides the theme controller to any page of your app.
class ThemeControllerProvider extends InheritedWidget {
  const ThemeControllerProvider(
      {Key? key, required this.controller, required Widget child})
      : super(key: key, child: child);

  final ThemeController controller;

  @override
  bool updateShouldNotify(ThemeControllerProvider old) =>
      controller != old.controller;
}
