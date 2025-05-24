import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/studentGuidePolicyItem.dart';
import 'package:ithraa/models/Policy.dart';

class StudentGuidePolicy extends StatefulWidget {
  const StudentGuidePolicy({super.key});

  @override
  State<StudentGuidePolicy> createState() => _StudentGuidePolicyState();
}

class _StudentGuidePolicyState extends State<StudentGuidePolicy> {
  List<Policy> allPolicies = [];

  @override
  void initState() {
    super.initState();
    loadPolicies();
  }

  void loadPolicies() async {
    List<Policy> policies = await loadAllPolicies();
    print(policies);
    setState(() {
      allPolicies = policies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Policy Guide"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: allPolicies.length,
                itemBuilder: (BuildContext context, int index) {
                  return StudentGuidePolicyItem(
                    title: allPolicies[index].name,
                    data: allPolicies[index].details,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
