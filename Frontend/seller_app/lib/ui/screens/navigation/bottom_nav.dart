// import 'package:flutter/cupertino.dart';
// import 'package:seller_app/ui/screens/profile_screen.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});
//
//   @override
//   State<BottomNav> createState() => _BottomNavState();
//
// }
//
// class _BottomNavState extends State<BottomNav> {
//   late PersistentTabController _controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _controller = PersistentTabController(initialIndex: 0);
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       // confineInSafeArea: true,
//       // backgroundColor: Colors.white, // Default is Colors.white.
//       // handleAndroidBackButtonPress: true, // Default is true.
//       // resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//       // stateManagement: true, // Default is true.
//       // hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//       // decoration: NavBarDecoration(
//       //   borderRadius: BorderRadius.circular(10.0),
//       //   colorBehindNavBar: Colors.white,
//       // ),
//       // popAllScreensOnTapOfSelectedTab: true,
//       // popActionScreens: PopActionScreensType.all,
//       // itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
//       //   duration: Duration(milliseconds: 200),
//       //   curve: Curves.ease,
//       // ),
//       // screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
//       //   animateTabTransition: true,
//       //   curve: Curves.ease,
//       //   duration: Duration(milliseconds: 200),
//       // ),
//       navBarStyle: NavBarStyle.style7, // Choose the nav bar style with this property.
//     );
//   }
// }
//
// List<Widget> _buildScreens() {
//   return [
//     ProfileScreen(),
//     ProfileScreen(),
//     ProfileScreen(),
//     ProfileScreen(),
//   ];
// }
//
//
// List<PersistentBottomNavBarItem> _navBarsItems() {
//   return [
//     PersistentBottomNavBarItem(
//       icon: Icon(CupertinoIcons.home),
//       title: ("Home"),
//       activeColorPrimary: CupertinoColors.activeBlue,
//       inactiveColorPrimary: CupertinoColors.systemGrey,
//     ),
//     PersistentBottomNavBarItem(
//       icon: Icon(CupertinoIcons.settings),
//       title: ("Settings"),
//       activeColorPrimary: CupertinoColors.activeBlue,
//       inactiveColorPrimary: CupertinoColors.systemGrey,
//     ),
//   ];
// }
//
