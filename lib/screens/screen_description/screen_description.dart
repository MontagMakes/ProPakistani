
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenDescription extends StatefulWidget {
  const ScreenDescription({super.key, required this.stories});
  final ModelStory stories;

  @override
  State<ScreenDescription> createState() => _ScreenDescriptionState();
}

class _ScreenDescriptionState extends State<ScreenDescription> {
  
  double? contentFontSize = 16.0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFontSize();
    
  }

  void getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    contentFontSize = prefs.getDouble("contentFontSize") ?? 16.0;
    setState(() {
      
    });
    

  }
    
  void setFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("contentFontSize", contentFontSize!);
  }
  bool isDrawerOpen = false;
  
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme:
            Theme.of(context).iconTheme.copyWith(color: Colors.white),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) ? kColorSecondary : Colors.black,
        spacing: 10,
        overlayColor: Colors.black.withOpacity(0.5),
        
        children: [
          SpeedDialChild(
            
              child: const Icon(Icons.share, color: Colors.white),
              onTap: () async {
                Share.shareUri(Uri.parse(widget.stories.articleLink));
              },
              shape: const CircleBorder(),
              backgroundColor: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) ? kColorSecondary : Colors.black),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.minus, color: Colors.white,),
            onTap: () {
              setState(() {
                if(contentFontSize! > 12.0 && contentFontSize! <= 33.0) {
                  contentFontSize = contentFontSize! - 1;
                }
                setFontSize();
              });
            },
            shape: const CircleBorder(),
            backgroundColor: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) ? kColorSecondary : Colors.black,
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.plus, color: Colors.white,),
            onTap: () {
              setState(() {
                if(contentFontSize! >= 12.0 && contentFontSize! < 33.0) {
                  contentFontSize = contentFontSize! + 1;
                }
                  setFontSize();
              });
            },
            shape: const CircleBorder(),
            backgroundColor: (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) ? kColorSecondary : Colors.black,
          )
        ],
      ),


      appBar: AppBar(),


      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 0,
                    child: Text(widget.stories.date,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white))),
                Positioned(
                    bottom: 0,
                    left: -10,
                    child: Text(
                      widget.stories.creator,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              child: Text(
                widget.stories.description,
                
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: contentFontSize!+2, fontWeight: FontWeight.w600, height: 1.4),
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
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: contentFontSize,height: 1.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
