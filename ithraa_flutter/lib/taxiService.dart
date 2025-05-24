import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';
import 'package:ithraa/models/transport.dart';

class TaxiService extends StatefulWidget {
  final Transport transport;
  const TaxiService({super.key, required this.transport});

  @override
  State<TaxiService> createState() => _TaxiServiceState();
}

class _TaxiServiceState extends State<TaxiService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBar: AppBar(), title: "${widget.transport.type} Service"),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.purple.shade100,
              ),
              child: Icon(
                (widget.transport.type == "Taxi")
                    ? Icons.local_taxi
                    : Icons.bus_alert,
                color: Colors.purple,
                size: 30,
              ),
            ),
            Text(
              "City ${widget.transport.type} Service",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.transport.description),
            Row(
              children: [
                Icon(
                  Icons.category,
                  color: Colors.blue,
                ),
                Text("Type : ${widget.transport.type}"),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),
                Text("Cost : ${widget.transport.cost} SAR"),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.orange,
                ),
                Text("Availability : ${widget.transport.availability}"),
              ],
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.call),
                label: Text("Call service")),
          ],
        ),
      ),
    );
  }
}
