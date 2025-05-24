import 'package:flutter/material.dart';
import 'package:ithraa/components/customAppBar.dart';

import 'package:ithraa/components/homeCategoryItem.dart';
import 'package:ithraa/contacts.dart';
import 'package:ithraa/formDetails.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  // String username = 'Mohammed Ahmed';
  // String title = 'how to study effectevly ?';

  // bool hasImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "Forms",
        back: false,
      ),
      body: Center(
        // color: Color(0xffF5F5F5),
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text("Comming Soon"),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         Row(
        //           children: [
        //             (hasImage == true)
        //                 ? Image.network(
        //                     '',
        //                     height: 50,
        //                   )
        //                 : Image.asset(
        //                     'assets/ithraa.png',
        //                     height: 50,
        //                   ),
        //             Expanded(
        //               child: TextFormField(
        //                 minLines: 3,
        //                 maxLines: 3,
        //                 decoration:
        //                     InputDecoration(hintText: "What is in your mind?"),
        //               ),
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         InkWell(
        //           onTap: () {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //         builder: (BuildContext context) => Formdetails()));
        //           },
        //           child: Card(
        //             color: Colors.white,
        //             child: Container(
        //               margin: EdgeInsets.all(16),
        //               child: Row(
        //                 spacing: 16,
        //                 children: [
        //                   Container(
        //                     padding: EdgeInsets.all(10),
        //                     child: (hasImage == true)
        //                         ? Image.network(
        //                             '',
        //                             height: 50,
        //                           )
        //                         : Image.asset(
        //                             'assets/ithraa.png',
        //                             height: 50,
        //                           ),
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(100),
        //                       color: Colors.purple.shade50,
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           username,
        //                           style: TextStyle(fontSize: 12),
        //                         ),
        //                         Text(
        //                           title,
        //                           style: TextStyle(
        //                               fontSize: 16, fontWeight: FontWeight.bold),
        //                         ),
        //                         Text("3 replies"),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
      ),
    );
  }
}
