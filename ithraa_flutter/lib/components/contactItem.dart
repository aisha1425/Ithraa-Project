import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactItem extends StatefulWidget {
  final name;
  final phone;
  final mail;
  const ContactItem(
      {super.key, required this.name, required this.phone, required this.mail});

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 16,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.contact_phone,
                    color: Colors.purple,
                    size: 30,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.purple.shade100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "phone : " + widget.phone,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "email : " + widget.mail,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                InkWell(
                  onTap: () async {
                    final url = Uri.parse('tel:' + widget.phone);
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                  child: Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final url = Uri.parse("mailto:" + widget.mail);
                    if (await canLaunchUrl(url)) await launchUrl(url);
                  },
                  child: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
