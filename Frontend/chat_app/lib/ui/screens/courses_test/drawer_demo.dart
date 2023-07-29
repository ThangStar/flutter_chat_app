import 'package:flutter/material.dart';

class DrawerDemo extends StatelessWidget {
  const DrawerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawerDemo(),
      appBar: AppBar(
        title: const Text("TITLE"),
      ),
    );
  }
}

class MyDrawerDemo extends StatelessWidget {
  const MyDrawerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const UserAccountsDrawerHeader(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/phong-canh-1.jpg"))),
          accountName: Text("accountName"),
          accountEmail: Text("accountEmail")),
      ListTile(
        onTap: () => null,
        title: const Text("Thêm"),
        leading: const Icon(Icons.add_box),
      ),
      ListTile(
        onTap: () => null,
        title: const Text("account_balance"),
        leading: const Icon(Icons.account_balance),
        trailing: ClipOval(
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.red
            ),
            child: const Center(child: Text("20", style: TextStyle(color: Colors.white),)),
          ),
        ),
      ),
      const Divider(),
      ListTile(
        onTap: () => null,
        title: const Text("access_time_filled_sharp"),
        leading: const Icon(Icons.access_time_filled_sharp),
      ),
    ]));
  }
}
