import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ithraa/accomondations.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/models/job.dart';
import 'package:ithraa/models/offer.dart';
import 'package:ithraa/offersAndDiscounts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAccomindation extends StatefulWidget {
  final Accomindation? accomindation;

  const AddAccomindation({super.key, this.accomindation});

  @override
  State<AddAccomindation> createState() => _AddAccomindationState();
}

class _AddAccomindationState extends State<AddAccomindation> {
  TextEditingController nameController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController callController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController kitchenController = TextEditingController();
  TextEditingController laundaryController = TextEditingController();
  TextEditingController parkingController = TextEditingController();
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController internetController = TextEditingController();

  String selectedDistance = "العقيق";

  bool? parkingValue = false;
  bool? kitchenValue = false;
  bool? laundaryValue = false;
  bool? internetValue = false;

  bool isUpdate = false;

  List<String> allDistances = ['العقيق', 'بهر', 'شهبه'];

  File? imageFile;
  String? filePath;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        imageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.accomindation != null) {
      isUpdate = true;
      nameController.text = widget.accomindation!.name;
      //typeController.text = widget.accomindation!.type!;

      descriptionController.text = widget.accomindation!.description!;

      callController.text = widget.accomindation!.call!;
      priceController.text = widget.accomindation!.price!;
      selectedDistance = widget.accomindation!.distance!;

      if (widget.accomindation!.kitchen! == "Available") {
        kitchenValue = true;
      }
      //kitchenController.text = widget.accomindation!.kitchen!;
      if (widget.accomindation!.laundary! == "Available") {
        laundaryValue = true;
      }
      //laundaryController.text = widget.accomindation!.laundary!;
      if (widget.accomindation!.parking! == "Available") {
        parkingValue = true;
      }
      //parkingController.text = widget.accomindation!.parking!;

      bedroomsController.text = widget.accomindation!.bedrooms!;
      bathroomsController.text = widget.accomindation!.bathrooms!;
      if (widget.accomindation!.internet! == "Available") {
        internetValue = true;
      }
      //internetController.text = widget.accomindation!.internet!;
      if (widget.accomindation!.image != null)
        filePath = widget.accomindation!.image;
    }
  }

  String error = '';

  void addNewAccomindaion(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userEmail = sharedPreferences.getString('email')!;
    String userType = sharedPreferences.getString("type")!;
    Accomindation acc = Accomindation(
      id: (isUpdate) ? widget.accomindation!.id : 1,
      name: nameController.text,
      description: descriptionController.text,
      call: callController.text,
      price: priceController.text,
      distance: selectedDistance,
      kitchen: (kitchenValue!) ? 'Available' : 'Not Available',
      laundary: (laundaryValue!) ? 'Available' : 'Not Available',
      parking: (parkingValue!) ? 'Available' : 'Not Available',
      bedrooms: bedroomsController.text,
      bathrooms: bathroomsController.text,
      internet: (internetValue!) ? 'Available' : 'Not Available',
      image: filePath,
      userEmail: userEmail,
    );

    Map res = await addAccomindationApi(acc, imageFile, isUpdate, context);

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
              builder: (BuildContext context) => Accomindations(
                    type: userType,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBar: AppBar(),
          title: (isUpdate) ? "Edit Accomindation" : "Add Accomindation"),
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
                    controller: locationController,
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
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: "Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField(
                      value: selectedDistance,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1)),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: allDistances.map((String item) {
                        return DropdownMenuItem(child: Text(item), value: item);
                      }).toList(),
                      onChanged: (String? value) {
                        selectedDistance = value!;
                      }),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: bedroomsController,
                    decoration: InputDecoration(
                      hintText: "Bed rooms",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: bathroomsController,
                    decoration: InputDecoration(
                      hintText: "Bath rooms",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: callController,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              tristate: true,
                              value: kitchenValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  kitchenValue = newValue;
                                });
                              },
                            ),
                            Text('Kitchen'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              tristate: true,
                              value: parkingValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  parkingValue = newValue;
                                });
                              },
                            ),
                            Text('Parking'),
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            tristate: true,
                            value: laundaryValue,
                            onChanged: (bool? newValue) {
                              setState(() {
                                laundaryValue = newValue;
                              });
                            },
                          ),
                          Text('Laundary'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            tristate: true,
                            value: internetValue,
                            onChanged: (bool? newValue) {
                              setState(() {
                                internetValue = newValue;
                              });
                            },
                          ),
                          Text('Internet'),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: pickFile,
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.upload),
                      Text("Upload Image"),
                    ],
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
                            addNewAccomindaion(context);
                          },
                          child: Text(
                            (isUpdate)
                                ? "Edit Accomindation"
                                : "Add Accomindation",
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
