import 'package:flutter/material.dart';
import 'package:ithraa/jobPage.dart';

class JobItem extends StatefulWidget {
  final id;
  final title;
  final company;
  final description;
  final type;
  final location;
  final salary;
  final date;
  final userType;
  const JobItem(
      {super.key,
      required this.id,
      required this.title,
      required this.company,
      required this.description,
      required this.type,
      required this.location,
      required this.salary,
      required this.date,
      required this.userType});

  @override
  State<JobItem> createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => JobPage(
                    id: widget.id,
                    title: widget.title,
                    company: widget.company,
                    description: widget.description,
                    type: widget.type,
                    location: widget.location,
                    salary: widget.salary,
                    date: widget.date,
                    userType: widget.userType)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              Row(
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.company[0],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple.shade900),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.company,
                        style: TextStyle(
                            color: Colors.purple.shade600, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Text(widget.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.category),
                      Text(widget.type),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.location_on),
                      Text(widget.location),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.date_range),
                      Text(widget.date),
                    ],
                  ),
                  (widget.salary != null)
                      ? Row(
                          spacing: 4,
                          children: [
                            Icon(Icons.money),
                            Text(widget.salary),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
