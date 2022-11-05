import 'Source.dart';

class Article {
    String? author;
    String? content;
    String? description;
    String? publishedAt;
    Source? source;
    String? title;
    String? url;
    String? urlToImage;

    Article({this.author, this.content, this.description, this.publishedAt, this.source, this.title, this.url, this.urlToImage});

    factory Article.fromJson(Map<String, dynamic> json) {
        return Article(
            author: json['author'],
            content: json['content'], 
            description: json['description'], 
            publishedAt: json['publishedAt'], 
            source: json['source'] != null ? Source.fromJson(json['source']) : null, 
            title: json['title'], 
            url: json['url'], 
            urlToImage: json['urlToImage'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['content'] = content;
        data['description'] = description;
        data['publishedAt'] = publishedAt;
        data['title'] = title;
        data['url'] = url;
        data['author'] = author;
        if (source != null) {
            data['source'] = source!.toJson();
        }
        data['urlToImage'] = urlToImage;
        return data;
    }
}