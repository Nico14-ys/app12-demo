import 'package:app_12/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

// Bottom bar for the main navigation page of the app.
class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomBarController());

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 12.0,
            color: Theme.of(context).primaryColorDark,
          ),
        )),
        // Widget listens for changes.
        child: Obx(
          () => NavigationBar(
            height: 75,
            indicatorColor: Theme.of(context).primaryColorLight,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            // Observing changes in selectedIndex from the controller.
            selectedIndex: controller.selectedIndex.value,
            // Setting the index when a navigation destination is selected.
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            // List of navigation destinations.
            destinations: [
              NavigationDestination(
                  icon: Icon(Iconsax.home_2_copy,
                      color: Theme.of(context).primaryColorDark),
                  label: 'Home Page'),
              NavigationDestination(
                  icon: Icon(Iconsax.book_copy,
                      color: Theme.of(context).primaryColorDark),
                  label: 'Materials'),
              NavigationDestination(
                  icon: Icon(Iconsax.activity_copy,
                      color: Theme.of(context).primaryColorDark),
                  label: 'Analysis'),
              NavigationDestination(
                  icon: Icon(Iconsax.user_copy,
                      color: Theme.of(context).primaryColorDark),
                  label: 'Account'),
            ],
          ),
        ),
      ),
      // Displays the appropriate screen based on the selected index.
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

// Controller for managing the bottom navigation bar.
class BottomBarController extends GetxController {
  // An observable integer that holds the index of the selected page.
  final Rx<int> selectedIndex = 0.obs;

  // A list of pages/screens corresponding to each navigation item.
  final screens = [
    const HomePage(),
    Container(
        color: const Color.fromARGB(
            255, 245, 246, 247)), // Placeholder for undeveloped page.
    Container(
        color: const Color.fromARGB(
            255, 245, 246, 247)), // Placeholder for undeveloped page.
    Container(
        color: const Color.fromARGB(
            255, 245, 246, 247)), // Placeholder for undeveloped page.
  ];
}
