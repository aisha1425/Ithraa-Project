import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addOffer.dart';
import 'package:ithraa/models/offer.dart';
import 'package:ithraa/offersAndDiscounts.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersAndDiscountItem extends StatefulWidget {
  final Offer offer;
  final type;
  final Function loadOffers;
  const OffersAndDiscountItem(
      {super.key,
      required this.offer,
      required this.type,
      required this.loadOffers});

  @override
  State<OffersAndDiscountItem> createState() => _OffersAndDiscountItemState();
}

class _OffersAndDiscountItemState extends State<OffersAndDiscountItem> {
  void deleteOffer(int id) async {
    await deleteOfferApi(id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (widget.offer.image != '')
                  ? Image.network(
                      imageUrl + widget.offer.image!,
                      height: 150,
                    )
                  : Image.asset(
                      'assets/ithraa.png',
                      height: 150,
                    )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.offer.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Text(widget.offer.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.offer.discount),
                    Text("Expires At " + widget.offer.date),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    if (widget.type != null && widget.type == "Local Business")
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => AddOffer(
                                          offer: widget.offer,
                                          userType: widget.type,
                                          isUpdate: true,
                                        )));
                          },
                          child: Text("Edit")),
                    ElevatedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(widget.offer.link));
                        },
                        child: Text("Visit Offer")),
                    if (widget.type != null && widget.type == "Local Business")
                      ElevatedButton(
                          onPressed: () {
                            deleteOffer(widget.offer.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OffersAndDiscount(
                                            type: 'Local Business')));
                          },
                          child: Text("Delete")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
