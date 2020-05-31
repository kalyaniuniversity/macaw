import 'package:equatable/equatable.dart';
import 'package:macaw/model/news_chunk.dart';

abstract class NewsEvent extends Equatable {
	const NewsEvent();
}

class GetNewsChunks extends NewsEvent {

	const GetNewsChunks();

	@override
	List<Object> get props => [];
}
