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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.stories.title,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              child: Text(
                widget.stories.description,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.stories.content,
                textAlign: TextAlign.justify,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
