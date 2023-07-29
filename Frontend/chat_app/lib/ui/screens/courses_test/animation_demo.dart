import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _anim;
  late bool isLarge;

  @override
  void initState() {
    super.initState();

    isLarge = true;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200));
    _anim = Tween<double>(begin: 500, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut))
      ..addListener(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("animation demo"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                if (isLarge) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                setState(() {
                  isLarge = !isLarge;
                });
              },
              child: Text("$isLarge")),
          Expanded(
              child: Container(
            width: _anim.value,
            decoration: const BoxDecoration(color: Colors.green),
          )),
          Expanded(
              child: Container(
            height: 100,
            decoration: const BoxDecoration(color: Colors.grey),
          )),
          Expanded(
              child: TweenAnimationBuilder(
                curve: Curves.bounceOut,
            tween: Tween<double>(begin: 0, end: 1000),
            duration: Duration(milliseconds: 200),
            builder: (BuildContext context, double value, Widget? child) {
              return Container(
                width: value,
                decoration: const BoxDecoration(color: Colors.grey),
              );
            },
          )),
        ],
      ),
    );
  }
}
