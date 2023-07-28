import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/constants/constants.dart';
import 'package:seller_app/storages/storage.dart';
import 'package:seller_app/ui/screens/profile_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/avatar.dart';

import '../../main.dart';
import '../blocs/profile/profile_bloc.dart';

class UtilsScreen extends StatefulWidget {
  const UtilsScreen({super.key});

  @override
  State<UtilsScreen> createState() => _UtilsScreenState();
}

class _UtilsScreenState extends State<UtilsScreen> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();

    Storage.getIsDarkTheme().then((value) {
      print("is Dark: $value");

      MyApp.themeNotifier.value =
          value ?? false ? ThemeMode.dark : ThemeMode.light;

      setState(() {
        isDark = value ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));
                },
                leading: Avatar(url: state.profile.avatar),
                title: Text(state.profile.fullName),
                subtitle: const Text("Xem trang cá nhân"),
                trailing: const Icon(Icons.keyboard_arrow_down),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Chung",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme(context).scrim.withOpacity(0.6)),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Bạn bè"),
            trailing: Icon(Icons.arrow_right_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Khác",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme(context).scrim.withOpacity(0.6)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Chế độ tối"),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                Storage.setDarkTheme(value);
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                setState(() {
                  isDark = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
