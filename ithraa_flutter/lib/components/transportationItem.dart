import 'package:flutter/material.dart';
import 'package:ithraa/backend/backend.dart';
import 'package:ithraa/business/addTransportation.dart';
import 'package:ithraa/models/transport.dart';

class TransportationItem extends StatefulWidget {
  final Widget nextpage;
  final IconData icon;
  final Transport transport;
  final Function loadTransports;
  final String? userType;
  const TransportationItem(
      {super.key,
      required this.transport,
      required this.nextpage,
      required this.icon,
      required this.loadTransports,
      this.userType});

  @override
  State<TransportationItem> createState() => _TransportationItemState();
}

class _TransportationItemState extends State<TransportationItem> {
  void deleteTransport(int id) async {
    await deleteTransportApi(id);
    widget.loadTransports();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => widget.nextpage));
      },
      child: Card(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                spacing: 16,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      widget.icon,
                      color: Colors.purple,
                      size: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple.shade100,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.transport.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.transport.description,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          widget.transport.availability,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.transport.cost,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              (widget.userType != null)
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AddTransport(
                                                transport: widget.transport,
                                              )));
                                },
                                label: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.green)),
                          ),
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {
                                deleteTransport(widget.transport.id!);
                              },
                              label: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
