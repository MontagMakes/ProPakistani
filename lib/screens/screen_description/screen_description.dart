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
      appBar: AppBar(),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0),
              child: Text(
                widget.stories.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                widget.stories.content,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
