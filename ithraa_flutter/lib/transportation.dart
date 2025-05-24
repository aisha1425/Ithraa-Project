import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addTransportation.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/filterItem.dart';
import 'package:ithraa/components/homeCategoryItem.dart';
import 'package:ithraa/components/transportationItem.dart';
import 'package:ithraa/home.dart';
import 'package:ithraa/models/transport.dart';
import 'package:ithraa/taxiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transportation extends StatefulWidget {
  final String? type;
  const Transportation({super.key, this.type});

  @override
  State<Transportation> createState() => _TransportationState();
}

class _TransportationState extends State<Transportation> {
  List<String> filterTitle = ["Bus", "Taxi", "Microbus", "Private Car"];

  List<Transport> allTransports = [];
  List<Transport> copyTransports = [];

  Map<String, int> originalIndex = {};
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < filterTitle.length; i++) {
      originalIndex[filterTitle[i]] = i;
    }
    loadTransports();
  }

  void loadTransports() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userType = sharedPreferences.getString('type')!;
    String email = sharedPreferences.getString('email')!;
    List<Transport> transports =
        await loadAllTransports((userType == "Local Business") ? email : '');

    print(transports);
    setState(() {
      allTransports = transports;
      copyTransports = transports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Transportation"),
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
                        allTransports = copyTransports;
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

                          List<Transport> temp = [];
                          for (var i = 0; i < allTransports.length; i++) {
                            if (allTransports[i].type == selectedItem ||
                                selectedItem == null) {
                              temp.add(allTransports[i]);
                            }
                          }

                          allTransports = temp;
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: allTransports.length,
              itemBuilder: (BuildContext context, int index) {
                return TransportationItem(
                    transport: allTransports[index],
                    nextpage: TaxiService(transport: allTransports[index]),
                    loadTransports: loadTransports,
                    icon: (allTransports[index].type == "Taxi")
                        ? Icons.taxi_alert
                        : Icons.bus_alert,
                    userType: widget.type);
              },
            ),
          ]),
        ),
      ),
      floatingActionButton:
          (widget.type != null && widget.type == 'Local Business')
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AddTransport()));
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
