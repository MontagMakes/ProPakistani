import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dawn/api_manager.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:dawn/screens/screen_description/screen_description.dart';
import 'package:dawn/screens/screen_settings/screen_settings.dart';
import 'package:dawn/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int categoryIndex = 0;
  List<ModelStory> stories = [];
  final ScrollController _controller = ScrollController();

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
    print(Theme.of(context).textTheme.displayMedium!.fontSize);
    final isDarkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.start,
      drawer: Drawer(
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Center(
              child: Stack(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Positioned(
                  child: Text(
                    "TRIBUNE",
                    style: GoogleFonts.playfair(
                        fontSize: MediaQuery.of(context).size.width * 0.15,
                        fontWeight: FontWeight.normal,
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 7,
                  child: Text(
                    "THE EXPRESS",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                        color: isDarkMode
                            ? Colors.red
                            : Colors.redAccent.shade700),
                  ),
                )
              ]),
            ),

            // SizedBox(
            //   height: 75,
            //   child: RichText(
            //     softWrap: false,
            //     text: TextSpan(children: [
            //       //Title: Tribune
            //       WidgetSpan(
            //         child: Transform(
            //           transform: Matrix4.translationValues(
            //               MediaQuery.sizeOf(context).width * 0.08, 0, 0),
            //           child: Text(
            //             "TRIBUNE",
            //             style: GoogleFonts.playfair(
            //                 fontSize:Theme.of(context).textTheme.displayLarge!.fontSize,
            //                 color: isDarkMode ? Colors.white : Colors.black),
            //           ),
            //         ),
            //       ),

            //       //Title: The Express
            //       WidgetSpan(
            //         child: Transform(
            //           transform: Matrix4.translationValues(
            //               -MediaQuery.sizeOf(context).width * 0.15,
            //               -MediaQuery.sizeOf(context).height * 0.082,
            //               0),
            //           child: Text(
            //             "THE EXPRESS",
            //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //               fontStyle: FontStyle.italic,
            //               color: isDarkMode ? Colors.red : Colors.redAccent.shade700
            //             ),
            //           ),
            //         ),
            //       )
            //     ]),
            //   ),
            // ),
            for (int i = 0; i < categories.length; i++)
              listTile(context, categories[i], i),
          ],
        ),
      ),

      //AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.53,
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Positioned(
            child: Text(
              "TRIBUNE",
              style: GoogleFonts.playfair(
                  fontSize: MediaQuery.of(context).size.width * 0.135,
                  fontWeight: FontWeight.normal,
                  color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          Positioned(
            top: 3,
            right: 3,
            child: Text(
              "THE EXPRESS",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: isDarkMode ? Colors.red : Colors.redAccent.shade700),
            ),
          )
        ]),
        actions: [
          //Settings Button
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ScreenSetting(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              SlideTransition(
                        position: animation.drive(Tween(
                                begin: const Offset(1.0, 0.0), end: Offset.zero)
                            .chain(CurveTween(curve: Curves.decelerate))),
                        child: child,
                      ),
                    ));
              },
              icon: const Icon(Icons.settings)),
        ],
      ),

      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                categories[categoryIndex],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: _controller,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      (Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ScreenDescription(stories: stories[index]),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                SlideTransition(
                              position: animation.drive(
                                Tween(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero)
                                    .chain(
                                        CurveTween(curve: Curves.decelerate)),
                              ),
                              child: child,
                            ),
                          )))
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
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
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(1),
                                Colors.transparent
                              ],
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045),
                          ),
                        ),

                        // CardDate
                        Positioned(
                          bottom: 18,
                          right: 15,
                          child: Text(
                            stories[index].date.toString(),
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                          ),
                        ),

                        // CardCreator
                        Positioned(
                          bottom: -4,
                          left: 3,
                          child: Text(
                            stories[index].creator,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
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

  ListTile listTile(BuildContext context, String categoryName, int index) {
    return ListTile(
      title: Text(
        categoryName,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () async {
        if (categoryName == "K-P") {
          categoryName = "khyber-pakhtunkhwa";
        } else if (categoryName == "Jammu & Kashmir") {
          categoryName = "jammu-kashmir";
        } else if (categoryName == "Gilgit Baltistan") {
          categoryName = "gilgit-baltistan";
        }

        stories = (await ApiService().getNews(categoryName.toLowerCase()));
        if (mounted) {
          setState(() {
            Navigator.pop(context);
            categoryIndex = index;
            scrollToTopInstantly(_controller);
          });
        }
      },
    );
  }
}
