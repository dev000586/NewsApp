import 'Article.dart';

class NewsModel {
    List<Article>? articles;
    String? status;
    int? totalResults;

    NewsModel({this.articles, this.status, this.totalResults});

    factory NewsModel.fromJson(Map<String, dynamic> json) {
        return NewsModel(
            articles: json['articles'] != null ? (json['articles'] as List).map((i) => Article.fromJson(i)).toList() : null, 
            status: json['status'], 
            totalResults: json['totalResults'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['status'] = status;
        data['totalResults'] = totalResults;
        if (articles != null) {
            data['articles'] = articles!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}