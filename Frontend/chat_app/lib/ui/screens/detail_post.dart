import 'package:flutter/material.dart';
import 'package:seller_app/constants/constants.dart';

class DetailPost extends StatelessWidget {
  const DetailPost({super.key, required this.urlImage});
  final String urlImage;
  @override
  Widget build(BuildContext context) {
    print("${Constants.BASE_URL}/images/$urlImage");
    return Scaffold(
      appBar: AppBar(
        title: Text("Image detail$urlImage"),
      ),
      body: Column(children: [
        Hero(
            tag: '$urlImage',
            child: Expanded(
              child: Image.network(
                fit: BoxFit.cover,
                width: double.infinity,
                "${Constants.BASE_URL}/images/$urlImage"))),
      ]),
    );
  }
}

