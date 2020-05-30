import 'package:equatable/equatable.dart';
import 'package:macaw/model/news_chunk.dart';

abstract class NewsEvent extends Equatable {
	const NewsEvent();
}

class GetNews extends NewsEvent {

	final List<NewsChunk> news;

	const GetNews(this.news);

	@override
	List<Object> get props => [];
}
