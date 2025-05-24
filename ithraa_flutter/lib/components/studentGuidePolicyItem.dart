import 'package:flutter/material.dart';
import 'package:ithraa/utils/urls.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentGuidePolicyItem extends StatefulWidget {
  final title;
  final String data;
  const StudentGuidePolicyItem(
      {super.key, required this.title, required this.data});

  @override
  State<StudentGuidePolicyItem> createState() => _StudentGuidePolicyItemState();
}

class _StudentGuidePolicyItemState extends State<StudentGuidePolicyItem> {
  bool academicPolicyVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        academicPolicyVisible = !academicPolicyVisible;
                      });
                    },
                    child: Icon((academicPolicyVisible)
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down)),
              ],
            ),
            if (academicPolicyVisible)
              Column(
                children: [
                  if (widget.data != "")
                    Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () async {
                            final url = Uri.parse(imageUrl + widget.data);
                            await launchUrl(url , mode: LaunchMode.externalApplication);
                            print(imageUrl + widget.data);
                          },
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(
                                Icons.file_download_sharp,
                                color: Colors.green,
                              ),
                              Expanded(
                                child: Text(
                                  "Policy File",
                                ),
                              )
                            ],
                          ),
                        ),
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
