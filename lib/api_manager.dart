import 'package:dawn/models/model_story.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class ApiService {
  Future<List<ModelStory>> getNews(categoriesTribune) async {
    List<ModelStory> toReturn = [];
    try {
      const baseURL = "https://tribune.com.pk/feed/";
      var response = await Dio().get("$baseURL$categoriesTribune");

      if (response.statusCode == 200) {
        var document = XmlDocument.parse(response.toString());

        var numberOfStories = document.findAllElements("title").length - 1;

        for (var i = 1; i < numberOfStories; i++) {

          var title = document.findAllElements("title").elementAt(i).innerText;
          var articleLink =
              document.findAllElements("link").elementAt(i).innerText;
          var date = document
              .findAllElements("pubDate")
              .elementAt(i)
              .innerText
              .replaceAll(RegExp("([0-9][0-9]:[0-9][0-9]:[0-9][0-9]).*"), '');

          var content = document
              .findAllElements("content:encoded")
              .elementAt(i)
              .innerText;
          var description =
              document.findAllElements("description").elementAt(i).innerText;
          var imageURL =
              document.findAllElements("img").elementAt(i).getAttribute("src");

          toReturn.add(ModelStory(
              title: title,
              articleLink: articleLink,
              date: date,
              content: content,
              imageURL: imageURL,
              description: description));
        }
      }
    } catch (e) {
      print(e);
    }
    return toReturn;
  }
}
