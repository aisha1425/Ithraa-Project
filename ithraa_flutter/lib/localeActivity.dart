import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/filterItem.dart';
import 'package:ithraa/components/homeCategoryItem.dart';
import 'package:ithraa/components/localeActivityItem.dart';

import 'package:ithraa/home.dart';
import 'package:ithraa/taxiService.dart';

class LocaleActivity extends StatefulWidget {
  const LocaleActivity({super.key});

  @override
  State<LocaleActivity> createState() => _LocaleActivityState();
}

class _LocaleActivityState extends State<LocaleActivity> {
  List<String> filterTitle = ["All", "Culture", "Sports", "Tech"];

  List<String> item1 = [
    "",
    "Universities Sports Day",
    "a fun day of sport competetion and activities",
    "2025-04-01"
  ];

  Map<String, int> originalIndex = {};
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < filterTitle.length; i++) {
      originalIndex[filterTitle[i]] = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "LocaleActivity"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterTitle.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedItem == filterTitle[index]) {
                            filterTitle.sort((a, b) =>
                                originalIndex[a]!.compareTo(originalIndex[b]!));
                            selectedItem = null;
                          } else {
                            selectedItem = filterTitle[index];
                            filterTitle.remove(filterTitle[index]);
                            filterTitle.insert(0, selectedItem!);
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FilterItem(
                            title: filterTitle[index],
                            active: (selectedItem == filterTitle[index])
                                ? true
                                : false),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            LocaleActivityItem(
                image: item1[0],
                title: item1[1],
                description: item1[2],
                date: item1[3]),
          ]),
        ),
      ),
    );
  }
}
