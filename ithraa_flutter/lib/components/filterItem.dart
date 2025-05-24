import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  final String title;
  final bool active;
  const FilterItem({super.key, required this.title, required this.active});

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.active);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: (widget.active)
              ? Border.all(color: Colors.transparent)
              : Border.all(width: 1),
          color: (widget.active) ? Colors.purple.shade50 : Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          spacing: 10,
          children: [
            if (widget.active)
              Icon(
                Icons.check,
              ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
