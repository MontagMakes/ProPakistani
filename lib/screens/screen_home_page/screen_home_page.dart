import 'package:dawn/api_manager.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:dawn/screens/screen_description/screen_description.dart';
import 'package:dawn/utils/utils.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ModelStory> stories = [];

  int categoryIndex = 0;

  bool isDarkModeEnabled = false;
  @override
  void initState() {
    super.initState();
    getTribuneNews();
  }

   void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }

  getTribuneNews() async {
    stories = (await ApiService().getNews("home"));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //Drawer
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Image.network(
                    "https://i.tribune.com.pk/media/images/logos/tribune-logo.webp"
                )
            ),
            
            //Home category
            ListTile(
              title: const Text('Home'),
              onTap: () async{
                stories = (await ApiService().getNews("home"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 0;  
                  });
                  
                }
              },
            ),

            //Business category
            ListTile(
              title: const Text('Business'),
              onTap: () async{
                stories = (await ApiService().getNews("business"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 1;  
                  }); 
                }
              },
            ),

            //World category
            ListTile(
              title: const Text('World'),
              onTap: () async{
                stories = (await ApiService().getNews("world"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 2;  
                  });
                  
                }
              },
            ),

            //Sports category
            ListTile(
              title: const Text('Sports'),
              onTap: () async{
                stories = (await ApiService().getNews("sports"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 3;  
                  });
                  
                }
              },
            ),

            //Opinion category
            ListTile(
              title: const Text('Opinion'),
              onTap: () async{
                stories = (await ApiService().getNews("opinion"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 4;  
                  });
                  
                }
              },
            ),

            //TV category
            ListTile(
              title: const Text('TV'),
              onTap: () async{
                stories = (await ApiService().getNews("tv"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 5;  
                  });
                  
                }
              },
            ),

            //Latest Category
            ListTile(
              title: const Text('Latest'),
              onTap: () async{
                stories = (await ApiService().getNews("latest"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 6;  
                  });
                  
                }
              },
            ),

            //Analysis Category
            ListTile(
              title: const Text('Analysis'),
              onTap: () async{
                stories = (await ApiService().getNews("analysis"));
                if(mounted){
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 7;  
                  });
                }
              },
            ),
          ],
        ),
      ),
      
      appBar: AppBar(
        
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.15),
                child: const Image(
                  image: NetworkImage(
                      "https://i.tribune.com.pk/media/images/logos/tribune-logo.webp"),
                  height: 40,
                ),
              ),
            ],
          )),
      body: Column(
        children: [
          Center(child: Text(categories[categoryIndex], style: TextStyle(fontSize: 20),),),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      (Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScreenDescription(stories: stories[index]))))
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
          ),
        ],
      ),
    );
  }
}
