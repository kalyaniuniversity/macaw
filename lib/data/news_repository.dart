import 'package:macaw/model/news_chunk.dart';

abstract class NewsRepository {
	Future<List<NewsChunk>> fetchNews();
}

class NewsData implements NewsRepository {

	List<NewsChunk> _newsChunks = List();

	@override
	Future<List<NewsChunk>> fetchNews() {
		return Future.delayed(
			Duration(seconds: 2),
			() {
				return this._newsChunks;
			}
		);
	}
}