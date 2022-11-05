import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news/repositories/news_repo.dart';
import 'package:news/services/news_services.dart';
import 'bloc/news_bloc/news_bloc.dart';
import 'helper/utils/request_interceptors.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Blocks
  serviceLocator.registerFactory(() => NewsBloc(newsRepo: serviceLocator()));


  //Services
  serviceLocator.registerLazySingleton<NewsRepo>(() => NewsService(dio: serviceLocator()));


  //Dio Client
  serviceLocator.registerLazySingleton<Dio>(() => DioClient().provideDio());
}