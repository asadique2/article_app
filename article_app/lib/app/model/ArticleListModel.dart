class ArticleListModel {
  ArticleListModel({
    this.totalRecords,
    this.currentPage,
    this.lastPage,
    this.article,
    this.count,
  });

  ArticleListModel.fromJson(dynamic json) {
    totalRecords = json['total_records'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['records'] != null) {
      article = [];
      json['records'].forEach((v) {
        article?.add(Article.fromJson(v));
      });
    }
    count = json['count'];
  }
  int? totalRecords;
  int? currentPage;
  int? lastPage;
  List<Article>? article;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_records'] = totalRecords;
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    if (article != null) {
      map['records'] = article?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }
}

class Article {
  Article({
    this.id,
    this.title,
    this.author,
    this.category,
    this.description,
    this.readTime,
    this.createdAt,
    this.updatedAt,
  });

  Article.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    category = json['category'];
    description = json['description'];
    readTime = json['read_time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? title;
  String? author;
  String? category;
  String? description;
  int? readTime;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['author'] = author;
    map['category'] = category;
    map['description'] = description;
    map['read_time'] = readTime;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
