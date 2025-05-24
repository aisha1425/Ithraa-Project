import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';

import 'package:ithraa/components/homeCategoryItem.dart';
import 'package:ithraa/components/homeItem.dart';
import 'package:ithraa/contacts.dart';
import 'package:ithraa/home.dart';
import 'package:ithraa/studentGuidePolicy.dart';

class StudentGuide extends StatefulWidget {
  const StudentGuide({super.key});

  @override
  State<StudentGuide> createState() => _StudentGuideState();
}

class _StudentGuideState extends State<StudentGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "Student Guide",
      ),
      body: Container(
        color: Color(0xffF5F5F5),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeCategoryItem(
                title: "University Policies",
                description:
                    "View the important rules and policies of the university",
                nextpage: StudentGuidePolicy(),
                icon: Icons.policy,
              ),
              HomeCategoryItem(
                title: "Important Contacts",
                description: "Get in touch with key university offices",
                nextpage: Contacts(),
                icon: Icons.contact_emergency,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
