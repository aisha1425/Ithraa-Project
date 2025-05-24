import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/contactItem.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/contact.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> allContacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  void loadContacts() async {
    List<Contact> contacts = await loadAllContacts();
    setState(() {
      allContacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "Important Contacts",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: allContacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ContactItem(
                      name: allContacts[index].name,
                      phone: allContacts[index].phone,
                      mail: allContacts[index].email);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
