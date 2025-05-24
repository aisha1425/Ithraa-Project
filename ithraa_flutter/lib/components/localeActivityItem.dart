import 'package:flutter/material.dart';
import 'package:ithraa/utils/urls.dart';

class LocaleActivityItem extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String date;
  const LocaleActivityItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  State<LocaleActivityItem> createState() => _LocaleActivityItemState();
}

class _LocaleActivityItemState extends State<LocaleActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (widget.image != '')
                  ? Image.network(
                      imageUrl + widget.image,
                      height: 150,
                    )
                  : Image.asset(
                      'assets/ithraa.png',
                      height: 150,
                    )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Text(widget.description),
                Text(widget.date),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
