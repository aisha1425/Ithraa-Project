import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addJob.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/jobs.dart';

class JobPage extends StatefulWidget {
  final id;
  final title;
  final company;
  final description;
  final type;
  final location;
  final salary;
  final date;
  final userType;
  const JobPage(
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
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  void deleteJob(int id) async {
    await deleteJobApi(id);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Jobs(type: 'Local Business')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Job Details"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 20,
            ),
            Text(
              "Description : ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.description),
            SizedBox(
              height: 20,
            ),
            Text(
              "Requirements : ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Bachelor's degree in computer science or related field."),
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 10,
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    (widget.userType == "Local Business")
                        ? ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => AddJob(
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
                            label: Text("Edit"),
                            icon: Icon(Icons.edit),
                          )
                        : ElevatedButton.icon(
                            onPressed: () {},
                            label: Text("Contact"),
                            icon: Icon(Icons.email),
                          ),
                    (widget.userType == "Local Business")
                        ? ElevatedButton.icon(
                            onPressed: () {
                              deleteJob(widget.id);
                            },
                            label: Text("Delete"),
                            icon: Icon(Icons.delete),
                          )
                        : ElevatedButton.icon(
                            onPressed: () {},
                            label: Text("Website"),
                            icon: Icon(Icons.web_sharp),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
