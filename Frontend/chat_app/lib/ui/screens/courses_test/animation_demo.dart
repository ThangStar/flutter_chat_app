import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:seller_app/ui/screens/courses_test/model/task.dart';

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  final listData = ["Orange", "Apple", "Lemon"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("this is title"),
        ),
        body: Column(
          children: [
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  String item = listData[index];
                  return ListTile(
                    onTap: () {
                    },
                    leading: Icon(Icons.abc),
                    title: Text(item),
                  )
                      .animate(
                        delay: (index * 300 - 100).ms)
                      .moveX(begin: -200, duration: 800.ms, curve: Curves.bounceOut)
                      .fade(duration: 800.ms);
                },
              ),
            ),
          ],
        ));
  }
}
