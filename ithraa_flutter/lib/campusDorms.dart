import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/accomindation.dart';
import 'package:ithraa/utils/urls.dart';

class CampusDorms extends StatefulWidget {
  final Accomindation accomindation;
  const CampusDorms({super.key, required this.accomindation});

  @override
  State<CampusDorms> createState() => _CampusDormsState();
}

class _CampusDormsState extends State<CampusDorms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Campus Dormitory"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: (widget.accomindation.image != '')
                        ? Image.network(imageUrl + widget.accomindation.image!)
                        : Image.asset("assets/ithraa.png")),
              ),
              Text(
                widget.accomindation.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Price: ${widget.accomindation.price}/month \$"),
              Text(
                  "Closes University Campus: ${widget.accomindation.distance} "),
              Text(
                "Features : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                spacing: 20,
                children: [
                  Icon(
                    Icons.local_laundry_service_sharp,
                    color: Colors.blue,
                  ),
                  Text("Laundary Service ${widget.accomindation.laundary}"),
                ],
              ),
              Row(
                spacing: 20,
                children: [
                  Icon(
                    Icons.local_parking,
                    color: Colors.orange,
                  ),
                  Text("Parking ${widget.accomindation.parking}"),
                ],
              ),
              Text(
                "Other Services : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                spacing: 20,
                children: [
                  Icon(
                    Icons.bedroom_parent_sharp,
                    color: Colors.purple,
                  ),
                  Text("${widget.accomindation.bedrooms} Bedrooms"),
                ],
              ),
              Row(
                spacing: 20,
                children: [
                  Icon(
                    Icons.bathroom,
                    color: Colors.grey,
                  ),
                  Text("${widget.accomindation.bathrooms} Bathrooms"),
                ],
              ),
              Row(
                spacing: 20,
                children: [
                  Icon(
                    Icons.wifi,
                    color: Colors.red,
                  ),
                  Text("Internet ${widget.accomindation.internet}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text("Call"),
                    icon: Icon(Icons.call),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text("WhatsApp"),
                    icon: Icon(Icons.message),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
