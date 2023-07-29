import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool isExpanded = false;
  List<Map<String, String>> sizes = [
    {"size": "X", "value": "true"},
    {"size": "M", "value": "false"},
    {"size": "L", "value": "false"},
    {"size": "XXL", "value": "false"}
  ];

  String categorySelected = 'Chọn danh mục';

  List<String> categorys = ["Áo", "Quần", "Giày"];
  String products = "";
  List<String> dataProducts = [
    "Áo khoác, Áo ấm, Áo da",
    "Quần thun, Quần bò, Quần dài",
    "Giày da, dày thể thao, giày cao gót"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm sản phẩm"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 24,
              children: [
                Row(
                  children: [
                    const Text("tên sản phẩm"),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: const InputDecoration(
                            isDense: true,
                            hintText: "Nhập tên sản phẩm",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                        onChanged: (value) => null,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("giá sản phẩm"),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: const InputDecoration(
                            isDense: true,
                            hintText: "Nhập giá sản phẩm",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                        onChanged: (value) => null,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Số lượng sản phẩm"),
                    SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: const InputDecoration(
                            isDense: true,
                            hintText: "Nhập số lượng sản phẩm",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                        onChanged: (value) => null,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Danh mục"),
                    Flexible(
                      child: DropdownSearch(
                        selectedItem: categorySelected,
                        popupProps: PopupProps.bottomSheet(
                          showSearchBox: true,
                        ),
                        onChanged: (newValue) {
                          categorys.asMap().forEach((index, element) {
                            if (element == newValue) {
                              setState(() {
                                products = dataProducts[index];
                              });
                            }
                          });
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListView.builder(
                                itemCount: products.split(",").length,
                                itemBuilder: (BuildContext context, int index) {
                                  String value = products.split(",")[index];
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        categorySelected = value;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    title: Text(value),
                                  );
                                },
                              );
                            },
                          );
                        },
                        items: ["Áo", "Quần", "Giày"],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "Size",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Column(
              children: sizes
                  .map(
                    (e) => CheckboxListTile(
                      title: Text(e["size"]!),
                      value: bool.parse(e["value"]!),
                      onChanged: (newValue) {
                        setState(() {
                        e["value"] = (!(bool.parse(e["value"]!))).toString();

                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
