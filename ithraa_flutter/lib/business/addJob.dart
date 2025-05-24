import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/jobs.dart';
import 'package:ithraa/models/job.dart';
import 'package:ithraa/offersAndDiscounts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddJob extends StatefulWidget {
  final id;
  final title;
  final company;
  final description;
  final type;
  final location;
  final salary;
  final date;
  final userType;

  const AddJob(
      {super.key,
      this.id,
      this.title,
      this.company,
      this.description,
      this.type,
      this.location,
      this.salary,
      this.date,
      this.userType});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  String selectedType = "Full Time";
  String error = '';
  List<String> allTypes = ['Full Time', 'Part Time', 'Internship'];
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.title != null && widget.title != '') {
      isUpdate = true;
      titleController.text = widget.title;
      descriptionController.text = widget.description;
      selectedType = widget.type;
      locationController.text = widget.location;
      salaryController.text = widget.salary;
      deadlineController.text = widget.date;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        deadlineController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void addJob(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userEmail = sharedPreferences.getString('email')!;
    Job job = Job(
      id: (isUpdate) ? widget.id : 1,
      title: titleController.text,
      description: descriptionController.text,
      type: selectedType,
      location: locationController.text,
      salary: salaryController.text,
      deadline: deadlineController.text,
      userEmail: userEmail,
    );

    Map res = await addJobApi(job, isUpdate, context);

    print(res);

    if (res.containsKey("error")) {
      setState(() {
        error = res['message'];
        print(error);
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Jobs(
                    type: widget.userType,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBar: AppBar(), title: (isUpdate) ? "Update Job" : "Add New Job"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Job Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: descriptionController,
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Job Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField(
                      value: selectedType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1)),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: allTypes.map((String item) {
                        return DropdownMenuItem(child: Text(item), value: item);
                      }).toList(),
                      onChanged: (String? value) {
                        selectedType = value!;
                      }),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: "Job Location",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: salaryController,
                    decoration: InputDecoration(
                      hintText: "Salary (Optional)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: deadlineController,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                      hintText: "Application Deadline",
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                if (error.length > 1)
                  SizedBox(
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                Row(children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue.shade400),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            addJob(context);
                          },
                          child: Text(
                            (isUpdate) ? "Update Job" : "Add Job",
                            style: TextStyle(color: Colors.white),
                          )))
                ]),
              ]),
        ),
      ),
    );
  }
}
