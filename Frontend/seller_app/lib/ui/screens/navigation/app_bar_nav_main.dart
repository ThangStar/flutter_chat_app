import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seller_app/ui/screens/home_screen.dart';
import 'package:seller_app/ui/screens/profile_screen.dart';
import 'package:seller_app/ui/screens/utils_screen.dart';

import '../../theme/color_schemes.dart';
import '../message_screen.dart';

class AppBarNavMain extends StatefulWidget {
  const AppBarNavMain({super.key});

  @override
  State<AppBarNavMain> createState() => _AppBarNavMainState();
}

class _AppBarNavMainState extends State<AppBarNavMain>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Omit',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              pinned: true,
              floating: true,
              bottom: TabBar(
                onTap: (value) => {print(value)},
                tabs: [
                  Tab(child: SvgPicture.asset("assets/svg/home.svg")),
                  Tab(
                      child: Badge(
                      child: SvgPicture.asset("assets/svg/chat.svg"))),
                  Tab(child: SvgPicture.asset("assets/svg/menu.svg")),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            HomeScreen(),
            MessageScreen(),
            UtilsScreen(),
          ],
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void initAppBar(BuildContext context, List<Widget> titles) {
    titles = [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Chào ,",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.6)),
        ),
        Text("Tin nhắn",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ])
    ];
  }
}
