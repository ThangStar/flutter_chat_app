import 'package:flutter/material.dart';
import 'package:seller_app/ui/screens/home_screen.dart';
import 'package:seller_app/ui/screens/message_screen.dart';
import 'package:seller_app/ui/screens/profile_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';

class BottomNavMain extends StatefulWidget {
  const BottomNavMain({super.key});

  @override
  State<BottomNavMain> createState() => _BottomNavMainState();
}

class _BottomNavMainState extends State<BottomNavMain> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        HomeScreen(),
        MessageScreen(),
        ProfileScreen(),
      ][selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: colorScheme(context).secondary.withOpacity(0.5),
        backgroundColor: colorScheme(context).secondary.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.signpost, color: Colors.black),
            icon: Icon(Icons.signpost_outlined),
            label: 'Post',
          ),
          NavigationDestination(

            selectedIcon: Icon(Icons.message_outlined, color: Colors.black),
            icon: Icon(Icons.message_outlined),
            label: 'Message',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.black),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
