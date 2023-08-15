import 'dart:io';

import 'package:flutter/material.dart';
import 'package:seller_app/constants/constants.dart';

class DetailPost extends StatelessWidget {
  const DetailPost(
      {super.key, required this.urlImage, required this.titlePost});
  final String urlImage;
  final String titlePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titlePost),
      ),
      body: Column(children: [
        Hero(
            tag: '$urlImage',
            child: Expanded(
                child: !urlImage.contains('\\')
                    ? Image.network(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        "${Constants.BASE_URL}/images/$urlImage")
                    : Image.file(File(urlImage),
                        fit: BoxFit.cover, width: double.infinity))),
      ]),
    );
  }
}
