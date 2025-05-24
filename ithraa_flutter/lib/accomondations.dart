import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addAccomindation.dart';
import 'package:ithraa/campusDorms.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/filterItem.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accomindations extends StatefulWidget {
  final String? type;
  const Accomindations({super.key, this.type});

  @override
  State<Accomindations> createState() => _AccomindationsState();
}

class _AccomindationsState extends State<Accomindations> {
  String searchQuery = "";

  List<Accomindation> allAccomindations = [];
  List<Accomindation> copyAccomindations = [];

  double price = 100.0;
  String distance = 'الكل';

  List<String> universityLocations = ['الكل', 'العقيق', 'بهر', 'شهبه'];

  Map<String, int> originalIndex = {};
  String? selectedItem;

  @override
  void initState() {
    super.initState();

    loadAccomindation();
  }

  void loadAccomindation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userType = sharedPreferences.getString('type')!;
    String email = sharedPreferences.getString('email')!;
    List<Accomindation>? accomindations =
        await loadAllAccomindation((userType == "Local Business") ? email : '');

    print(accomindations);
    setState(() {
      allAccomindations = accomindations!;
      copyAccomindations = accomindations;
    });
  }

  void deleteAccomindation(int id) async {
    await deleteAccomindationApi(id);
    loadAccomindation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Accomindation"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  allAccomindations = copyAccomindations;
                  List<Accomindation> temp = [];
                  for (var i = 0; i < allAccomindations.length; i++) {
                    if (allAccomindations[i]
                            .name
                            .toLowerCase()
                            .contains(value) ||
                        allAccomindations[i]
                            .description!
                            .toLowerCase()
                            .contains(value)) {
                      temp.add(allAccomindations[i]);
                    }
                  }
                  setState(() {
                    searchQuery = value;
                    allAccomindations = temp;
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text("Search for accomindations"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Filter by price (Max : " + price.toInt().toString() + " )"),
              Slider(
                label: "Select Price",
                min: 0,
                max: 100,
                value: price,
                onChanged: (value) {
                  allAccomindations = copyAccomindations;
                  List<Accomindation> temp = [];

                  for (var i = 0; i < allAccomindations.length; i++) {
                    if (double.parse(allAccomindations[i].price!) < value) {
                      temp.add(allAccomindations[i]);
                    }
                  }
                  print(temp.length);
                  setState(() {
                    allAccomindations = temp;
                    price = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter by Distance :"),
                  SizedBox(
                    child: DropdownButton(
                        value: distance,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: universityLocations.map((String item) {
                          return DropdownMenuItem(
                              child: Text(item), value: item);
                        }).toList(),
                        onChanged: (String? value) {
                          // selectedUniversityLocation = value!;

                          allAccomindations = copyAccomindations;
                          List<Accomindation> temp = [];
                          for (var i = 0; i < allAccomindations.length; i++) {
                            if (allAccomindations[i].distance! == value ||
                                value == "الكل") {
                              print("aded");
                              temp.add(allAccomindations[i]);
                            }
                          }
                          print(temp.length);
                          setState(() {
                            allAccomindations = temp;
                            distance = value!;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    (allAccomindations != null) ? allAccomindations?.length : 0,
                itemBuilder: (context, index) {
                  Accomindation data = allAccomindations![index];
                  return (allAccomindations != null)
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CampusDorms(accomindation: data)));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  height:200,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: (data.image != null &&
                                              data.image != '')
                                          ? Image.network(imageUrl + data.image! , fit: BoxFit.fill,)
                                          : Image.asset("assets/ithraa.png")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    spacing: 4,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            data.price! + "\$/mounth ",
                                            style: TextStyle(
                                                color: Colors.deepPurple,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Text("Closest University " +
                                          data.distance!),
                                      Text(data.description!),
                                    ],
                                  ),
                                ),
                                (widget.type != null)
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing: 10,
                                          children: [
                                            Expanded(
                                              child: TextButton.icon(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AddAccomindation(
                                                                  accomindation:
                                                                      data,
                                                                )));
                                                  },
                                                  label: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.green)),
                                            ),
                                            Expanded(
                                              child: TextButton.icon(
                                                onPressed: () {
                                                  deleteAccomindation(data.id);
                                                },
                                                label: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (widget.type != null &&
              widget.type == 'Local Business')
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddAccomindation()));
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
