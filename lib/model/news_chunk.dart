import 'package:macaw/model/news.dart';

class NewsChunk {

	String _date;
	List<News> _indiaNews = List();
	List<News> _worldNews = List();

	NewsChunk(this._date, this._indiaNews, this._worldNews);

	String get date => this._date;
	List<News> get indiaNews => this._indiaNews;
	List<News> get worldNews => this._worldNews;

	factory NewsChunk.fromJson(Map<String, dynamic> json) {
		return NewsChunk(
			json['date'] as String,
			json['india'] as List<News>,
			json['world'] as List<News>
		);
	}
}