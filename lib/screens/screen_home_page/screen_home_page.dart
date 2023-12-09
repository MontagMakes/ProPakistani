// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dawn/api_manager.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:dawn/screens/screen_description/screen_description.dart';
import 'package:dawn/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'button_settings.dart';
import 'card_stories.dart';
import 'title_header_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Category Variable to store the category name
  int categoryIndex = 0;

  // Empty List of stories to fill with data from API
  List<ModelStory> stories = [];

  double drawerWidthFactor = 0.77;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getTribuneNews();
  }

  // Function to get the News from API and put it in the Empty list
  getTribuneNews() async {
    stories = (await ApiService().getNews("home"));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.start,

      //Drawer
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * drawerWidthFactor,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            TitleDrawer(isDarkMode: isDarkMode),

            //Looping over the Category List to create a list of Categories
            for (int i = 0; i < categories.length; i++)
              ListTile(
                title: Text(
                  categories[i],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
                onTap: () async {
                  if (categories[i] == "K-P") {
                    categories[i] = "khyber-pakhtunkhwa";
                  } else if (categories[i] == "Jammu & Kashmir") {
                    categories[i] = "jammu-kashmir";
                  } else if (categories[i] == "Gilgit Baltistan") {
                    categories[i] = "gilgit-baltistan";
                  }

                  stories =
                      (await ApiService().getNews(categories[i].toLowerCase()));
                  if (mounted) {
                    setState(() {
                      Navigator.pop(context);
                      categoryIndex = i;
                      scrollToTopInstantly(_controller);
                    });
                  }
                },
              ),
          ],
        ),
      ),

      //AppBar
      appBar: AppBar(
        centerTitle: true,

        //Using Stack and positioning to put "THE EXPRESS" on the top left of "TRIBUNE"
        title: Stack(
          children: [

            //Position and size of "TRIBUNE"
            Positioned(
              child: Text(
                "TRIBUNE",
                style: GoogleFonts.playfair(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  fontWeight: FontWeight.normal,
                  color:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),

            //Position and size of "THE EXPRESS"
            Positioned(
              top: 1,
              right: 5,
              child: Text(
                "THE EXPRESS",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    color: Colors.redAccent.shade700),
              ),
            )
          ],
        ),

        //Settings Button
        actions: const [
          ButtonSettings(),
        ],
      ),

      body: Column(
        children: [
          //Category
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                categories[categoryIndex],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
          ),

          //Store the list of stories in a ListView
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _controller,
              shrinkWrap: true,
              itemCount: stories.length,

              //Gap between the cards
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),

              itemBuilder: (context, index) {
                return GestureDetector(

                    //Ontap to navigate to the description screen
                    onTap: () => {
                          (Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    ScreenDescription(stories: stories[index]),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    SlideTransition(
                                  position: animation.drive(
                                    Tween(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero)
                                        .chain(CurveTween(
                                            curve: Curves.decelerate)),
                                  ),
                                  child: child,
                                ),
                              )))
                        },

                    //Card
                    child: CardStories(stories: stories, index: index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
