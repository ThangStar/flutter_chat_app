import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/ui/screens/courses/detail_product_screen.dart';
import 'package:seller_app/ui/screens/courses/model/product.dart';
import 'package:seller_app/utils/http.dart';

import '../../../constants/constants.dart';

class HomeProductScreen extends StatefulWidget {
  const HomeProductScreen({super.key});

  @override
  State<HomeProductScreen> createState() => _HomeProductScreenState();
}

class _HomeProductScreenState extends State<HomeProductScreen> {
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    Http().dio.get("/product").then((value) {
      print(value.data);
      List<dynamic> productsJson = jsonDecode(value.data) as List<dynamic>;

      setState(() {
        products = productsJson.map((e) => Product.fromJson(e)).toList();
      });
      // print(products.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME SCREEN"),
      ),
      body: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ItemProduct(product: product);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 20,
          );
        },
      ),
    );
  }
}

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    List<String> images = product.image.split(',');
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductScreen(product: product))),
      child: Column(
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
                  product.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  product.category,
                  style:
                      TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
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
        ],
      ),
    );
  }
}

Future<String> getFullProduct() async {
  Response rs = await Http().dio.get("/product");
  if (rs.statusCode == 200) {
    return rs.data;
  }
  return rs.data;
}
