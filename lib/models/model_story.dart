// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelStory {
  String title;
  String articleLink;
  String date;
  String content;
  String? imageURL;
  String description;
  ModelStory({
    required this.title,
    required this.articleLink,
    required this.date,
    required this.content,
    required this.imageURL,
    required this.description,
  });

  ModelStory copyWith({
    String? title,
    String? articleLink,
    String? date,
    String? content,
    String? imageURL,
    String? description,
  }) {
    return ModelStory(
      title: title ?? this.title,
      articleLink: articleLink ?? this.articleLink,
      date: date ?? this.date,
      content: content ?? this.content,
      imageURL: imageURL ?? this.imageURL,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'articleLink': articleLink,
      'date': date,
      'content': content,
      'imageURL': imageURL,
      'description': description,
    };
  }

  factory ModelStory.fromMap(Map<String, dynamic> map) {
    return ModelStory(
      title: map['title'] as String,
      articleLink: map['articleLink'] as String,
      date: map['date'] as String,
      content: map['content'] as String,
      imageURL: map['imageURL'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelStory.fromJson(String source) => ModelStory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ModelStory(title: $title, articleLink: $articleLink, date: $date, content: $content, imageURL: $imageURL, description: $description)';
  }

  @override
  bool operator ==(covariant ModelStory other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.articleLink == articleLink &&
      other.date == date &&
      other.content == content &&
      other.imageURL == imageURL &&
      other.description == description;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      articleLink.hashCode ^
      date.hashCode ^
      content.hashCode ^
      imageURL.hashCode ^
      description.hashCode;
  }
}
