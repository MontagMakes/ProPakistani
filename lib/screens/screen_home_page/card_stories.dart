import 'package:flutter/material.dart';

import '../../models/model_story.dart';

class CardStories extends StatefulWidget {
  final List<ModelStory> stories;
  final int index;
  const CardStories({
    super.key,
    required this.stories,
    required this.index,
  });

  @override
  State<CardStories> createState() => _CardStoriesState();
}

class _CardStoriesState extends State<CardStories> {
  @override
  Widget build(BuildContext context) {
    List<ModelStory> stories = widget.stories;
    int index = widget.index;

    return Stack(
      children: [
        //CardImage
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                stories[index].imageURL.toString(),
              ),
            ),
          ),
        ),

        //CardGradient
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(1), Colors.transparent],
            ),
          ),
        ),

        //CardTitle
        Positioned(
          bottom: 50,
          left: 18,
          width: MediaQuery.sizeOf(context).width * 0.91,
          child: Text(
            stories[index].title.toString(),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.045),
          ),
        ),

        // CardDate
        Positioned(
          bottom: 18,
          right: 15,
          child: Text(
            stories[index].date.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.03
            )
          ),
        ),

      ],
    );
  }
}
