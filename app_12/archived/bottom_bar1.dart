import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  _MyBottomBar createState() => _MyBottomBar();
}

class _MyBottomBar extends State<MyBottomBar> {
  int _selectedIndex = 0;
  final List _list = [
    const Text("Page 1"),
    const Text("Page 2"),
    const Text("Page 3"),
    const Text("Page 4"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.event, size: 30),
              title: const Text('Events'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.search, size: 30),
              title: const Text('Search'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.highlight, size: 30),
              title: const Text('Highlights'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.person, size: 30),
              title: const Text('Settings'),
            ),
          ],
        ),
        body: Container(child: _list.elementAt(_selectedIndex)));
  }
}
