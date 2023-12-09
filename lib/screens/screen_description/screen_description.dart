import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'back_button_fab.dart';

class ScreenDescription extends StatefulWidget {
  const ScreenDescription({super.key, required this.stories});
  final ModelStory stories;

  @override
  State<ScreenDescription> createState() => _ScreenDescriptionState();
}

class _ScreenDescriptionState extends State<ScreenDescription> {

  final ScrollController _scrollController = ScrollController();
  double? contentFontSize = 16.0;
  bool isDrawerOpen = false;
  bool _dialVisible = true;

  @override
  void initState() {
    super.initState();
    getFontSize();
    _scrollController.addListener(() {
      setState(() {
        _dialVisible = _scrollController.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  //Get font size from shared preferences
  void getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    contentFontSize = prefs.getDouble("contentFontSize") ?? 16.0;
    setState(() {});
  }

  //Set font size to shared preferences
  void setFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("contentFontSize", contentFontSize!);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton:
        AnimatedOpacity(
          opacity: _dialVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            if (isDrawerOpen == false)
              const BackButtonFab(),
          
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light) ? Colors.grey.withOpacity(0.8) : Colors.black.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 9,
                    offset:
                        const Offset(0, 0), // changes the position of the shadow
                  ),
                ],
                shape: BoxShape.circle,
              ),
            
            //Menu Fab
            child: SpeedDial(
                
                animatedIcon: AnimatedIcons.menu_close,
                animatedIconTheme:
                    Theme.of(context).iconTheme.copyWith(color: Colors.white),
                animationDuration: const Duration(milliseconds: 500),
                backgroundColor:
                    (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                        ? kColorSecondary
                        : Colors.black,
                spacing: 10,
                overlayColor: Colors.black,
                children: [
            
                  //Copy article fab
                  SpeedDialChild(
                    shape: const CircleBorder(),
                    backgroundColor:
                        (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                            ? kColorSecondary
                            : Colors.black,
            
                    child: const Icon(
                      FontAwesomeIcons.copy,
                      color: Colors.white,
                    ),
            
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Copy Article"),
                            content: SelectableText(
                              widget.stories.content,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: widget.stories.content));
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Copy All")),
                            ],
                          );
                        }
                      );
                    },
                  ),
                  
                  //Share fab
                  SpeedDialChild(
                      child: const Icon(Icons.share, color: Colors.white),
                      onTap: () async {
                        Share.shareUri(Uri.parse(widget.stories.articleLink));
                      },
                      shape: const CircleBorder(),
                      backgroundColor: (AdaptiveTheme.of(context).mode ==
                              AdaptiveThemeMode.dark)
                          ? kColorSecondary
                          : Colors.black
                  ),
            
                  //Font size decrement fab
                  SpeedDialChild(
                    child: const Icon(
                      FontAwesomeIcons.minus,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        if (contentFontSize! > 12.0 && contentFontSize! <= 33.0) {
                          contentFontSize = contentFontSize! - 1;
                        }
                        setFontSize();
                      });
                    },
                    shape: const CircleBorder(),
                    backgroundColor:
                        (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                            ? kColorSecondary
                            : Colors.black,
                  ),
            
                  //Font size increment fab
                  SpeedDialChild(
                    child: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        if (contentFontSize! >= 12.0 && contentFontSize! < 33.0) {
                          contentFontSize = contentFontSize! + 1;
                        }
                        setFontSize();
                      });
                    },
                    shape: const CircleBorder(),
                    backgroundColor:
                        (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark)
                            ? kColorSecondary
                            : Colors.black,
                  ),
            
                  
                ]),
          ),
                ]),
        ),

      

      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
            ),
            
            SliverToBoxAdapter(
              child: Column(
              children: [
                      
                //ImageStory
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.stories.imageURL.toString(),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                    ),
                    Positioned(
                      bottom: 50,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(widget.stories.title,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        right: 0,
                        child: Text(widget.stories.date,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal))),
                    Positioned(
                        bottom: 0,
                        left: -10,
                        child: Text(
                          widget.stories.creator,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.normal),
                        )),
                  ],
                ),
                
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                      
                //Description
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                  child: Text(
                    widget.stories.description,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: contentFontSize! + 2,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                ),
                      
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                      
                //Content
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    widget.stories.content,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: contentFontSize, height: 1.4),
                  ),
                )
              ],
                      ),
            ),
        ]),
      ),
    );
  }
}
