part of 'news_bloc.dart';

class NewsState{
  final StateStatus breakingNewsStatus;
  final StateStatus searchNewsStatus;
  final NewsModel? breakingNewsData;
  final NewsModel? searchNewsData;

  NewsState(
      {this.breakingNewsStatus = const StateNotLoaded(),
      this.searchNewsStatus = const StateNotLoaded(),
      this.breakingNewsData,
      this.searchNewsData});

  NewsState get initialState => NewsState();

  NewsState copyWith({
    final StateStatus? breakingNewsStatus,
    final StateStatus? searchNewsStatus,
    final NewsModel? breakingNewsData,
    final NewsModel? searchNewsData,
  }) {
    return NewsState(
      breakingNewsStatus: breakingNewsStatus ?? this.breakingNewsStatus,
      searchNewsStatus: searchNewsStatus ?? this.searchNewsStatus,
      breakingNewsData: breakingNewsData ?? this.breakingNewsData,
      searchNewsData: searchNewsData ?? this.searchNewsData,
    );
  }

  @override
  String toString() {
    return 'NewsState{breakingNewsStatus: $breakingNewsStatus, searchNewsStatus: $searchNewsStatus, breakingNewsData: $breakingNewsData, searchNewsData: $searchNewsData}';
  }
}
