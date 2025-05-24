import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Test'),
        actions: [
          Icon(Icons.settings),
        ],
      ),
      body: Container(
        child: Row(
          children: [
            Text("Hello"),
          ],
        ),
      ),
    );
  }
}
