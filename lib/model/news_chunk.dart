import 'dart:convert';

import 'package:macaw/model/news.dart';
import 'package:macaw/service/constant.dart';

class NewsChunk {

	String _date;
	List<News> _indiaNews = List();
	List<News> _worldNews = List();

	NewsChunk(this._date, this._indiaNews, this._worldNews);

	factory NewsChunk.fromJson(dynamic jsonBlob) {

		String date = jsonBlob[Constant.DATE] as String;
		List<dynamic> indiaJson = jsonBlob[Constant.INDIA_SMALL];
		List<dynamic> worldJson = jsonBlob[Constant.WORLD_SMALL];
		List<News> indiaNews = List();
		List<News> worldNews = List();
		
		for(dynamic item in indiaJson)
			indiaNews.add(News.fromJson(date, Constant.INDIA, item));

		for(dynamic item in worldJson)
			worldNews.add(News.fromJson(date, Constant.WORLD, item));

		return NewsChunk(
			date,
			indiaNews,
			worldNews
		);
	}

	String get date => this._date;
	List<News> get indiaNews => this._indiaNews;
	List<News> get worldNews => this._worldNews;
	int get newsCount => this._indiaNews.length + this._worldNews.length;
}