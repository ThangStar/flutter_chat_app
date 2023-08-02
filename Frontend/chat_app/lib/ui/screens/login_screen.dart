import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/model/profile.dart';
import 'package:seller_app/ui/blocs/auth/auth_bloc.dart';
import 'package:seller_app/ui/blocs/profile/profile_event.dart';
import 'package:seller_app/ui/screens/register_screen.dart';
import 'package:seller_app/ui/widgets/my_button.dart';

import '../../main.dart';
import '../../storages/storage.dart';
import '../blocs/profile/profile_bloc.dart';
import '../widgets/my_text_field.dart';
import 'navigation/app_bar_nav_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc _authBloc;
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    Storage.getIsDarkTheme().then((value) {
      print("is Dark: $value");

      MyApp.themeNotifier.value =
          value ?? false ? ThemeMode.dark : ThemeMode.light;
    });

    _authBloc = BlocProvider.of<AuthBloc>(context);
    context.read<ProfileBloc>().add(InitProfileEvent());
    Storage.getMyProfile().then((value) {
      print(value);
      setState(() {
          if (value != null) {
            Profile prf = Profile.fromRawJson(value);
            controllerUsername.text = prf.username;
            controllerPassword.text = prf.password;
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is LoginSuccess) {
        context.read<ProfileBloc>().add(InitProfileEvent());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppBarNavMain(),
            ));
      }
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Tài khoản hoặc mật khẩu không chính xác!")));
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ĐĂNG NHẬP"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(runSpacing: 12, children: [
                  // controllerUsername =
                  //     TextEditingController(text: state.profile.username);
                  // controllerPassword =
                  //     TextEditingController(text: state.profile.password);
                  MyTextField(
                    label: "tài khoản",
                    controller: controllerUsername,
                  ),
                  MyTextField(
                    label: "mật khẩu",
                    controller: controllerPassword,
                  ),
                  MyButton(
                    text: "Đăng nhập",
                    onPressed: () async {
                      _authBloc.add(LoginAuth(
                          username: controllerUsername.text,
                          password: controllerPassword.text));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Chưa có tài khoản?"),
                      InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Đăng kí ngay"),
                          ))
                    ],
                  )
                ]),
              ],
            ),
          ),
        ),
      );
    });
  }
}
