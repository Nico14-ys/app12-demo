import 'package:flutter/material.dart';
import '../components/bottom_bar3.dart';

// Stateful widget for different pages with a persistent bottom navigation bar.
class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    // Custom bottom navigation bar.
    return const Scaffold(
      bottomNavigationBar: MyBottomBar(),
    );
  }
}
