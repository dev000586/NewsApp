
abstract class NewsRepo {
  Future breakingNewsService(Map<String, dynamic> req);
  Future searchNewsService(Map<String, dynamic> req);
}