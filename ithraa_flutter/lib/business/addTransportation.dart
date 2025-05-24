import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ithraa/accomondations.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/models/transport.dart';
import 'package:ithraa/transportation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransport extends StatefulWidget {
  final Transport? transport;

  const AddTransport({super.key, this.transport});

  @override
  State<AddTransport> createState() => _AddTransportState();
}

class _AddTransportState extends State<AddTransport> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  TextEditingController distanceController = TextEditingController();

  bool isUpdate = false;
  String? selectedItem = "Bus";
  List<String> allTypes = ['Bus', 'Taxi', 'MicroBus', 'Private Car'];

  @override
  void initState() {
    super.initState();
    if (widget.transport != null) {
      isUpdate = true;
      nameController.text = widget.transport!.name;
      selectedItem = widget.transport!.type!;
      descriptionController.text = widget.transport!.description!;

      costController.text = widget.transport!.cost!;
      availabilityController.text = widget.transport!.availability!;
      distanceController.text = widget.transport!.distance!;
    }
  }

  String error = '';

  void addNewTransport(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userEmail = sharedPreferences.getString('email')!;
    String userType = sharedPreferences.getString("type")!;
    Transport transport = Transport(
      id: (isUpdate) ? widget.transport!.id : null,
      name: nameController.text,
      type: selectedItem!,
      description: descriptionController.text,
      cost: costController.text,
      availability: availabilityController.text,
      distance: distanceController.text,
      userEmail: userEmail,
    );

    Map res = await addTransportApi(transport, isUpdate, context);

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
              builder: (BuildContext context) => Transportation(
                    type: userType,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBar: AppBar(),
          title: (isUpdate) ? "Edit Transport" : "Add Transport"),
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
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
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
                      hintText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: distanceController,
                    decoration: InputDecoration(
                      hintText: "Location",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: costController,
                    decoration: InputDecoration(
                      hintText: "Cost",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField(
                      value: selectedItem,
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
                        selectedItem = value!;
                      }),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: availabilityController,
                    decoration: InputDecoration(
                      hintText: "Availability",
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
                            addNewTransport(context);
                          },
                          child: Text(
                            (isUpdate) ? "Edit Transport" : "Add Transport",
                            style: TextStyle(color: Colors.white),
                          )))
                ]),
                SizedBox(height: 10),
              ]),
        ),
      ),
    );
  }
}
