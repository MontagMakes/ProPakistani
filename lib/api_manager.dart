import 'package:dawn/models/model_story.dart';
import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape_small.dart';
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
          var title = document
              .findAllElements("title")
              .elementAt(i)
              .innerText
              .trimLeft()
              .trimRight();
          var articleLink =
              document.findAllElements("link").elementAt(i).innerText;
          var date = document
              .findAllElements("pubDate")
              .elementAt(i)
              .innerText
              .replaceAll(RegExp("([0-9][0-9]:[0-9][0-9]:[0-9][0-9]).*"), '');

          var content = document
              .findAllElements("content:encoded")
              .elementAt(i - 1)
              .innerText
              .replaceRange(0, 5, '')
              .trimLeft()
              .trimRight();

          content = HtmlUnescape()
              .convert(content)
              .replaceAll(RegExp(r'&([^;]+);'), '');

          var description =
              document.findAllElements("description").elementAt(i).innerText;
          description = description.trimLeft().trimRight();
          var imageURL = document
              .findAllElements("img")
              .elementAt(i - 1)
              .getAttribute("src");
          var creator =
              document.findAllElements("dc:creator").elementAt(i-1).innerText;

          toReturn.add(ModelStory(
              title: title,
              articleLink: articleLink,
              date: date,
              content: content,
              imageURL: imageURL,
              description: description,
              creator: creator));
        }
      }
    } catch (e) {
      print(e);
    }
    return toReturn;
  }
}
