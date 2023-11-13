import 'package:dawn/models/model_story.dart';
import 'package:flutter/material.dart';

class ScreenDescription extends StatefulWidget {
  const ScreenDescription({super.key, required this.stories});
  final List<ModelStory> stories;

  @override
  State<ScreenDescription> createState() => _ScreenDescriptionState();
}

class _ScreenDescriptionState extends State<ScreenDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.red),
        body: ListView.builder(
          itemBuilder: (context, index) => Stack(children: [
            // Image(image: NetworkImage(widget.stories[index].imageURL.toString()))
          ]),
        ));
  }
}
