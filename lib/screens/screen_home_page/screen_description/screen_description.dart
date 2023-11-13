import 'package:dawn/models/model_story.dart';
import 'package:flutter/material.dart';

class ScreenDescription extends StatefulWidget {
  const ScreenDescription({super.key, required this.stories});
  final ModelStory stories;

  @override
  State<ScreenDescription> createState() => _ScreenDescriptionState();
}

class _ScreenDescriptionState extends State<ScreenDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Image(
                  image: NetworkImage(widget.stories.imageURL.toString())),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                widget.stories.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                widget.stories.description,
                textDirection: TextDirection.ltr,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
