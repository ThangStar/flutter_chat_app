import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, this.label, required this.controller});

  final String? label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label ?? "label") ,
        border: const OutlineInputBorder(borderSide: BorderSide(width: 1))
      ),
    );
  }
}
