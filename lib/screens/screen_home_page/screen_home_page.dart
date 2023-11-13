import 'package:dawn/api_manager.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:dawn/screens/screen_home_page/screen_description/screen_description.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<ModelStory> stories = [];
  @override
  void initState() {
    super.initState();
    getTribuneNews();
  }

  getTribuneNews() async {
    stories = (await ApiService().getNews("home"));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(
                    """https://scontent.fhdd1-1.fna.fbcdn.net/v/t39.30808-1/352539161_765471741884126_5363766513568198512_n.png?stp=dst-png_p320x320&_nc_cat=103&ccb=1-7&_nc_sid=5f2048&_nc_ohc=Ovgn33Gwl-sAX9vlWY6&_nc_ht=scontent.fhdd1-1.fna&oh=00_AfA32qO3eE_BsGNIzWbGnCwl46d-yJHpslB0cteLZEyUTg&oe=6556DD37"""),
                height: 40,
              ),
              Image(
                image: NetworkImage(
                    "https://i.tribune.com.pk/media/images/logos/tribune-logo.webp"),
                height: 40,
              ),
            ],
          )),
      body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {
                (Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenDescription(stories: stories[index]))))
              },
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          stops: [0.6, 1],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                      image: DecorationImage(
                        opacity: 0.7,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          stories[index].imageURL.toString(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 18,
                    width: 350,
                    child: Text(
                      stories[index].title.toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Text(
                      stories[index].date.toString(),
                      textAlign: TextAlign.right,
                      style: kCardTextColor,
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
          itemCount: stories.length),
    );
  }
}
