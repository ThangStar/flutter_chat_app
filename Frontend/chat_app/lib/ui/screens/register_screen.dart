import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(runSpacing: 12, children: [
                Text("ĐĂNG KÍ"),
                MyTextField(label: "tài khoản", controller: TextEditingController(),),
                MyTextField(
                  controller: TextEditingController(),
                  label: "nhập lại mật khẩu",
                ),
                MyTextField(
                  controller: TextEditingController(),
                  label: "mật khẩu",
                ),
                MyButton(onPressed: () {  },)
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
