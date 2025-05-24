import 'package:flutter/material.dart';

class HomeItem extends StatefulWidget {
  final String title;
  final String description;
  final Widget nextpage;
  final IconData icon;
  final Color background;
  const HomeItem(
      {super.key,
      required this.title,
      required this.description,
      required this.nextpage,
      required this.icon,
      required this.background});

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => widget.nextpage));
      },
      child: Card(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Row(
            spacing: 16,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: widget.background,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
