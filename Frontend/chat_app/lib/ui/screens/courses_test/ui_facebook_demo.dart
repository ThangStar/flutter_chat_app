import 'package:flutter/material.dart';

class UiFacebookDemo extends StatelessWidget {
  const UiFacebookDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FACEBOOK",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4692F4)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Wrap(
              spacing: 12,
              children: [
                const IconAction(
                    icon: Icons.search, backgroundColor: Colors.grey),
                const IconAction(
                    icon: Icons.notifications,
                    backgroundColor: Colors.redAccent),
                IconAction(
                    icon: Icons.person,
                    backgroundColor: Colors.blueAccent.withOpacity(0.6)),
                const IconAction(
                    icon: Icons.message, backgroundColor: Colors.blueAccent),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const InputAndAvatarPost(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemUtilsAction(
                  icon: Icons.image,
                  label: "Gallery",
                  leadingColor: Colors.green,
                  trailingColor: Colors.green.withOpacity(0.1),
                ),
                ItemUtilsAction(
                  icon: Icons.image,
                  label: "Tag Friends",
                  leadingColor: Colors.blue,
                  trailingColor: Colors.blue.withOpacity(0.1),
                ),
                ItemUtilsAction(
                  icon: Icons.image,
                  label: "Live",
                  leadingColor: Colors.redAccent,
                  trailingColor: Colors.redAccent.withOpacity(0.1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return const VideoShortItem(
                  imageAvatar: 'assets/images/avatar.png',
                  imageBackground: 'assets/images/wallpaper.jpg',
                  fullname: 'fullname',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class VideoShortItem extends StatelessWidget {
  const VideoShortItem(
      {super.key,
      required this.imageBackground,
      required this.imageAvatar,
      required this.fullname});

  final String imageBackground;
  final String imageAvatar;
  final String fullname;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              imageBackground,
              height: 120,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: SizedBox(
                width: 40,
                height: 40,
                child: ClipOval(
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(imageAvatar),
                      )),
                ),
              )),
          Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: Text(
                fullname,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}

class ItemUtilsAction extends StatelessWidget {
  const ItemUtilsAction(
      {super.key,
      required this.icon,
      required this.label,
      required this.leadingColor,
      required this.trailingColor});

  final IconData icon;
  final String label;
  final Color leadingColor;
  final Color trailingColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: trailingColor,
      ),
      child: Row(
        children: [
          IconButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(leadingColor)),
              onPressed: () {},
              icon: Icon(
                icon,
                color: Colors.white,
              )),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Text(
              label,
              style: TextStyle(color: leadingColor),
            ),
          ),
        ],
      ),
    );
  }
}

class IconAction extends StatelessWidget {
  const IconAction(
      {super.key, required this.icon, required this.backgroundColor});

  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backgroundColor)),
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.white,
        ));
  }
}

class InputAndAvatarPost extends StatelessWidget {
  const InputAndAvatarPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/wallpaper.jpg"),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  isDense: true,
                  hintStyle: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.3)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  hintText: "What's on your mind, lisa?",
                  border:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
              controller: TextEditingController(),
            ),
          )
        ],
      ),
    );
  }
}
