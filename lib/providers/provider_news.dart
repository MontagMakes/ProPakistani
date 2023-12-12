import 'package:dawn/models/model_story.dart';
import 'package:dawn/utils/utils.dart';
import 'package:flutter/material.dart';
import '../api_manager.dart';

class NewsProvider with ChangeNotifier {
  List<ModelStory> _stories = [];
  final String _category = "";
  
  List<ModelStory> get stories => _stories;
  

  getNews() async {
    _stories = (await ApiService().getNews(_category));
    notifyListeners();
  }

  setCurrentCategory(int index) async {
    _stories = await ApiService().getNews(linkCategories[index]);
    notifyListeners();
  }

  getStories(){
    return _stories;
  }

  getStoryTitle(int index) {
    return _stories[index].title;
  }

  getStoryArticleLink(int index) {
    return _stories[index].articleLink;
  }

  getStoryDate(int index) {
    return _stories[index].date;
  } 

  getStoryContent(int index) {
    return _stories[index].content;
  } 

  getStoryImageURL(int index) {
    return _stories[index].imageURL.toString();
  }

  getStoryDescription(int index) {
    return _stories[index].description;
  }
}