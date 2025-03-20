class ArticleRequestModel {
  ArticleRequestModel({
    this.title,
    this.description,
    this.author,
    this.category,
    this.readTime,
  });

  ArticleRequestModel.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    author = json['author'];
    category = json['category'];
    readTime = json['read_time'];
  }
  String? title;
  String? description;
  String? author;
  String? category;
  int? readTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['author'] = author;
    map['category'] = category;
    map['read_time'] = readTime;
    return map;
  }
}
