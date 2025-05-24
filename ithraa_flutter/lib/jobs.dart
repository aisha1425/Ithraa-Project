import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addJob.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/filterItem.dart';
import 'package:ithraa/components/jobItem.dart';
import 'package:ithraa/models/job.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jobs extends StatefulWidget {
  final String? type;
  const Jobs({super.key, this.type});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  String searchQuery = "";

  List<String> filterTitle = ["Part Time", "Full Time", "Internship"];

  Map<String, int> originalIndex = {};
  String? selectedItem;
  List<Job> allJobs = [];
  List<Job> copyJobs = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < filterTitle.length; i++) {
      originalIndex[filterTitle[i]] = i;
    }
    loadJobs();
  }

  void loadJobs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userType = sharedPreferences.getString('type')!;
    String email = sharedPreferences.getString('email')!;

    List<Job> jobs =
        await loadAllJobs((userType == "Local Business") ? email : '');
    setState(() {
      allJobs = jobs;
      copyJobs = allJobs;
    });
    print(email);
    print(jobs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Jobs And Opportunity"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              onChanged: (value) {
                allJobs = copyJobs;
                List<Job> temp = [];
                for (var i = 0; i < allJobs.length; i++) {
                  if (allJobs[i].title.toLowerCase().contains(value) ||
                      allJobs[i].description!.toLowerCase().contains(value)) {
                    temp.add(allJobs[i]);
                  }
                }
                setState(() {
                  searchQuery = value;
                  allJobs = temp;
                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  label: Text("Search for Jobs"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterTitle.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          allJobs = copyJobs;
                          if (selectedItem == filterTitle[index]) {
                            filterTitle.sort((a, b) =>
                                originalIndex[a]!.compareTo(originalIndex[b]!));
                            selectedItem = null;
                          } else {
                            selectedItem = filterTitle[index];
                            filterTitle.remove(filterTitle[index]);
                            filterTitle.insert(0, selectedItem!);
                          }

                          List<Job> temp = [];
                          for (var i = 0; i < allJobs.length; i++) {
                            if (allJobs[i].type == selectedItem ||
                                selectedItem == null) {
                              temp.add(allJobs[i]);
                            }
                          }

                          allJobs = temp;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FilterItem(
                            title: filterTitle[index],
                            active: (selectedItem == filterTitle[index])
                                ? true
                                : false),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: allJobs.length,
              itemBuilder: (BuildContext context, int index) {
                return JobItem(
                  id: allJobs[index].id,
                  title: allJobs[index].title,
                  company: allJobs[index].company!,
                  description: allJobs[index].description,
                  type: allJobs[index].type,
                  location: allJobs[index].location,
                  salary: allJobs[index].salary,
                  date: allJobs[index].deadline,
                  userType: widget.type,
                );
              },
            ),
          ]),
        ),
      ),
      floatingActionButton:
          (widget.type != null && widget.type == 'Local Business')
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddJob(userType: widget.type)));
                  },
                  backgroundColor: Colors.blue.shade400,
                  child: const Text(
                    '+',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SizedBox(),
    );
  }
}
