import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/job.dart';
import 'package:ithraa/models/offer.dart';
import 'package:ithraa/offersAndDiscounts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddOffer extends StatefulWidget {
  final Offer? offer;
  final bool? isUpdate;
  final userType;
  const AddOffer({super.key, this.offer, this.isUpdate, this.userType});

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController linkController = TextEditingController();

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
    if (widget.offer != null) {
      titleController.text = widget.offer!.title;
      descriptionController.text = widget.offer!.description;
      discountController.text = widget.offer!.discount;

      dateController.text = widget.offer!.date;
      linkController.text = widget.offer!.link;
      filePath = widget.offer!.image!;
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
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  String error = '';

  void addOffer(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userEmail = sharedPreferences.getString('email')!;
    String userType = sharedPreferences.getString("type")!;

    Offer offer = Offer(
      id: (widget.isUpdate != null) ? widget.offer!.id : 1,
      title: titleController.text,
      description: descriptionController.text,
      link: linkController.text,
      discount: discountController.text,
      date: dateController.text,
      image: filePath,
      userEmail: userEmail,
    );

    Map res = await addOfferApi(
        offer, imageFile, (widget.isUpdate != null) ? true : false, context);

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
              builder: (BuildContext context) => OffersAndDiscount(
                    type: widget.userType,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBar: AppBar(),
          title: (widget.isUpdate != null) ? "Update Offer" : "Add New Offer"),
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
                      hintText: "Offer Title",
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
                      hintText: "Offer Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: linkController,
                    decoration: InputDecoration(
                      hintText: "Offer Link",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: discountController,
                    decoration: InputDecoration(
                      hintText: "Offer Discount",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                      hintText: "Expiration Date",
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1)),
                    ),
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
                            addOffer(context);
                          },
                          child: Text(
                            (widget.isUpdate != null)
                                ? "Update Offer"
                                : "Add Offer",
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
