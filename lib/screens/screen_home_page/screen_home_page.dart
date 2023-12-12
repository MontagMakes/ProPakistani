import 'package:dawn/globals/globals.dart';
import 'package:dawn/providers/provider_news.dart';
import 'package:dawn/screens/screen_description/screen_description.dart';
import 'package:dawn/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'button_settings.dart';
import 'card_stories.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Category Variable to store the category name
  int categoryIndex = 0;

  double drawerWidthFactor = 0.77;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NewsProvider>().getNews();    
  }
  

  @override
  Widget build(BuildContext context) {
    var newsProvider = context.watch<NewsProvider>();

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.start,
      //Drawer
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * drawerWidthFactor,
        //ListView to create a list of Categories
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: kColorPrimary,
                ),
                child: Center(
                  child: Text(
                    "ProPakistani",
                    style: GoogleFonts.playfair(
                        fontSize: MediaQuery.of(context).size.width * 0.12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
                
              //Looping over the Category List to create a list of Categories
              for (int i = 0; i < categories.length; i++)
                ListTile(
                  title: Text(
                    categories[i],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                  onTap: (){
                    newsProvider.setCurrentCategory(i);
                    if (mounted) {
                      setState(() {
                        newsProvider.getNews();
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
      ),

      //AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ProPakistani",
          style: GoogleFonts.playfair(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.w700,
              color: Colors.white),
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
              itemCount: newsProvider.getStories().length,

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
                                    ScreenDescription(index: index,),
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
                    child: CardStories(index: index,));
              },
            ),
          ),
        ],
      ),
    );
  }
}
