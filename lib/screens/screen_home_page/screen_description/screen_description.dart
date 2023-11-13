import 'package:flutter/material.dart';

class ScreenDescription extends StatefulWidget {
  const ScreenDescription({super.key});

  @override
  State<ScreenDescription> createState() => _ScreenStateDescription();
}

class _ScreenStateDescription extends State<ScreenDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        Column(children: [
          Image(image: NetworkImage("")),
          Text("data")
        ],);
      },),
    );
  }
}
