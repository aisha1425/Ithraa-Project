import 'package:flutter/material.dart';

class HomeCategoryItem extends StatefulWidget {
  final String title;
  final String description;
  final Widget nextpage;
  final IconData icon;
  const HomeCategoryItem({
    super.key,
    required this.title,
    required this.description,
    required this.nextpage,
    required this.icon,
  });

  @override
  State<HomeCategoryItem> createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
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
                  color: Colors.purple,
                  size: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.purple.shade100,
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
            ],
          ),
        ),
      ),
    );
  }
}
