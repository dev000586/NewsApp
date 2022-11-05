part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsInitialEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class BreakingNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class SearchNewsEvent extends NewsEvent {
  final String searchText;

  const SearchNewsEvent({required this.searchText});

  @override
  List<Object?> get props => [searchText];
}
