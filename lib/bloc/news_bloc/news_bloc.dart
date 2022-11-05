import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news/models/response/news_model/NewsModel.dart';
import '../../repositories/news_repo.dart';
import '../event_status.dart';


part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepo newsRepo;
  NewsBloc({required this.newsRepo}) : super(NewsState()) {
    on<NewsInitialEvent>(_newsInitialEvent);
    on<BreakingNewsEvent>(_breakingNewsEvent);
    on<SearchNewsEvent>(_searchNewsEvent);
  }

  FutureOr<void> _newsInitialEvent(NewsInitialEvent event, Emitter<NewsState> emit) {
    emit(state.initialState);
  }

  FutureOr<void> _breakingNewsEvent(BreakingNewsEvent event, Emitter<NewsState> emit) async {
    emit(state.copyWith(breakingNewsStatus: StateLoading()));
    try{
      Map<String, String> req = {};
      req = {
        "country":"in"
      };
      NewsModel newsModel = await newsRepo.breakingNewsService(req);
      emit(state.copyWith(breakingNewsStatus: const StateLoaded(successMessage: "News Recieved"), breakingNewsData: newsModel, searchNewsData: newsModel)); //searchNewsData added to prevent empty screen on opening of search Screen
    }
    catch(e){
      print(e);
      emit(state.copyWith(breakingNewsStatus: const StateFailed(errorMessage: "Error in recieving news")));
    }
  }

  FutureOr<void> _searchNewsEvent(SearchNewsEvent event, Emitter<NewsState> emit) async {
    emit(state.copyWith(searchNewsStatus: StateLoading()));
    try{
      Map<String, String> req = {};
      req = {
        "q":event.searchText
      };
      NewsModel newsModel = await newsRepo.searchNewsService(req);
      emit(state.copyWith(searchNewsStatus: const StateLoaded(successMessage: "News Recieved"), searchNewsData: newsModel));
    }
    catch(e){
      print(e);
      emit(state.copyWith(searchNewsStatus: const StateFailed(errorMessage: "Error in recieving news")));
    }
  }
}
