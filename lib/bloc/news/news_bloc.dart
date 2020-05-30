import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  @override
  NewsState get initialState => InitialNewsState();

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
