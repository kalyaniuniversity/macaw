import 'package:equatable/equatable.dart';
import 'package:macaw/model/news_chunk.dart';

abstract class NewsState extends Equatable {
	const NewsState();
}

class InitialNewsState extends NewsState {

	const InitialNewsState();

	@override
	List<Object> get props => [];
}

class NewsLoadingState extends NewsState {

	const NewsLoadingState();

	@override
	List<Object> get props => [];
}

class NewsChunksLoadedState extends NewsState {

	final List<NewsChunk> _newsChunks;

	const NewsChunksLoadedState(this._newsChunks);

	List<NewsChunk> get news => this._newsChunks;

	@override
	List<Object> get props => [];
}

class NewsChunkErrorState extends NewsState {

	final String _errorMessage;

	const NewsChunkErrorState(this._errorMessage);

	String get errorMessage => this._errorMessage;

	@override
	List<Object> get props => [_errorMessage];
}
