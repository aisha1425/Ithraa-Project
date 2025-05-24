import 'package:flutter/material.dart';
import 'package:ithraa/accomondations.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/homeItem.dart';
import 'package:ithraa/jobs.dart';
import 'package:ithraa/localeActivity.dart';
import 'package:ithraa/restaurants.dart';
import 'package:ithraa/studentGuide.dart';
import 'package:ithraa/transportation.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "Guest";
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  void loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString("username")!;
      profileImage = (preferences.getString("image") != null)
          ? preferences.getString("image")!
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Home", back: false),
      body: Container(
        color: Color(0xffF5F5F5),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Card(
                color: const Color.fromRGBO(238, 224, 255, 1),
                // margin: EdgeInsets.all(16),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 16,
                    children: [
                      (profileImage != '')
                          ? Image.network(imageUrl + profileImage, width: 80)
                          : Image.asset(
                              'assets/profileIcon.png',
                              width: 80,
                            ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wellcome Back!",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Hello, " + userName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.waving_hand_outlined,
                        color: Colors.purple.shade800,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              HomeItem(
                  title: "Student Guide",
                  description:
                      "Access University polices , Campus maps , and more",
                  nextpage: StudentGuide(),
                  icon: Icons.menu_book,
                  background: Colors.blue),
              HomeItem(
                  title: "Accomondation",
                  description:
                      "Find the best accomindation options near your campus",
                  nextpage: Accomindations(),
                  icon: Icons.home,
                  background: Colors.green),
              HomeItem(
                  title: "Transportation",
                  description:
                      "Explore transportaion options to get arround easly",
                  nextpage: Transportation(),
                  icon: Icons.directions_bus_filled_sharp,
                  background: Colors.orange),
              HomeItem(
                  title: "Jobs & Oppertunities",
                  description:
                      "Search for intrenships , part-time , or full-time jobs",
                  nextpage: Jobs(),
                  icon: Icons.business_center_sharp,
                  background: Colors.purple),
              // HomeItem(
              //     title: "Local Activities",
              //     description: "Find all local activities naer your location",
              //     nextpage: LocaleActivity(),
              //     icon: Icons.calendar_month,
              //     background: Colors.red),
              // HomeItem(
              //     title: "Restaurants",
              //     description: "Find all Restaurants naer your location",
              //     nextpage: Restaurants(),
              //     icon: Icons.food_bank,
              //     background: Colors.yellow),
            ],
          ),
        ),
      ),
    );
  }
}
