
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/ui/blocs/auth/auth_bloc.dart';
import 'package:seller_app/ui/screens/message_screen.dart';
import 'package:seller_app/ui/widgets/my_button.dart';

import '../../model/profile.dart';
import '../../storages/storage.dart';
import '../widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc _authBloc;
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  _initDataInput() async{
    String? myProfile = await Storage.getMyProfile();
    if (myProfile != null) {
      Profile profile = Profile.fromRawJson(myProfile);
      controllerUsername.text = profile.username;
      controllerPassword.text = profile.password;
    }
  }
  @override
  void initState()  {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _initDataInput();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MessageScreen(),
            ));
      }
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Tài khoản hoặc mật khẩu không chính xác!")));
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(runSpacing: 12, children: [
                  const Text("ĐĂNG NHẬP"),
                  MyTextField(
                    label: "tài khoản",
                    controller:controllerUsername,
                  ),
                  MyTextField(
                    label: "mật khẩu",
                    controller: controllerPassword,
                  ),
                  MyButton(
                    onPressed: () {
                      _authBloc
                        ..add(LoginAuth(
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
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
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
