import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/utils/urls.dart';

class Restaurant extends StatefulWidget {
  final restaurant;
  const Restaurant({super.key, required this.restaurant});

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Restaurant Name"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl + widget.restaurant.image!)),
              Text(
                widget.restaurant.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(widget.restaurant.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(
                "Meals Offered",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Card(
                child: Row(
                  children: [
                    Image.network(""),
                    Text("chicken"),
                    Text("25 SAR"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
