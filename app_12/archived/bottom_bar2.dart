import 'package:flutter/material.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});
  @override
  State<MyBottomBar> createState() => _MyBottomBar();
}

class _MyBottomBar extends State<MyBottomBar> {
  bool isScrollable = false;
  bool showNextIcon = false;
  bool showBackIcon = false;

  List<TabData> tabs = [
    TabData(
      index: 1,
      title: const Tab(
        child: Icon(Icons.event, size: 30),
      ),
      content: const Center(child: Text('Content for Tab 1')),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('Tab 2'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),
    // Add more tabs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DynamicTabBarWidget(
        labelColor: const Color.fromARGB(255, 19, 27, 60),
        indicatorColor: const Color.fromARGB(255, 19, 27, 60),
        dynamicTabs: tabs,
        isScrollable: isScrollable,
        onTabControllerUpdated: (controller) {},
        onTabChanged: (index) {},
        onAddTabMoveTo: MoveToTab.last,
        showBackIcon: showBackIcon,
        showNextIcon: showNextIcon,
      ),
    );
  }
}
