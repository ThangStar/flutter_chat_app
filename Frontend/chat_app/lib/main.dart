import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seller_app/ui/blocs/auth/auth_bloc.dart';
import 'package:seller_app/ui/blocs/comment/comment_bloc.dart';
import 'package:seller_app/ui/blocs/message/message_bloc.dart';
import 'package:seller_app/ui/blocs/person_chated/person_chatted_bloc.dart';
import 'package:seller_app/ui/blocs/post/post_bloc.dart';
import 'package:seller_app/ui/blocs/profile/profile_bloc.dart';
import 'package:seller_app/ui/blocs/search/search_bloc.dart';
import 'package:seller_app/ui/screens/courses_test/animation_demo.dart';
import 'package:seller_app/ui/screens/login_screen.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/theme/text_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // check if is running on Web
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MessageBloc(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => PersonChattedBloc(),
            ),
            BlocProvider(
              create: (context) => PostBloc(),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(),
            ),
            BlocProvider(
              create: (context) => SearchBloc(),
            ),
            BlocProvider(
              create: (context) => CommentBloc(),
            ),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                  textTheme: textTheme),
              darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: darkColorScheme,
                  textTheme: textTheme),
              themeMode: currentMode,
              home: const LoginScreen()),
        );
      },
    );
  }
}
