import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/ui/blocs/auth/auth_bloc.dart';
import 'package:seller_app/ui/screens/message_screen.dart';
import 'package:seller_app/ui/widgets/my_button.dart';

import '../widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is LoginSuccess){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MessageScreen(),));
        }
      },
      child: Scaffold(
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
                    controller: controllerUsername,
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
      ),
    );
  }
}
