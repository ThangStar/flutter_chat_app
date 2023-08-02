import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seller_app/constants/constants.dart';
import 'package:seller_app/ui/screens/courses/model/product.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    List<String> images = product.image.split(',');
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detal product screen"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "${Constants.BASE_URL}/images/${images[Random().nextInt(images.length)]}",
              height: 240,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TÊN: ${product.name}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Danh mục: ${product.category}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    "Giá: ${product.amount}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    "Kích thước: ${product.size}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    "Màu sắc: ${product.colors}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.6)),
                  ),
                  ClipOval(
                    child: Container(
                      width: 20,
                      height: 20,
                      color: product.isOnline == 1 ? Colors.red : Colors.green,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.image.split(",").length,
                itemBuilder: (BuildContext context, int index) {
                  String image = product.image.split(",")[index];
                  return Image.network(
                    "${Constants.BASE_URL}/images/$image",
                    fit: BoxFit.cover,
                  );
                },
              ),
            )
          ],
        ));
  }
}
