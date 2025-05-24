import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/campusDorms.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/filterItem.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/restaurant.dart';
import 'package:ithraa/utils/urls.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({super.key});

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  String searchQuery = "";

  List<Accomindation> allRestaurants = [];
  List<Accomindation> copyRestaurants = [];

  double rating = 5;
  double distance = 1.0;

  @override
  void initState() {
    super.initState();

    loadRestaurants();
  }

  void loadRestaurants() async {
    //List<Accomindation>? accomindations = await loadAllAccomindation();

    //print(accomindations);
    // setState(() {
    //   allAccomindations = accomindations!;
    //   copyAccomindations = accomindations;
    // });
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
                  // allRestaurants = copyRestaurants;
                  // List<Accomindation> temp = [];
                  // for (var i = 0; i < allAccomindations.length; i++) {
                  //   if (allAccomindations[i]
                  //           .name
                  //           .toLowerCase()
                  //           .contains(value) ||
                  //       allAccomindations[i]
                  //           .description!
                  //           .toLowerCase()
                  //           .contains(value)) {
                  //     temp.add(allAccomindations[i]);
                  //   }
                  // }
                  // setState(() {
                  //   searchQuery = value;
                  //   allAccomindations = temp;
                  // });
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text("Search for Restaurants"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Filter by Rating (Max : " +
                  rating.toInt().toString() +
                  " )"),
              Slider(
                label: "Select Price",
                min: 0,
                max: 5,
                value: rating,
                onChanged: (value) {
                  // allAccomindations = copyAccomindations;
                  // List<Accomindation> temp = [];

                  // for (var i = 0; i < allAccomindations.length; i++) {
                  //   if (double.parse(allAccomindations[i].price!) < value) {
                  //     temp.add(allAccomindations[i]);
                  //   }
                  // }
                  // print(temp.length);
                  // setState(() {
                  //   allAccomindations = temp;
                  //   price = value;
                  // });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text("Filter by Distance (Max : " +
                  distance.toInt().toString() +
                  " K.M )"),
              Slider(
                label: "Select Distance",
                min: 0,
                max: 100,
                value: distance,
                onChanged: (value) {
                  // allAccomindations = copyAccomindations;
                  // List<Accomindation> temp = [];
                  // for (var i = 0; i < allAccomindations.length; i++) {
                  //   if (double.parse(allAccomindations[i].distance!) < value) {
                  //     print("aded");
                  //     temp.add(allAccomindations[i]);
                  //   }
                  // }
                  // print(temp.length);
                  // setState(() {
                  //   allAccomindations = temp;
                  //   distance = value;
                  // });
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    (allRestaurants != null) ? allRestaurants?.length : 0,
                itemBuilder: (context, index) {
                  Accomindation data = allRestaurants![index];
                  return (allRestaurants != null)
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Restaurant(restaurant: data)));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child:
                                        Image.network(imageUrl + data.image!)),
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
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Text(data.description!),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Text("4.0"),
                                            ],
                                          ),
                                          Text("2.5 KM"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
    );
  }
}
