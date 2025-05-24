import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addOffer.dart';

import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/components/filterItem.dart';
import 'package:ithraa/components/offersAndDiscountItem.dart';
import 'package:ithraa/models/offer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OffersAndDiscount extends StatefulWidget {
  final String? type;
  const OffersAndDiscount({super.key, this.type});

  @override
  State<OffersAndDiscount> createState() => _OffersAndDiscountState();
}

class _OffersAndDiscountState extends State<OffersAndDiscount> {
  List<String> filterTitle = ["All", "Electronic", "Shopping", "Food"];

  List<Offer> allOffers = [];
  List<Offer> copyOffers = [];

  Map<String, int> originalIndex = {};
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < filterTitle.length; i++) {
      originalIndex[filterTitle[i]] = i;
    }
    loadOffers();
  }

  void loadOffers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userType = sharedPreferences.getString('type')!;
    String email = sharedPreferences.getString('email')!;

    List<Offer> offers =
        await loadAllOffers((userType == "Local Business") ? email : '');
    setState(() {
      allOffers = offers;
      copyOffers = allOffers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Offers And Discount"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: allOffers.length,
              itemBuilder: (BuildContext context, int index) {
                return OffersAndDiscountItem(
                    offer: allOffers[index],
                    type: widget.type,
                    loadOffers: loadOffers);
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
                            builder: (BuildContext context) =>
                                AddOffer(userType: widget.type)));
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
