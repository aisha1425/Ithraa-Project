import 'package:flutter/material.dart';
import 'package:ithraa/profile.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;
  final bool? back;
  const CustomAppBar(
      {super.key, required this.appBar, required this.title, this.back});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String profileImage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProfileImage();
  }

  void loadProfileImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      profileImage = sharedPreferences.getString("image") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: (widget.back == null)
          ? BackButton(
              color: Colors.white,
            )
          : Container(),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade400,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Profile()));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: (profileImage != '')
                    ? Image.network(imageUrl + profileImage)
                    : Image.asset(
                        'assets/profileIcon.png',
                        width: 40,
                      ),
              )),
        ),
      ],
    );
  }
}
