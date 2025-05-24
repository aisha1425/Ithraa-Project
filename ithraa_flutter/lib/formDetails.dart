import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';

class Formdetails extends StatefulWidget {
  const Formdetails({super.key});

  @override
  State<Formdetails> createState() => _FormdetailsState();
}

class _FormdetailsState extends State<Formdetails> {
  bool hasImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Form Details"),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                (hasImage == true)
                    ? Image.network(
                        '',
                        height: 50,
                      )
                    : Image.asset(
                        'assets/ithraa.png',
                        height: 50,
                      ),
                Text("Mohammed Ahmed"),
              ],
            ),
            Text(
              "How to study Effectivly? ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text("replies : "),
            Row(
              children: [
                (hasImage == true)
                    ? Image.network(
                        '',
                        height: 30,
                      )
                    : Image.asset(
                        'assets/ithraa.png',
                        height: 30,
                      ),
                Column(
                  children: [
                    Text(
                      "User Name",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Reply")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
