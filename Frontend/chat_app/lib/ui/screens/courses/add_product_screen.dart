import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/ui/screens/courses/home_product_screen.dart';
import 'package:seller_app/utils/http.dart';
import 'package:seller_app/utils/image_picker.dart';

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

  List<Map<String, String>> colors = [
    {"color": "Xanh", "value": "false"},
    {"color": "Đỏ", "value": "false"},
    {"color": "Tím", "value": "false"},
    {"color": "Vàng", "value": "false"}
  ];

  String categorySelected = 'Chọn danh mục';

  List<String> categorys = ["Áo", "Quần", "Giày"];
  String products = "";
  List<String> dataProducts = [
    "Áo khoác, Áo ấm, Áo da",
    "Quần thun, Quần bò, Quần dài",
    "Giày da, dày thể thao, giày cao gót"
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  List<XFile>? images = [];

  bool isOnline = false;
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                runSpacing: 24,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeProductScreen(),
                            ));
                      },
                      child: const Text("go to home")),
                  Row(
                    children: [
                      const Text("tên sản phẩm"),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Nhập tên sản phẩm",
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text("giá sản phẩm"),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Nhập giá sản phẩm",
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Số lượng sản phẩm"),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Nhập số lượng sản phẩm",
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Danh mục"),
                      Flexible(
                        child: DropdownSearch(
                          selectedItem: categorySelected,
                          popupProps: const PopupProps.bottomSheet(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                          items: const ["Áo", "Quần", "Giày"],
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
                            e["value"] =
                                (!(bool.parse(e["value"]!))).toString();
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    )
                    .toList(),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final imagesPicker = await pickerMultiImage();
                        setState(() {
                          images = imagesPicker;
                        });
                      },
                      child: const Text('chọn hình')),
                  images!.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: images!.length,
                            itemBuilder: (context, index) {
                              XFile image = images![index];
                              return Image.file(
                                fit: BoxFit.cover,
                                File(image.path),
                                width: 200,
                              );
                            },
                          ),
                        )
                      : Container()
                ],
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    Map<String, String> colorMap = colors[index];
                    return Material(
                      color: bool.parse(colorMap['value']!)
                          ? Colors.amber
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            colorMap['value'] =
                                (!(bool.parse(colorMap['value']!))).toString();
                          });
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(colorMap['color']!)),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: isOnline,
                      onChanged: (value) => setState(() {
                            isOnline = !isOnline;
                          })),
                  const Text("Hoạt động")
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 18))),
          onPressed: () async {
            List<String> sizesSelected = [];
            for (var element in sizes) {
              if (element['value'] == "true") {
                sizesSelected.add(element['size']!);
              }
            }
            List<String> colorsSelected = [];
            for (var element in colors) {
              if (element['value'] == 'true') {
                colorsSelected.add(element['color']!);
              }
            }

            List<MultipartFile> files = [];
            for (XFile? file in images!) {
              files.add(await MultipartFile.fromFile(file!.path));
            }
            FormData data = FormData.fromMap({
              "name": _nameController.text,
              "price": _priceController.text,
              // "images": images!.map((e) async =>  await MultipartFile.fromFile(e.path)).toList(),
              "images": files,
              "amount": _amountController.text,
              "category": categorySelected,
              "size": sizesSelected.join(","),
              "colors": colorsSelected.join(','),
              "isOnline": isOnline ? 1 : 0
            });
            print(data);
            await addProduct(data, context);
          },
          child: const Text("THÊM SẢN PHẨM")),
    );
  }
}

Future<void> addProduct(FormData formData, BuildContext context) async {
  try {
    Response res = await Http().dio.post('/product/add', data: formData);
    print("STATUS: ${res.statusCode}");
    if (res.statusCode == 200) {
      print("add product success! ${res.data}");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Đã thêm sản phẩm")));
    } else {
      print("add product failure! ${res.data}");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Đã xảy ra lỗi")));
    }
  } catch (err) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Đã xảy ra lỗi")));
    print("error $err");
  }
}
