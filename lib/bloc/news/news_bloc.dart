import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:macaw/data/news_repository.dart';
import 'package:macaw/service/network_service.dart';
import 'bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

	final NewsRepository _newsRepository;

	NewsBloc(this._newsRepository);

	@override
	NewsState get initialState => InitialNewsState();

	@override
	Stream<NewsState> mapEventToState(
	NewsEvent event,
	) async* {

		yield NewsLoadingState();

		if(event is GetNewsChunks) {
			try {
				yield NewsChunksLoadedState(await _newsRepository.fetchNews());
			} on NetworkError catch(e) {
				yield NewsChunkErrorState(NetworkError.resolveErrorCode(e.code));
			} on Error {
				yield NewsChunkErrorState("Something went wrong!");
			}
		}
	}
}
