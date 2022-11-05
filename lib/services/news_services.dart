
import 'package:dio/dio.dart';
import 'package:news/models/response/news_model/NewsModel.dart';
import 'package:news/repositories/news_repo.dart';

import '../helper/constants/api_constants.dart';

class NewsService implements NewsRepo {

  final Dio dio;

  NewsService({required this.dio});

  Options options = Options(
    headers: {
      "Accept":"application/json",
      "X-Api-Key":"cc39988b72fb4a208a12824bef992fb1"
    }
  );


  @override
  Future breakingNewsService(Map<String, dynamic> req) async {
    try{
      Response response = await dio.get(ApiConst.breakingNews, queryParameters: req, options: options);
      NewsModel newsModel = NewsModel.fromJson(response.data);
      return newsModel;
    }catch(e){
      print(e);
    }
  }

  @override
  Future searchNewsService(Map<String, dynamic> req) async {
    try{
      Response response = await dio.get(ApiConst.searchNews, queryParameters: req, options: options);
      NewsModel newsModel = NewsModel.fromJson(response.data);
      return newsModel;
    }catch(e){
      print(e);
    }
  }


}