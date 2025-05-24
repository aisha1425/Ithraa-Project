import 'package:flutter/material.dart';
import 'package:ithraa/accomondations.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/homeItem.dart';
import 'package:ithraa/jobs.dart';
import 'package:ithraa/offersAndDiscounts.dart';
import 'package:ithraa/transportation.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeLocale extends StatefulWidget {
  const HomeLocale({super.key});

  @override
  State<HomeLocale> createState() => _HomeLocaleState();
}

class _HomeLocaleState extends State<HomeLocale> {
  String profileImage = '';
  String userName = 'local business';
  int jobsCount = 0;
  int accomindationCounts = 0;
  int offersCount = 0;
  int transportsCount = 0;

  String businessType = '';

  @override
  void initState() {
    super.initState();
    loadCounts();
  }

  void loadCounts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String email = sharedPreferences.getString('email')!;

    List res = await loadCountsApi(email);
    if (mounted) {
      setState(() {
        jobsCount = res[0];
        offersCount = res[1];
        accomindationCounts = res[2];
        transportsCount = res[3];
        businessType = sharedPreferences.getString('businessType')!;
      });
    }
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
                          ? Image.network(imageUrl + profileImage)
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
              if (businessType == "Offers Provider")
                HomeItem(
                    title: "Active Job Openings",
                    description: "You have $jobsCount job opening",
                    nextpage: Jobs(
                      type: 'Local Business',
                    ),
                    icon: Icons.business_center_sharp,
                    background: Colors.purple),
              if (businessType == "Offers Provider")
                HomeItem(
                    title: "Active Offers",
                    description: "You have $offersCount offers",
                    nextpage: OffersAndDiscount(
                      type: 'Local Business',
                    ),
                    icon: Icons.local_offer,
                    background: Colors.purple),
              if (businessType == "Accomindation Agent")
                HomeItem(
                    title: "Accomindations",
                    description: "You have $accomindationCounts Accomindation",
                    nextpage: Accomindations(type: 'Local Business'),
                    icon: Icons.home,
                    background: Colors.purple),
              if (businessType == "Transport Agent")
                HomeItem(
                    title: "Transportations",
                    description: "You have $transportsCount transports",
                    nextpage: Transportation(type: 'Local Business'),
                    icon: Icons.directions_bus_filled_rounded,
                    background: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }
}
